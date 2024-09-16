param(
    [Parameter(Mandatory=$true)]
    [string]$ScriptPath,

    [string]$ExeOutputPath = ""
)

$ScriptPath = Resolve-Path $ScriptPath

# Check if the PS2EXE module is installed
if (-not (Get-Module -ListAvailable -Name PS2EXE)) {
    Write-Host "PS2EXE module is not installed. Installing..."
    Install-Module -Name PS2EXE -Scope CurrentUser -Force
}

# Check if the script exists
if (-not (Test-Path -Path $ScriptPath)) {
    Write-Host "The script at path $ScriptPath does not exist."
    exit
}

# Set the output path for the exe file
if ($ExeOutputPath -eq "") {
    $ExeOutputPath = [System.IO.Path]::ChangeExtension($ScriptPath, ".exe")
}

# Import the PS2EXE module
Import-Module PS2EXE

# Convert the PowerShell script to an exe file
Invoke-PS2EXE $ScriptPath $ExeOutputPath -NoConsole -Verbose -noOutput

Write-Host "The script has been successfully converted to an executable: $ExeOutputPath"