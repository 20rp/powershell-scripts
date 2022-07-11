# Checks to see if the profile file exists already to avoid overwrite.
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# Allows for easy accessing of Profile file.
function Pro {
    code $PROFILE.AllUsersAllHosts
}

# Function for listing aliases of a cmdlet.
function Get-CmdletAlias ($cmdletname) {
    Get-Alias |
        Where-Object -FilterScript {$_.Definition -like "$cmdletname"} |
            Format-Table -Property Definition, Name -AutoSize
}

# Customize Console.
function Color-Console {
    $Host.ui.rawui.backgroundcolor = 8
    $Host.ui.rawui.foregroundcolor = 13
    $hosttime = (Get-ChildItem -Path $PSHOME\PowerShell.exe).CreationTime
    $hostversion="$($Host.Version.Major)`.$($Host.Version.Minor)"
    $Host.UI.RawUI.WindowTitle = "PowerShell $hostversion ($hosttime)"
    Clear-Host
}

Color-Console
  
function hosts {
    Start-Process "C:/Windows/System32/Drivers/etc"
}

function Start-Script {
    Start-Process -FilePath "Spotify"
    Start-Process "C:\Program Files\Mozilla Firefox\firefox.exe"
    Start-Process "C:\Program Files (x86)\Deluge\deluge.exe"
}

function sm {
    Stop-Process -Name "Messenger"
}

function admin {
    Start-Process -WindowStyle hidden powershell -Verb runAs
}

## Check git status for repo. 
function status {
    git status
}

## Reload Profile script.
function reload {
    Invoke-Command $profile
}

## Copy C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1 to git repo.
function Copy-Profile {
    Invoke-Command -RunAsAdministrator Copy-Item -Path "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1" -Destination "$($HOME)\code\git\powershell-scripts\profile.ps1"
}