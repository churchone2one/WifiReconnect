
# Wifi Reconnect Helper

We use a number of Windows Machines as self serve kiosks. On occasion they drop from the Wifi network. This little helper tool is designed to attempt to reconnect them when they don't auto discover the network for themselves.

## Features

- Simple Powershell Script
- Easily convertable into an .exe with the help of ps2exe (https://github.com/MScholtes/PS2EXE)

## Installation

You can run this tool in two ways: as a pre-built .exe file or as a PowerShell script. Here's how to set it up.

### Option 1: Using the .exe Version

1. **Create a folder** for the tool, e.g., `C:\apps\WifiReconnect\`.
2. **Copy the executable** `wifi-reconnect.exe` into this folder.
3. **Copy the configuration file** `config-sample.ini` and rename it to `config.ini`.
4. **Edit** `config.ini` **file** to update the Wi-Fi SSID. (Make sure Windows has already authenticated to the network.)
Set the tool to run at startup using your preferred method (e.g., Task Scheduler, Startup folder).

### Option 2: Using the PowerShell Script

1. **Create a folder** for the tool, e.g., `C:\apps\WifiReconnect\`.
Copy the script wifi-reconnect.ps1 into this folder.
Copy the configuration file config-sample.ini and rename it to config.ini.
Edit the config.ini file to update the Wi-Fi SSID. (Make sure Windows has already authenticated to the network.)
Set the script to run at startup using your preferred method (e.g., Task Scheduler, Startup folder).

### Option 3: Building Your Own .exe from the PowerShell Script

1. **Download this repository** and extract it to a folder for the tool, e.g., `C:\apps\WifiReconnect\` (or use git clone to copy the repository).
2. **Open PowerShell** and run the script `helpers\tool-ps2exe.ps1`. When prompted for a path, use `..\wifi-reconnect.ps1`.
3. After the conversion is complete, follow the instructions from **Option 1: Using the .exe Version** to set up and run the tool.


## Issue running Powershell script

By default Windows prevents the running of a Powershell script.
You have a couple of options

1. Use the .exe file (or generate your own .exe)
2. Change the Execution Policy on the machine to allow running of the script:
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4
3. Create a self signed certifcate to authenicate the script so that you can set the Execution Policy to a semi-restricted 'Remote Signed' mode, rather than 'Unrestricted'.


## Possible Roadmap

The current version fully meets the needs for its intended task. However, in the future, the following features might be useful and could be added as necessary:

- Configurable retry interval in config.ini
- Basic logging functionality