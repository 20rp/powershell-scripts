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
    $Host.ui.rawui.backgroundcolor = "black"
    $Host.ui.rawui.foregroundcolor = "cyan"
    $hostversion="$($Host.Version.Major)`.$($Host.Version.Minor)"
    $Host.UI.RawUI.WindowTitle = "PowerShell $hostversion"
    Clear-Host
}

# Customize the prompt for the console.
function prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
    $time = Get-Date -Format "HH:mm:ss"

    $(if ($principal.IsInRole($adminRole)) { 
            "[ADMIN][$env:COMPUTERNAME] $($time)  $(Get-Location) > "
        }
        else 
        { 
            "[$env:COMPUTERNAME] $($time) $(Get-Location) > " 
        }
    )
}

prompt
Color-Console
  
function hosts {
    Start-Process "C:/Windows/System32/Drivers/etc"
}

function Start-Script {
    Start-Process -FilePath "Spotify"
    Start-Process "C:\Program Files\Mozilla Firefox\firefox.exe"
    Start-Process "C:\Program Files (x86)\Deluge\deluge.exe"
}

function admin {
    if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
    {  
      $arguments = "& '" +$myinvocation.mycommand.definition + "'"
      Start-Process powershell -Verb runAs -ArgumentList $arguments
      Break
    }
}

function k ($process) {
    Stop-Process -Name $process
}

## Check git status for repo. 
function status {
    git status
}

function add {
    git add .
}

function commit($msg) {
    
    git commit -m "$($msg)"
}

function push {
    git push
}

## Reload Profile script. Not working currently
function reload {
    $pwd = Get-Location
    cd $PSHOME
    Invoke-Expression .\profile.ps1
    cd $pwd
}

## Copy C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1 to git repo.
function Copy-Profile {
    $pwd = Get-Location
    $code = "$($HOME)\code\git\powershell-scripts\"

    cd $PSHOME
    Copy-Item "Profile.ps1" -Destination "$($HOME)\code\git\powershell-scripts\profile.ps1" -Force
    cd $code
} 