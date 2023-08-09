# DesktopCleanup.sh

A self-automating bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

<p align=center><img src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white"> <img src="https://img.shields.io/badge/Atom-66595C?style=for-the-badge&logo=Atom&logoColor=white"> <img src="https://img.shields.io/badge/Linux_Mint-87CF3E?style=for-the-badge&logo=linux-mint&logoColor=white"></p>
<p align=center>Written in <b>Bash</b>. Edited in <b>Atom 1.59</b>. Tested on <b>Linux Mint 21.2</b>.</p>

The purpose of this script is to perform general cleanup of your Desktop in a way that can be automated.  As of **Version 1.2**, DesktopCleanup.sh schedules itself to run every 15 minutes as a `crontab` job.

DesktopCleanup.sh moves all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to ~/Music/Unsorted, video will be moved to ~/Videos/Unsorted, etc).  It also uses `perl` to bulk rename files with foreign characters found in MacOS filenames and `ffmpeg` to convert less popular lossy file formats into more universal and less lossy (or lossless) file formats.  Below is a complete list of features:

## Features
- **Automates** itself as a `crontab` job to run every 15 minutes
- **Renames** files with common foreign MacOS characters
- **Installs** `.otf` & `.ttf` fonts to _~/.local/share/fonts_
- **Converts**
  - `.avif`, `.bmp`, `.webp` pictures to `.png`
  - `.m4a` & `.mpga` audio to `.wav`
  - `.divx`, `.flv`, `.mov`, `.mpg`, `.webm` video to `.mp4`
- **Moves**
  - `.deb`, `.flatpakref`, `.rpm` packages to _~/Applications/Linux Packages_
  - `.appimage` & `.x86_64` apps to _~/Applications_, makes them executable, and links them to the Desktop
  - `.exe` Windows apps to _~/Applications/Windows_
  - `.app` MacOS apps to _~/Applications/MacOS_
  - `.apk` Android apps to _~/Applications/Android_
  - `.ctb`, `.doc`, `.html`, `.rtf`, `.txt`, `.xlsx` documents to _~/Documents/Unsorted_
  - `.epub` & `.pdf` books to _~/Documents/Books_
  - `.gif`, `.jpg`, `.jpeg`, `.png`, `.raw`, `.svg`, `.tiff` pictures to _~/Pictures/Unsorted_
  - "screenshots" to _~/Pictures/Unsorted/Screenshots_
  - `.psd` files to _~/Pictures/Photoshop_
  - `.aiff`, `.flac`, `.mp3`, `.m4b`, `.ogg`, `.wav` audio to _~/Music/Unsorted_
  - `.sf2` soundfonts to _~/Music/Soundfonts_
  - `.3gp`, `.avi`, `.m4v`, `.mkv`, `.mp4` videos to _~/Videos/Unsorted_
  - `.srt` subtitles to _~/Videos/Subtitles_
  - `.sav`, `.srm`, `.oops` save files to _~/Games/Save Files_
  - `.nes` NES roms to _~/Games/ROMs/Nintendo/NES_
  - `.smc` & `.sfc` SNES roms to _~/Games/ROMs/Nintendo/SNES_
  - `.n64` & `.z64` N64 roms to _~/Games/ROMs/Nintendo/N64_
  - `.gba` GBA roms to _~/Games/ROMs/Nintendo/GBA_
  - `.nds` DS roms to _~/Games/ROMs/Nintendo/DS_
  - `.3ds` 3DS roms to _~/Games/ROMs/Nintendo/3DS_
  - `.ips` patches to _~/Games/ROMs/Patches_
  - `.swf` Flash games to _~/Games/Flash_
  - `.gblorb`, `.z3`, `.z5`, `.z8` text adventures to _~/Games/Text Adventures_
  - `.scm` & `.scx` Starcraft maps to _~/.wine/drive_c/Program Files (x86)/StarCraft/Maps_
  - `.torrent` torrents to _~/Downloads/Torrents_
  - `.graffle`, `.icns`, `.numbers`, to _~/Desktop/Unconvertable_
  - `.m4p` songs to _~/Desktop/Dangerous Files_
- **Optional Moves:** *(can be enabled by removing the # from their function)*
  - `.applescript`, `.css`, `.html`, `.php`, `.py`, `.sh` scripts to _~/Documents/Scripts_ 
  - `.7z`, `.rar`, `.tar.gz`, `.zip` archives to _~/Documents/Unsorted Archives_

## Requirements
This script requires the following dependencies:
- `ffmpeg` (file conversion)
- `perl` (file renaming)

**Install on Debian/Ubuntu** via `apt`:
```
sudo apt install ffmpeg perl
```

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
