# This script is available at https://github.com/yodaluca23/SpotX-Spicetify-Universal-Installer
# To run on MacOS Install PowerShell 7 with "brew install PowerShell". To run on Win install PowerShell 7 with "winget install --id Microsoft.Powershell --source winget".
# To run Open PowerShell 7 and run "iex "& { $(iwr -useb 'https://raw.githubusercontent.com/yodaluca23/SpotX-Spicetify-Universal-Installer/main/Installer.ps1') }""
# Parameters include "-clean" which will perform a clean install of Spotify, first uninstalling and then running the main patching scripts.
# Parameter example "iex "& { $(iwr -useb 'https://raw.githubusercontent.com/yodaluca23/SpotX-Spicetify-Universal-Installer/main/Installer.ps1') } -clean""
# Ealier revisions of this script are available here: https://github.com/yodaluca23/Random-Crap/blob/main/Spotify.ps1

param (
    [Parameter()]
    [switch]$clean
)

# Function to run Windows scripts
function Run-WindowsScripts {
    Write-Output "Running on Windows"

    if ($clean) {
        Write-Output "Uninstalling Spotify..."
        $uninstallScriptUrl = "https://raw.githubusercontent.com/amd64fox/Uninstall-Spotify/main/Uninstall-Spotify.bat"
        $uninstallScriptPath = "$env:TEMP\Uninstall-Spotify.bat"
        Invoke-WebRequest -Uri $uninstallScriptUrl -OutFile $uninstallScriptPath
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c $uninstallScriptPath" -Wait
    }

    # Download and run the SpotX-Win batch script
    $batchScriptUrl = "https://raw.githubusercontent.com/SpotX-Official/SpotX/main/Install_New_theme.bat"
    $batchScriptPath = "$env:TEMP\Install_New_theme.bat"
    Invoke-WebRequest -Uri $batchScriptUrl -OutFile $batchScriptPath
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c $batchScriptPath" -Wait

    # Open Spotify
    $spotifyDirectory = Join-Path $env:APPDATA 'Spotify'
    $spotifyDirectory2 = Join-Path $env:LOCALAPPDATA 'Spotify'
    $spotifyExecutable = Join-Path $spotifyDirectory 'Spotify.exe'
    Start-Process -FilePath $spotifyExecutable
    Write-Output "Openning the Spotify Application for 30 seconds to avoid conflicts with the Spicetify installation. If it does not open automatically please open it manually."
    Start-Sleep -Seconds 30
    Stop-Process -Name "Spotify" -Force -ErrorAction SilentlyContinue

    # Run the Spicetify-Win installation script
    $psScriptUrl = "https://raw.githubusercontent.com/spicetify/cli/main/install.ps1"
    Invoke-Expression (Invoke-WebRequest -Uri $psScriptUrl -UseBasicParsing).Content
}

# Function to run macOS/Linux scripts
function Run-UnixScripts {
    if ($IsMacOS) {
        Write-Output "Running on MacOS"
    }
    if ($IsLinux) {
        Write-Output "Running on Linux"
    }

    if ($clean) {
        Write-Output "Uninstalling Spotify..."
        $uninstallScript = "bash <(curl -sSL https://gist.github.com/jetfir3/f620e44fc246c1bed45ed040bbfa2d68/raw/uninstallify.sh)"
        bash -c "$uninstallScript"
    }

    # Run the SpotX-Bash installation script
    if ($IsMacOS) {
        $spotxScript = "bash <(curl -sSL https://spotx-official.github.io/run.sh) --installmac -i"
    } ElseIf ($IsLinux) {
        $spotxScript = "bash <(curl -sSL https://spotx-official.github.io/run.sh) --installdeb -i"
    }
    bash -c "$spotxScript"

    # Open Spotify
    Start-Process -FilePath "open" -ArgumentList "spotify://open"
    Write-Output "Openning the Spotify Application for 30 seconds to avoid conflicts with the Spicetify installation. If it does not open automatically please open it manually."
    Start-Sleep -Seconds 30
    pkill -f "Spotify"

    # Run the Spicetify-Bash installation script
    $spicetifyScript = "curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh"
    bash -c "$spicetifyScript"
}

# Function to clean up temporary files
function Cleanup {
    # Delete Install_New_theme.bat
    $batchScriptPath = "$env:TEMP\Install_New_theme.bat"
    if (Test-Path $batchScriptPath) {
        Remove-Item $batchScriptPath -Force
    }
    
    # Delete spicetify.zip
    $spicetifyZipPath = "$env:TEMP\spicetify.zip"
    if (Test-Path $spicetifyZipPath) {
        Remove-Item $spicetifyZipPath -Force
    }

    # Delete Uninstall-Spotify.bat if it was downloaded
    $uninstallScriptPath = "$env:TEMP\Uninstall-Spotify.bat"
    if (Test-Path $uninstallScriptPath) {
        Remove-Item $uninstallScriptPath -Force
    }
}

function UnsupportedOS {
    Write-Output "Your running an Unsupported OS. The currently supported Operating systems for this script include Windows, MacOS, and Linux."
    Exit 1
}

# Set OS variables if on unsupported version
if ($PSVersionTable.PSVersion.Major -lt 7) {
    [bool] $IsMacOS = $IsLinux = $IsWindows = $false
}

"IsWindows: $IsWindows"
"IsMacOS: $IsMacOS"
"IsLinux: $IsLinux"

# Ask user for OS if cannot detect
if ($IsMacOS -eq $false -and $IsLinux -eq $false -and $IsWindows -eq $false) {
    $os = Read-Host 'What operating system is this? Windows (w), MacOS (m), Linux (l), or Other (o)?'
    if ($os -eq 'w' -or 'W') {
    [bool] $IsWindows = $true
    }
    if ($os -eq 'm' -or 'M') {
    [bool] $IsMacOS = $true
    }
    if ($os -eq 'l' -or 'L') {
    [bool] $IsLinux = $true
    }
    if ($os -eq 'o' -or 'O') {
    UnsupportedOS
    }
    Write-Output "Tip: Install PowerShell 7 or newer to skip this prompt next time."
}

# Main script execution
if ($IsWindows) {
    Run-WindowsScripts
} elseif ($IsMacOS -or $IsLinux) {
    Run-UnixScripts
} else {
    UnsupportedOS
}
# Clean up temporary files
Cleanup
Return
