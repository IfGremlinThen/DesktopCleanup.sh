#!/bin/bash

#REQUIRES PERL & FFMPEG
################################################################################
#SCHEDULES DESKTOPCLEANUP EVERY 15 MINUTES W/ CRONTAB
echo "STEP: CRONTAB"
if crontab -l | grep "desktopcleanup.sh"
then
  echo "Your Desktop Cleanup is scheduled!"
else
  echo "Scheduling desktopcleanup.sh every 15 minutes."
  crontab -l | { cat; echo "*/15 * * * * bash ~/Documents/desktopcleanup.sh"; } | crontab -
fi
#crontab -r #FOR UNINSTALL
################################################################################
cd ~/Desktop
echo "STEP: NULLGLOB"
shopt -s nullglob #IGNORE EMPTY WILDCARDS
################################################################################
#RENAMES FILES WITH FOREIGN MACOS CHARACTERS
echo "STEP: RENAME"
rename -f 's///g' ./*
rename -f 's// - /g' ./*
rename -f 's//|/g' ./*
rename -f 's//?/g' ./*
rename -f 's//"/g' ./*
rename 's/\.([^.]+)$/.\L$1/' *

################################################################################
# TEXT #########################################################################
echo "STEP: CREATE UNSORTED DOCUMENT DIRECTORIES"
if [ ! -d ~/Documents/Unsorted ]; then #IF UNSORTED DOCUMENTS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Documents/Unsorted
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP DOCUMENTS"
backupDocuments(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Documents/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupDocuments ./*.ctb ./*.doc ./*.html ./*.pdf ./*.rtf ./*.txt ./*.xlsx

################################################################################
# IMAGES #######################################################################
echo "STEP: CREATE PHOTOSHOP & SCREENSHOT DIRECTORIES"
if [ ! -d ~/Pictures/Unsorted/Screenshots ]; then #IF UNSORTED PICTURES FOLDERS DON'T EXIST, CREATE THEM
  mkdir ~/Pictures/Unsorted ~/Pictures/Unsorted/Screenshots
fi
if [ ! -d ~/Pictures/Photoshop ]; then #IF PHOTOSHOP FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Pictures/Photoshop
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: CONVERT TO .PNG"
convertToPNG(){
  (($#)) || return
  for file in "$@"; do
    ffmpeg -i "$file" "$file.png" && rm "$file"
  done
}
convertToPNG ./*.avif ./*.bmp ./*.webp
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP SCREENSHOTS"
backupScreenshots(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Pictures/Unsorted/Screenshots #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupScreenshots ./*screen*.png ./Screen*.png
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP PICTURES"
backupPictures(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Pictures/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupPictures ./*.gif ./*.jpg ./*.jpeg ./*.png
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP PHOTOSHOP"
backupPhotoshop(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Pictures/Photoshop #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupPhotoshop ./*.psd

################################################################################
# AUDIO ########################################################################
echo "STEP: CREATE UNSORTED AUDIO DIRECTORY"
if [ ! -d ~/Music/Unsorted ]; then #IF UNSORTED MUSIC FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Music/Unsorted
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: CONVERT TO .WAV"
convertToWAV(){
  (($#)) || return
  for file in "$@"; do
    ffmpeg -i "$file" "$file.wav" && rm "$file"
  done
}
convertToWAV ./*.m4a ./*.mpga
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP AUDIO"
backupMusic(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Music/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupMusic ./*.aiff ./*.flac ./*.mp3 ./*.m4b ./*.ogg ./*.wav

################################################################################
# VIDEO ########################################################################
echo "STEP: CREATED UNSORTED VIDEOS DIRECTORY"
if [ ! -d ~/Videos/Unsorted ]; then #IF UNSORTED VIDEOS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Videos/Unsorted
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: CONVERT TO .MP4"
convertToMP4(){
  (($#)) || return
  for file in "$@"; do
    ffmpeg -i "$file" "$file.mp4" && rm "$file"
  done
}
convertToMP4 ./*.flv ./*.mov ./*.mpg ./*.webm
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP VIDEOS"
backupVideos(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Videos/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupVideos ./*.3gp ./*.avi ./*.m4v ./*.mkv ./*.mp4

################################################################################
# GAMES ########################################################################
echo "STEP: CREATE GAME DIRECTORIES"
if [ ! -d ~/Games/ROMs/Nintendo ]; then #IF NINTENDO GAMES FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Games/ROMs/Nintendo/NES ~/Games/ROMs/Nintendo/SNES ~/Games/ROMs/Nintendo/N64 ~/Games/ROMs/Nintendo/GBA ~/Games/ROMs/Nintendo/DS ~/Games/ROMs/Nintendo/3DS
fi
if [ ! -d ~/Games/Flash ]; then #IF FLASH GAMES FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Games/Flash
fi
if [ ! -d ~/Games/Text\ Adventures ]; then #IF TEXT ADVENTURE GAMES FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Games/Text\ Adventures
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP SAVE FILES"
backupSaveFiles(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Save\ Files #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupSaveFiles ./*.sav ./*.srm ./*oops
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP NES ROMS"
backupNESROMs(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Nintendo/NES #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupNESROMs ./*.nes
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP SNES ROMS"
backupSNESROMs(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Nintendo/SNES #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupSNESROMs ./*.smc ./*sfc
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP N64 ROMS"
backupN64ROMs(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Nintendo/N64 #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupN64ROMs ./*.n64 ./*.z64
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP GBA ROMS"
backupGBAROMs(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Nintendo/GBA #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupGBAROMs ./*.gba
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP DS ROMS"
backupDSROMs(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Nintendo/DS #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupDSROMs ./*.nds
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP 3DS ROMS"
backup3DSROMs(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/ROMs/Nintendo/3DS #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backup3DSROMs ./*.3ds

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP FLASH GAMES"
backupFlashGames(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/Flash #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupFlashGames ./*.swf

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP TEXT ADVENTURES"
backupTextAdventures(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Games/Text\ Adventures #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupTextAdventures ./*.gblorb ./*.z3 ./*.z5 ./*.z8

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP STARCRAFT MAPS"
backupStarcraftMaps(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads' #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
if [ -d ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/' ]; then #SKIP IF STARCRAFT MAPS FOLDER DOESN'T EXIST
  backupStarcraftMaps ./*.scm ./*scx
fi

################################################################################
# APPLICATIONS #################################################################
echo "STEP: CREATE APPLICATIONS DIRECTORY"
if [ ! -d ~/Applications ]; then #IF APPLICATIONS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Applications
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP APPLICATIONS"
backupApplications(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Applications #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupApplications ./*.appimage ./*.x86_64
chmod 777 ~/Applications/*

################################################################################
# TORRENTS #####################################################################
echo "STEP: CREATE TORRENTS DIRECTORY"
if [ ! -d ~/Downloads/Torrents ]; then #IF TORRENTS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Downloads/Torrents
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP TORRENT FILES"
backupTorrents(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Downloads/Torrents #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupTorrents ./*.torrent

################################################################################
# MISCELLANEOUS ################################################################
echo "STEP: CREATE UNCONVERTABLE DIRECTORY"
if [ ! -d ~/Desktop/Unconvertable ]; then #IF UNCONVERTABLE FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Desktop/Unconvertable
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
echo "STEP: BACKUP UNCONVERTABLE FILES"
backupUnconvertables(){
    (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
     for file in "$@"; do
       mv --backup=t "$@" ~/Desktop/Unconvertable #MOVES FILETYPES GIVEN TO THE FUNCTION
     done
}
backupUnconvertables ./*.graffle ./*.icns ./*.m4p ./*.mid ./*.numbers ./*.svg

################################################################################
# RENAME HIDDEN BACKUPS CREATED BY MV ##########################################
#echo "STEP: RENAME BACKUP FILES"
#cd ~/Documents/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
#cd ~/Pictures/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
#cd ~/Music/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
#cd ~/Videos/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
#cd ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads' && rename 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
#cd ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/BroodWar/Downloads' && rename 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~

################################################################################
echo "STEP: FINISHING UP"
cd
#touch ~/Desktop/cleanupreceipt.txt
