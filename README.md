# DesktopCleanup.sh

A self-automating bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

<p align=center><img src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white">  <img src="https://img.shields.io/badge/Atom-66595C?style=for-the-badge&logo=Atom&logoColor=white">  <img src="https://img.shields.io/badge/Linux_Mint-87CF3E?style=for-the-badge&logo=linux-mint&logoColor=white"></p>
<p align=center>Written in <b><a href="http://git.savannah.gnu.org/cgit/bash.git">Bash 5.1</a></b>. Edited in <b><a href="https://github.com/atom/atom">Atom 1.59</a></b>. Tested on <b><a href="https://github.com/linuxmint">Linux Mint 21.2</a></b>.</p>

The purpose of this script is to perform general cleanup of your Desktop in a way that can be automated.  As of **Version 1.2**, DesktopCleanup.sh schedules itself to run every 15 minutes as a `crontab` job.

DesktopCleanup.sh moves all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to ~/Music/Unsorted, video will be moved to ~/Videos/Unsorted, etc).  It also uses `perl` to bulk rename files with foreign characters found in MacOS filenames and `ffmpeg` to convert less popular lossy file formats into more universal and less lossy (or lossless) file formats.  Below is a complete list of features:

## Features
- **Automates** itself as a `crontab` job to run every 15 minutes
- **Renames** files with common foreign MacOS characters (requires `perl`)
- **Installs** `.otf` & `.ttf` fonts to _~/.local/share/fonts_
- **Converts** (requires `ffmpeg`)
  - `.avif`, `.bmp`, `.webp` pictures to `.png`
  - `.m4a` & `.mpga` audio to `.wav`
  - `.divx`, `.flv`, `.mov`, `.mpg`, `.webm` video to `.mp4`
- **Moves**
  - Applications
    - `.deb`, `.flatpak`, `.flatpakref`, `.rpm` packages to _~/Applications/Linux Packages_
    - `.appimage` & `.x86_64` apps to _~/Applications_, makes them executable, and links them to the Desktop
    - `.exe` Windows apps to _~/Applications/Windows_
    - `.app` MacOS apps to _~/Applications/MacOS_
    - `.apk` Android apps to _~/Applications/Android_
    - `.xpi` Mozilla Extensions to _~/Applications/Mozilla Extensions_
  - Documents
    - `.epub` & `.pdf` books to _~/Documents/Books_
    - `.ctb`, `.doc`, `.rtf`, `.txt`, `.xlsx` documents to _~/Documents/Unsorted_
    - `.html`, `.url` webpages to _~/Documents/Webpages_
  - Pictures
    - `.psd` files to _~/Pictures/Photoshop_
    - "screenshots" to _~/Pictures/Unsorted/Screenshots_
    - `.gif`, `.jpg`, `.jpeg`, `.png`, `.raw`, `.svg`, `.tiff` pictures to _~/Pictures/Unsorted_
  - Music
    - `.aiff`, `.flac`, `.mp3`, `.m4b`, `.ogg`, `.wav` audio to _~/Music/Unsorted_
    - `.mid`, `.midi` sheet music to _~/Music/Sheet Music_
    - `.sf2` soundfonts to _~/Music/Soundfonts_
  - Video
    - `.srt` subtitles to _~/Videos/Subtitles_
    - `.3gp`, `.avi`, `.m4v`, `.mkv`, `.mp4` videos to _~/Videos/Unsorted_
  - Games
    - `.swf` Flash games to _~/Games/Flash_
    - `.nes` NES roms to _~/Games/ROMs/Nintendo/NES_
    - `.smc` & `.sfc` SNES roms to _~/Games/ROMs/Nintendo/SNES_
    - `.n64` & `.z64` N64 roms to _~/Games/ROMs/Nintendo/N64_
    - `.gba` GBA roms to _~/Games/ROMs/Nintendo/GBA_
    - `.nds` DS roms to _~/Games/ROMs/Nintendo/DS_
    - `.3ds` 3DS roms to _~/Games/ROMs/Nintendo/3DS_
    - `.ips`, `.rnqs` romhacks to _~/Games/ROMs/Hacks_
    - `.sav`, `.srm`, `.oops` save files to _~/Games/Save Files_
    - `.gblorb`, `.z3`, `.z5`, `.z8` text adventures to _~/Games/Text Adventures_
    - `.scm` & `.scx` Starcraft maps to _~/.wine/drive_c/Program Files (x86)/StarCraft/Maps_
  - Downloads
    - `.torrent` torrents to _~/Downloads/Torrents_
  - Miscellaneous
    - `.m4p` songs to _~/Desktop/Dangerous Files_
    - `.graffle`, `.icns`, `.numbers`, to _~/Desktop/Unconvertable_
- **Optional Moves:** *(can be enabled by removing the # from their function)*
  - `.applescript`, `.css`, `.html`, `.php`, `.py`, `.sh` scripts to _~/Documents/Scripts_ 
  - `.7z`, `.rar`, `.tar.gz`, `.zip` archives to _~/Documents/Unsorted Archives_

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
crontab -l | grep -v "desktopcleanup.sh" | crontab -
```
