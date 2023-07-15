# DesktopCleanup.sh

A self-automating bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

The purpose of this script is to perform general cleanup of your Desktop in a way that can be automated.  As of **Version 1.2**, DesktopCleanup.sh schedules itself to run every 15 minutes as a `crontab` job.

DesktopCleanup.sh moves all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to ~/Music/Unsorted, video will be moved to ~/Videos/Unsorted, etc).  It also uses `perl` to bulk rename files with foreign characters found in MacOS filenames and `ffmpeg` to convert less popular lossy file formats into more universal and less lossy (or lossless) file formats.  Below is a complete list of features:

- [x] Tested on **Linux Mint 21.1**.

## Requirements
This script requires the following dependencies:
- `ffmpeg` (file conversion)
- `perl` (file renaming)

- They can be installed on Debian-based distros with the following Terminal command:
```
sudo apt install ffmpeg perl
```

## Features
- **Automates** itself as a `crontab` job to run every 15 minutes
- **Renames** files with foreign MacOS characters
- **Installs** `.otf` & `.ttf` fonts to _~/.local/share/fonts_
- **Converts**
  - `.avif`, `.bmp`, `.webp` pictures to `.png`
  - `.m4a` & `.mpga` audio to `.wav`
  - `.divx`, `.flv`, `.mov`, `.mpg`, `.webm` video to `.mp4`
- **Moves**
  - `.ctb`, `.doc`, `.html`, `.pdf`, `.rtf`, `.txt`, `.xlsx` documents to _~/Documents/Unsorted_
  - "screenshots" to _~/Pictures/Unsorted/Screenshots_
  - `.gif`, `.jpg`, `.jpeg`, `.png` pictures to _~/Pictures/Unsorted_
  - `.psd` files to _~/Pictures/Photoshop_
  - `.aiff`, `.flac`, `.mp3`, `.m4b`, `.ogg`, `.wav` audio to _~/Music
  /Unsorted_
  - `.3gp`, `.avi`, `.m4v`, `.mkv`, `.mp4` videos to _~/Videos/Unsorted_
  - `.sav`, `.srm`, `.oops` save files to _~/Games/ROMs/Save Files_
  - `.nes` NES roms to _~/Games/ROMs/Nintendo/NES_
  - `.smc` & `.sfc` SNES roms to _~/Games/ROMs/Nintendo/SNES_
  - `.n64` & `.z64` N64 roms to _~/Games/ROMs/Nintendo/N64_
  - `.gba` GBA roms to _~/Games/ROMs/Nintendo/GBA_
  - `.nds` DS roms to _~/Games/ROMs/Nintendo/DS_
  - `.3ds` 3DS roms to _~/Games/ROMs/Nintendo/3DS_
  - `.swf` Flash games to _~/Games/Flash_
  - `.gblorb`, `.z3`, `.z5`, `.z8` text adventures to _~/Games/Text Adventures_
  - `.scm` & `.scx` Starcraft maps to _~/.wine/drive_c/Program Files (x86)/StarCraft/Maps_
  - `.deb` & `.rpm` packages to _~/Applications/Linux Packages_
  - `.appimage` & `.x86_64` apps to _~/Applications_, makes them executable, and links them to the Desktop
  - `.exe` Windows apps to _~/Applications/Windows_
  - `.app` MacOS apps to _~/Applications/MacOS_
  - `.7z`, `.tar.gz`, `.zip` archives to _~/Documents/Unsorted Archives_
  - `.torrent` torrents to _~/Downloads/Torrents_
  - `.graffle`, `.icns`, `.m4p`, `.mid`, `.numbers`, `.svg` to _~/Desktop/Unconvertable_

## Installation
Installation is very simple, just drag-and-drop this script into your ~/Documents folder and run the following Terminal command:
```
bash ~/Documents/desktopcleanup.sh
```

### Uninstallation
You can easily remove DesktopCleanup.sh from your system by trashing the .sh file in your ~/Documents folder and running the following Terminal command:
```
crontab -r
```
***Warning!:*** *This will reset `crontab` to it's default settings and overwrite any other jobs assigned to it.  You can check all of `crontab`'s jobs by running `crontab -l`.*
