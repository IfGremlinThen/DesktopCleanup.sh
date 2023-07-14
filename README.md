# DesktopCleanup.sh
A self-automating bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

The purpose of this script is to perform basic cleanup of your Desktop in a way that can be automated.
As of **Version 1.2**, DesktopCleanup.sh schedules itself to run every 15 minutes as a `crontab` job.

DesktopCleanup.sh moves all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to ~/Music/Unsorted, video will be moved to ~/Videos/Unsorted, etc).  It also uses `perl` to bulk rename files with foreign characters found in MacOS filenames and `ffmpeg` to convert less popular lossy file formats into more universal and less lossy (or lossless) file formats.  Below is a complete list of features:

## Features
- Sets itself as a `crontab` job to run every 15 minutes.
- Bulk renames foreign characters in MacOS filenames.
- Installs `.otf` & `.ttf` fonts to _~/.local/share/fonts_.
- Moves `.ctb`, `.doc`, `.html`, `.pdf`, `.rtf`, `.txt`, & `.xlsx` documents to _~/Documents/Unsorted_.
- Converts `.avif`, `.bmp`, & `.webp` to `.png`.
- Moves screenshots to _~/Pictures/Unsorted/Screenshots_.
- Moves`.gif`, `.jpg`, `.jpeg`, & `.png` pictures to _~/Pictures/Unsorted_.
- Moves `.psd` files to _~/Pictures/Photoshop_.
- Converts `.m4a` & `.mpga` to `.wav`.
- Moves `.aiff`, `.flac`, `.mp3`, `.m4b`, `.ogg`, & `.wav` audio to _~/Music
  /Unsorted_.
- Converts `.divx`, `.flv`, `.mov`, `.mpg`, & `.webm` to `.mp4`.
- Moves `.3gp`, `.avi`, `.m4v`, `.mkv`, & `.mp4` videos to _~/Videos/Unsorted_.
- Moves `.sav`, `.srm`, & `.oops` save files to _~/Games/ROMs/Save Files_.
- Moves `.nes` NES roms to _~/Games/ROMs/Nintendo/NES_.
- Moves `.smc` & `.sfc` SNES roms to _~/Games/ROMs/Nintendo/SNES_.
- Moves `.n64` & `.z64` N64 roms to _~/Games/ROMs/Nintendo/N64_.
- Moves `.gba` GBA roms to _~/Games/ROMs/Nintendo/GBA_.
- Moves `.nds` DS roms to _~/Games/ROMs/Nintendo/DS_.
- Moves `.3ds` 3DS roms to _~/Games/ROMs/Nintendo/3DS_.
- Moves `.swf` Flash games to _~/Games/Flash_.
- Moves `.gblorb`, `.z3`, `.z5`, & `.z8` text adventures to _~/Games/Text Adventures_.
- Moves `.scm` & `.scx` Starcraft maps to _~/.wine/drive_c/Program Files (x86)/StarCraft/Maps_.
- Moves `.appimage` & `.x86_64` apps to _~/Applications_, makes them executable, and links them to the Desktop.
- Moves `.deb` & `.rpm` packages to _~/Applications/Linux Packages_.
- Moves `.exe` Windows apps to _~/Applications/Windows_.
- Moves `.app` MacOS apps to _~/Applications/MacOS_.
- Moves `.7z`, `.tar.gz`, & `.zip` archives to _~/Documents/Unsorted Archives_.
- Moves `.torrent` torrents to _~/Downloads/Torrents_.
- Moves `.graffle`, `.icns`, `.m4p`, `.mid`, `.numbers`, & `.svg` to _~/Desktop/Unconvertable_.

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
