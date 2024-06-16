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

## Scripts Used

### Windows

- **Uninstall Spotify**: [Uninstall-Spotify.bat](https://raw.githubusercontent.com/amd64fox/Uninstall-Spotify/main/Uninstall-Spotify.bat)
- **SpotX Installation**: [Install_New_theme.bat](https://raw.githubusercontent.com/SpotX-Official/SpotX/main/Install_New_theme.bat)
- **Spicetify Installation**: [install.ps1](https://raw.githubusercontent.com/spicetify/cli/main/install.ps1)

### macOS/Linux

- **Uninstall Spotify**: [uninstallify.sh](https://gist.github.com/jetfir3/f620e44fc246c1bed45ed040bbfa2d68/raw/uninstallify.sh)
- **SpotX Installation**: [run.sh](https://spotx-official.github.io/run.sh)
- **Spicetify Installation**: [install.sh](https://raw.githubusercontent.com/spicetify/cli/main/install.sh)

## Credits

This script combines the work of various authors to provide an all-in-one solution. Credits for the original scripts go to:

- **Uninstall Spotify (Windows)**: [amd64fox](https://github.com/amd64fox)
- **SpotX Installation (Windows)**: [SpotX-Official](https://github.com/SpotX-Official)
- **Spicetify Installation (Windows)**: [spicetify](https://github.com/spicetify)
- **Uninstall Spotify (macOS/Linux)**: [jetfir3](https://gist.github.com/jetfir3)
- **SpotX Installation (macOS/Linux)**: [SpotX-Official](https://spotx-official.github.io)
- **Spicetify Installation (macOS/Linux)**: [spicetify](https://github.com/spicetify)

This script simply combines their work into a unified installation process. All credit goes to the original authors.

## Earlier Revisions

Previous versions of this script are available [here](https://github.com/yodaluca23/Random-Crap/blob/main/Spotify.ps1).
