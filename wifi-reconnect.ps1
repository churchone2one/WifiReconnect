# Get the directory of the current script
# $scriptPath = $MyInvocation.MyCommand.Path
# When compiled with PS2EXE the variable MyCommand contains no path anymore

if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript")
{ # Powershell script
	$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
}
else
{ # PS2EXE compiled script
	$scriptDir = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

# Initialize $config as a hashtable
$config = @{}

# Load the INI file
$iniFile = Join-Path $scriptDir 'config.ini'
Get-Content $iniFile | ForEach-Object {
    if ($_ -match '^\s*\[(.+)\]\s*$') {
        $section = $matches[1]
    } elseif ($_ -match '^\s*(.+?)\s*=\s*(.+?)\s*$' -and $section -eq 'WiFi') {
        $config[$matches[1]] = $matches[2]
    }
}

# Define the SSID of the Wi-Fi network from the INI file
$wifiSSID = $config['SSID']

# Function to check if connected to the correct Wi-Fi
function Check-WifiConnection {
    $connection = netsh wlan show interfaces | Select-String -Pattern "SSID\s*:\s*$wifiSSID"

    if ($connection) {
        Write-Host "Connected to $wifiSSID"
    } else {
        Write-Host "Not connected to $wifiSSID, trying to reconnect..."
        netsh wlan connect name=$wifiSSID
    }
}

# Infinite loop to check every 30 seconds
while ($true) {
    Check-WifiConnection
    Start-Sleep -Seconds 30
}

