# DesktopCleanup.sh
A self-automating bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

The purpose of this script is to perform basic cleanup of your Desktop in a way that can be automated.
As of **Version 1.2**, DesktopCleanup.sh schedules itself to run every 15 minutes as a `crontab` job.

DesktopCleanup.sh moves all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to ~/Music/Unsorted, video will be moved to ~/Videos/Unsorted, etc).  It also uses `perl` to bulk rename files with foreign characters found in MacOS filenames and `ffmpeg` to convert less popular lossy file formats into more universal and less lossy (or lossless) file formats.  Below is a complete list of features:

## Features
**Self-Automated:**
- Sets itself as a `crontab` job to run every 15 minutes.
  
**Renames Foreign Characters:**
- Bulk renames foreign characters in MacOS filenames.
  
**Installs Fonts:**
- Installs `.otf` & `.ttf` fonts to `~/.local/share/fonts`.
  
**Organizes Documents:**
- Moves `.ctb`, `.doc`, `.html`, `.pdf`, `.rtf`, `.txt`, & `.xlsx` documents to `~/Documents/Unsorted`.
  
**Organizes Pictures:**
- Converts `.avif`, `.bmp`, & `.webp` to `.png`.
- Moves`.gif`, `.jpg`, `.jpeg`, & `.png` pictures to `~/Pictures/Unsorted`.
- Moves `.psd` files to `~/Pictures/Photoshop`
- Moves screenshots to `~/Pictures/Screenshots`.
  
**Organizes Audio:**
- Converts `.m4a` & `.mpga` to `.wav`.
- Moves `.aiff`, `.flac`, `.mp3`, `.m4b`, `.ogg`, & `.wav` audio to `~/Music
  /Unsorted`.

**Organizes Video:**
- Converts `.divx`, `.flv`, `.mov`, `.mpg`, & `.webm` to `.mp4`.
- Moves `.3gp`, `.avi`, `.m4v`, `.mkv`, & `.mp4` videos to `~/Videos/Unsorted`.
  
**Organizes Games:**
- Moves `.sav`, `.srm`, & `.oops` save files to `~/Games/ROMs/Save Files`.
- Moves `.nes` NES roms to `~/Games/ROMs/Nintendo/NES`.
- Moves `.smc` & `.sfc` SNES roms to `~/Games/ROMs/Nintendo/SNES`.
- Moves `.n64` & `.z64` N64 roms to `~/Games/ROMs/Nintendo/N64`.
- Moves `.gba` GBA roms to `~/Games/ROMs/Nintendo/GBA`.
- Moves `.nds` DS roms to `~/Games/ROMs/Nintendo/DS`.
- Moves `.3ds` 3DS roms to `~/Games/ROMs/Nintendo/3DS`.
- Moves `.swf` Flash games to `~/Games/Flash`.
- Moves `.gblorb`, `.z3`, `.z5`, & `.z8` text adventures to `~/Games/Text Adventures`.
- Moves `.scm` & `.scx` Starcraft maps to `~/.wine/drive_c/Program Files (x86)/StarCraft/Maps`.
  
**Organizes Applications:**
- Moves `.appimage` & `.x86_64` apps to `~/Applications`, makes them executable, and links them to the Desktop.
- Moves `.deb` & `.rpm` packages to `~/Applications/Linux Packages`.
- Moves `.exe` Windows apps to `~/Applications/Windows`.
- Moves `.app` MacOS apps to `~/Applications/MacOS`.
  
**Organizes Archives:**
- Moves `.7z`, `.tar.gz`, & `.zip` archives to `~/Documents/Unsorted Archives`.
  
**Organizes Torrents:**
- Moves `.torrent` torrents to `~/Downloads/Torrents`.
  
**Collects remaining filetypes:**
- Moves `.graffle`, `.icns`, `.m4p`, `.mid`, `.numbers`, & `.svg` to `~/Desktop/Unconvertable`.

## Requirements
This script requires the following extra packages to be installed:
- `ffmpeg` (file conversion)
- `perl` (file renaming)

They can be installed on Ubuntu & Debian-based distros with the following Terminal command:
```
sudo apt install ffmpeg perl
```
## Installation
Installation is very simple, just drag-and-drop this script into your ~/Documents folder and run the following Terminal command:
```
bash ~/Documents/desktopcleanup.sh
```

### Uninstall
You can easily remove DesktopCleanup.sh from your system by trashing the .sh file in your ~/Documents folder and running the following Terminal command:
```
crontab -r
```
***Warning!:*** *This will reset `crontab` to it's default settings and overwrite any other jobs assigned to it.  You can check all of `crontab`'s jobs by running `crontab -l`.*
