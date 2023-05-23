# DesktopCleanup.sh
A self-automating bash script for organizing files on your Ubuntu-based GNU-Linux desktop into appropriate folders.

The purpose of this script is to perform basic cleanup of your Desktop in a way that can be automated.
As of **Version 1.2**, DesktopCleanup.sh schedules itself to run every 15 minutes as a `crontab` job.

DesktopCleanup.sh moves all files it recognizes into separate filetype-specific 'Unsorted' folders in each of your main Home folders (audio files will be moved to ~/Music/Unsorted, video will be moved to ~/Videos/Unsorted, etc).  This script also proactively renames foreign characters found in MacOS filenames and converts unusuable or otherwise depreciated file formats such as .webm and .m4a to popular equivalents such as .mp4 and .wav.

## Requirements
This script requires you to have both `ffmpeg` and `perl` which can be installed with the following Terminal command:
```sudo apt install ffmpeg perl```

## Installation
Installation is very simple, just drag-and-drop this script into your ~/Documents folder and run the following Terminal command:
```bash ~/Documents/desktopcleanup.sh```

### Uninstall
You can easily remove DesktopCleanup.sh from your system by trashing the .sh file in your ~/Documents folder and running the following Terminal command:
```crontab -r```
***Warning!:*** *This will reset `crontab` to it's default settings and overwrite any other jobs assigned to it.  You can check all of `crontab`'s jobs by running `crontab -l`.*
