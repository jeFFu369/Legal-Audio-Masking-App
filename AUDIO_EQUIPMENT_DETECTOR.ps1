# AUDIO_EQUIPMENT_DETECTOR.ps1
# Identifies potential audio equipment based on MAC addresses and network behavior
# Compatible with Windows PowerShell 5.1+ and PowerShell Core

Write-Host "=== Audio Equipment Detector ===" -ForegroundColor Cyan
Write-Host "WARNING: Unauthorized access to systems may be illegal."
Write-Host "Use only on systems you have permission to scan."
Write-Host "================================"

# Common audio equipment OUI (Organizationally Unique Identifiers)
$audioOUI = @(
    "00:11:22",  # TOA Corporation
    "00:1B:1B",  # TOA Corporation
    "00:0F:66",  # TOA Corporation
    "00:0F:67",  # TOA Corporation
    "00:0A:5A",  # Bosch Security Systems
    "00:10:49",  # Bosch Security Systems
    "00:1B:57",  # Bosch Security Systems
    "00:1E:67",  # Monacor International
    "00:22:07",  # Monacor International
    "5C:CF:7F",  # ESP8266/ESP32 devices (common in DIY audio systems)
    "3C:71:BF",  # ESP8266/ESP32 devices
    "AC:67:B2",  # ESP8266/ESP32 devices
    "BC:DD:C2",  # ESP8266/ESP32 devices
    "00:13:EF",  # Realtek (used in many audio devices)
    "00:1A:8C",  # Realtek
    "00:0D:61",  # Yamaha Corporation
    "00:16:66",  # Pioneer Corporation
    "00:08:9B",  # Denon
    "00:11:06"   # Harman International
)

# Get all network interfaces
Write-Host "Scanning all network interfaces..." -ForegroundColor Green
$networkInterfaces = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

foreach ($interface in $networkInterfaces) {
    Write-Host "\nInterface: $($interface.Name) ($($interface.InterfaceDescription))" -ForegroundColor Cyan
    
    # Get ARP table for this interface
    try {
        $arpTable = arp -a -N $interface.InterfaceIndex | Where-Object {$_ -match "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"}
        
        if ($arpTable) {
            Write-Host "  Found $($arpTable.Count) devices on this interface" -ForegroundColor Green
            
            foreach ($entry in $arpTable) {
                $parts = $entry -split '\s+' | Where-Object {$_}
                if ($parts.Count -ge 2) {
                    $ip = $parts[0]
                    $mac = $parts[1]
                    
                    # Check if MAC matches audio equipment OUI
                    $oui = $mac.Substring(0, 8).ToUpper()
                    
                    if ($audioOUI -contains $oui) {
                        Write-Host "  ALERT: Potential audio device detected!" -ForegroundColor Red
                        Write-Host "    IP: $ip"
                        Write-Host "    MAC: $mac"
                        Write-Host "    OUI: $oui"
                        
                        # Try to identify the manufacturer
                        $manufacturer = switch -Wildcard ($oui) {
                            "00:11:22*" { "TOA Corporation" }
                            "00:1B:1B*" { "TOA Corporation" }
                            "00:0F:66*" { "TOA Corporation" }
                            "00:0F:67*" { "TOA Corporation" }
                            "00:0A:5A*" { "Bosch Security Systems" }
                            "00:10:49*" { "Bosch Security Systems" }
                            "00:1B:57*" { "Bosch Security Systems" }
                            "00:1E:67*" { "Monacor International" }
                            "00:22:07*" { "Monacor International" }
                            "5C:CF:7F*" { "ESP8266/ESP32 Device" }
                            "3C:71:BF*" { "ESP8266/ESP32 Device" }
                            "AC:67:B2*" { "ESP8266/ESP32 Device" }
                            "BC:DD:C2*" { "ESP8266/ESP32 Device" }
                            "00:13:EF*" { "Realtek" }
                            "00:1A:8C*" { "Realtek" }
                            "00:0D:61*" { "Yamaha Corporation" }
                            "00:16:66*" { "Pioneer Corporation" }
                            "00:08:9B*" { "Denon" }
                            "00:11:06*" { "Harman International" }
                            default { "Unknown Audio Equipment Manufacturer" }
                        }
                        
                        Write-Host "    Manufacturer: $manufacturer" -ForegroundColor Cyan
                        
                        # Try to get hostname
                        try {
                            $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
                            Write-Host "    Hostname: $hostname" -ForegroundColor Cyan
                        } catch {
                            Write-Host "    Hostname: Not resolvable" -ForegroundColor Yellow
                        }
                    }
                }
            }
        } else {
            Write-Host "  No devices found on this interface" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "  Error scanning ARP table: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "\n=== Additional Detection Methods ===" -ForegroundColor Cyan
Write-Host "1. Look for wireless SSIDs related to audio systems (e.g., 'TOA-PA', 'BOSCH-PA', 'Audio-System')"
Write-Host "2. Check for devices with default PA system credentials (admin/admin, admin/1234)"
Write-Host "3. Listen for network traffic on ports 80, 443, 554, 8000, 8080"
Write-Host "4. Monitor for multicast traffic (SAP, RTSP, mDNS)"

Write-Host "\n=== Detection Complete ===" -ForegroundColor Cyan
Write-Host "Next steps:"
Write-Host "1. Verify detected devices with physical inspection"
Write-Host "2. Cross-reference with your PA system reconnaissance"
Write-Host "3. Use PA_SYSTEM_SCANNER.ps1 for more detailed scanning"
Write-Host "4. Always obtain proper authorization before accessing systems"
