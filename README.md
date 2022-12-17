# DesktopCleanup.sh
A simple bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

The purpose of this script is to perform basic cleanup of your Desktop in a way that can be automated, such as by the [Command result desklet](https://cinnamon-spices.linuxmint.com/desklets/view/50) in the Cinnamon desktop environment.  It will move all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to /Music/Unsorted, video will be moved to /Movies/Unsorted, etc).  This script also proactively renames foreign characters found in MacOS filenames and converts unusuable or otherwise depreciated file formats such as .webm and .m4a to popular equivalents such as .mp4 and .wav.

## Requirements
This script requires you to have both ffmpeg and perl which can be installed with the following Terminal command:
```bash
sudo apt install ffmpeg perl

```
