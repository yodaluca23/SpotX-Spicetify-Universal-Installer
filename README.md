# SpotX-Spicetify-Universal-Installer

This script installs and configures Spotify with SpotX and Spicetify on both Windows and macOS (Linux kind of Beta, doesn't really work right now) systems. Follow the instructions below to run the script on your respective operating system.

## Prerequisites

### MacOS
1. Install PowerShell 7 with Homebrew:
   ```
   brew install PowerShell
   ```

### Windows
1. Install PowerShell 7 with winget:
   ```
   winget install --id Microsoft.Powershell --source winget
   ```

## Running the Script

1. Open PowerShell 7.
2. Run the following command:
   ```
   iex "& { $(iwr -useb 'https://raw.githubusercontent.com/yodaluca23/SpotX-Spicetify-Universal-Installer/main/Installer.ps1') }"
   ```

### Parameters

- `-clean`: This parameter performs a clean install of Spotify, first uninstalling it and then running the main patching scripts.

#### Example
To run the script with the `-clean` parameter:
```
iex "& { $(iwr -useb 'https://raw.githubusercontent.com/yodaluca23/SpotX-Spicetify-Universal-Installer/main/Installer.ps1') } -clean"
```

## Earlier Revisions

Previous versions of this script are available [here](https://github.com/yodaluca23/Random-Crap/blob/main/Spotify.ps1).
