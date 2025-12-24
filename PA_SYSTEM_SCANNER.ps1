# PA_SYSTEM_SCANNER.ps1
# Scans for networked PA systems and common vulnerabilities
# Compatible with Windows PowerShell 5.1+ and PowerShell Core

Write-Host "=== Networked PA System Scanner ===" -ForegroundColor Cyan
Write-Host "WARNING: Unauthorized access to systems may be illegal."
Write-Host "Use only on systems you have permission to scan."
Write-Host "===================================="

# Check if nmap is installed
if (-not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "nmap not found. Would you like to install it via Chocolatey? (Y/N)" -ForegroundColor Yellow
    $installChoice = Read-Host
    
    if ($installChoice -eq "Y" -or $installChoice -eq "y") {
        Write-Host "WARNING: nmap installation requires administrator privileges." -ForegroundColor Red
        Write-Host "Please ensure you're running PowerShell as Administrator." -ForegroundColor Yellow
        Write-Host "Press any key to continue installation attempt..." -ForegroundColor Yellow
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        try {
            Write-Host "Installing Chocolatey and nmap..." -ForegroundColor Green
            
            # Install Chocolatey
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            
            # Install nmap
            choco install nmap -y
            
            # Refresh environment variables
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
            
            if (Get-Command nmap -ErrorAction SilentlyContinue) {
                Write-Host "nmap installed successfully!" -ForegroundColor Green
            } else {
                Write-Host "nmap installation failed. Manual installation required." -ForegroundColor Red
                Write-Host "Download nmap from: https://nmap.org/download.html" -ForegroundColor Cyan
                exit 1
            }
        } catch {
            Write-Host "Installation error: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "Please install nmap manually from: https://nmap.org/download.html" -ForegroundColor Cyan
            exit 1
        }
    } else {
        Write-Host "nmap is required for scanning. Exiting." -ForegroundColor Red
        exit 1
    }
}

# Get local network range
Write-Host "Detecting local network..." -ForegroundColor Green

# Get active network interface connected to the internet
$activeInterface = Get-NetConnectionProfile | Where-Object {$_.IPv4Connectivity -eq 'Internet' -or $_.IPv6Connectivity -eq 'Internet'}

if ($activeInterface) {
    $localIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias $activeInterface.InterfaceAlias).IPAddress
    $subnet = $localIP -replace '\d+$','0/24'
    Write-Host "Local network: $subnet" -ForegroundColor Green
} else {
    # Fallback to common home network range
    $subnet = "192.168.1.0/24"
    Write-Host "Could not detect network automatically. Using fallback: $subnet" -ForegroundColor Yellow
}

# Scan for all devices
Write-Host "Scanning for devices on network..." -ForegroundColor Green
$scanResults = nmap -sn $subnet
$devices = $scanResults | Select-String -Pattern "Nmap scan report for"

Write-Host "Found $($devices.Count) devices on the network" -ForegroundColor Green

# PA-related ports to scan
$paPorts = "80,443,554,8000,8080,23,22,8888"

# Common PA system manufacturers and keywords
$paKeywords = @("TOA", "Bosch", "Monacor", "PA System", "Amplifier", "Speaker", "Audio", "ESP32", "ESP8266", "Shairport", "Icecast")

# Scan each device for PA-related ports and services
foreach ($device in $devices) {
    $ip = $device -replace 'Nmap scan report for ',''
    Write-Host "\nScanning $ip..." -ForegroundColor Gray
    
    # Scan for open ports
    $portScan = nmap -p $paPorts $ip
    $openPorts = $portScan | Select-String -Pattern "open"
    
    if ($openPorts) {
        Write-Host "  OPEN PORTS:" -ForegroundColor Yellow
        foreach ($port in $openPorts) {
            Write-Host "    $port" -ForegroundColor Yellow
        }
        
        # Try to get device hostname
        try {
            $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
            Write-Host "  HOSTNAME: $hostname" -ForegroundColor Cyan
            
            # Check if hostname contains PA-related keywords
            foreach ($keyword in $paKeywords) {
                if ($hostname -match $keyword -or $hostname -match $keyword.ToLower()) {
                    Write-Host "  ALERT: Potential PA system detected in hostname!" -ForegroundColor Red
                    break
                }
            }
        } catch {
            # Ignore DNS errors
        }
        
        # Check for web interface
        foreach ($port in $openPorts) {
            $portNumber = ($port -split '/')[0]
            
            if ($portNumber -in @(80, 443, 8000, 8080, 8888)) {
                $protocol = if ($portNumber -eq 443) {"https"} else {"http"}
                $url = "{0}://{1}:{2}" -f $protocol, $ip, $portNumber
                
                try {
                    Write-Host "  Checking web interface at $url..." -ForegroundColor Gray
                    $response = Invoke-WebRequest -Uri $url -TimeoutSec 3 -UseBasicParsing -ErrorAction Stop
                    
                    # Check if response contains PA-related keywords
                    $content = $response.Content -join " "
                    $title = $response.ParsedHtml.title 2>$null
                    
                    foreach ($keyword in $paKeywords) {
                        if ($content -match $keyword -or ($title -and $title -match $keyword)) {
                            Write-Host "  ALERT: PA system web interface detected!" -ForegroundColor Red
                            Write-Host "  URL: $url" -ForegroundColor Red
                            if ($title) {
                                Write-Host "  TITLE: $title" -ForegroundColor Red
                            }
                            break
                        }
                    }
                } catch {
                    # Ignore web request errors
                }
            }
        }
        
        # Check for RTSP (common in IP cameras and audio streaming)
        if ($openPorts -match "554/tcp") {
            Write-Host "  RTSP port open - potential audio/video streaming" -ForegroundColor Magenta
        }
        
        # Check for Telnet/SSH
        if ($openPorts -match "23/tcp") {
            Write-Host "  Telnet port open - potential remote control" -ForegroundColor Magenta
        }
        
        if ($openPorts -match "22/tcp") {
            Write-Host "  SSH port open - potential remote control" -ForegroundColor Magenta
        }
    }
}

Write-Host "\n=== Scan Complete ===" -ForegroundColor Cyan
Write-Host "Summary of findings:" -ForegroundColor Green
Write-Host "- Devices with open ports 80/443 may have web interfaces"
Write-Host "- Port 554 indicates RTSP streaming capabilities"
Write-Host "- Ports 22/23 provide remote access possibilities"
Write-Host "- Look for devices with PA-related keywords in hostnames/titles"
Write-Host "\nNext steps:"
Write-Host "1. Check identified web interfaces for PA control panels"
Write-Host "2. Try common default credentials (admin/admin, admin/1234)"
Write-Host "3. Look for volume/muting controls or input source selection"
Write-Host "4. Always backup configurations before making changes"
