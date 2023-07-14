#!/bin/bash

#REQUIRES PERL & FFMPEG
################################################################################
#SCHEDULES DESKTOPCLEANUP EVERY 15 MINUTES W/ CRONTAB
echo "Setting up Crontab..."
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
echo "Setting nullglob..."
shopt -s nullglob #IGNORE EMPTY WILDCARDS
################################################################################
#RENAMES FILES WITH FOREIGN MACOS CHARACTERS
echo "Renaming foreign characters..."
rename -f 's///g' ./*
rename -f 's// - /g' ./*
rename -f 's//|/g' ./*
rename -f 's//?/g' ./*
rename -f 's//"/g' ./*
rename 's/\.([^.]+)$/.\L$1/' *

################################################################################
# FONTS ########################################################################
installFonts(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Installing fonts..."
  if [ ! -d ~/.local/share/fonts ]; then mkdir ~/.local/share/fonts; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/.local/share/fonts #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
  fc-cache #UPDATES FONT CACHE
}
installFonts ./*.otf ./*.ttf

################################################################################
# TEXT #########################################################################
backupDocuments(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up documents..."
  if [ ! -d ~/Documents/Unsorted ]; then mkdir ~/Documents/Unsorted; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Documents/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupDocuments ./*.ctb ./*.doc ./*.html ./*.pdf ./*.rtf ./*.txt ./*.xlsx

################################################################################
# IMAGES #######################################################################
convertToPNG(){
  (($#)) || return
  echo "Converting to .png..."
  for file in "$@"; do
    ffmpeg -i "$file" "$file.png" && rm "$file"
  done
}
convertToPNG ./*.avif ./*.bmp ./*.webp
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupScreenshots(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up screenshots..."
  if [ ! -d ~/Pictures/Unsorted/Screenshots ]; then mkdir ~/Pictures/Unsorted/Screenshots; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Pictures/Unsorted/Screenshots #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupScreenshots ./*screen*.png ./Screen*.png
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupPictures(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up pictures..."
  if [ ! -d ~/Pictures/Unsorted ]; then mkdir ~/Pictures/Unsorted; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Pictures/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupPictures ./*.gif ./*.jpg ./*.jpeg ./*.png
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupPhotoshop(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up Photoshop files..."
  if [ ! -d ~/Pictures/Photoshop ]; then mkdir ~/Pictures/Photoshop; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Pictures/Photoshop #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupPhotoshop ./*.psd

################################################################################
# AUDIO ########################################################################
convertToWAV(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Converting to .wav..."
  for file in "$@"; do
    ffmpeg -i "$file" "$file.wav" && rm "$file"
  done
}
convertToWAV ./*.m4a ./*.mpga
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupMusic(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up audio..."
  if [ ! -d ~/Music/Unsorted ]; then mkdir ~/Music/Unsorted; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Music/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupMusic ./*.aiff ./*.flac ./*.mp3 ./*.m4b ./*.ogg ./*.wav

################################################################################
# VIDEO ########################################################################
convertToMP4(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Converting to .mp4..."
  for file in "$@"; do
    ffmpeg -i "$file" "$file.mp4" && rm "$file"
  done
}
convertToMP4 ./*.divx ./*.flv ./*.mov ./*.mpg ./*.webm
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupVideos(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up videos..."
  if [ ! -d ~/Videos/Unsorted ]; then mkdir ~/Videos/Unsorted; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Videos/Unsorted #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupVideos ./*.3gp ./*.avi ./*.m4v ./*.mkv ./*.mp4

################################################################################
# GAMES ########################################################################
backupSaveFiles(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up save files..."
  if [ ! -d ~/Games/ROMs/Save\ Files ]; then mkdir ~/Games/ROMs/Save\ Files; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Save\ Files #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupSaveFiles ./*.sav ./*.srm ./*oops
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupNESROMs(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up NES roms..."
  if [ ! -d ~/Games/ROMs/Nintendo/NES ]; then mkdir ~/Games/ROMs/Nintendo/NES; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Nintendo/NES #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupNESROMs ./*.nes
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupSNESROMs(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up SNES roms..."
  if [ ! -d ~/Games/ROMs/Nintendo/SNES ]; then mkdir ~/Games/ROMs/Nintendo/SNES; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Nintendo/SNES #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupSNESROMs ./*.smc ./*sfc
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupN64ROMs(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up N64 roms..."
  if [ ! -d ~/Games/ROMs/Nintendo/N64 ]; then mkdir ~/Games/ROMs/Nintendo/N64; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Nintendo/N64 #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupN64ROMs ./*.n64 ./*.z64
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupGBAROMs(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up GBA roms..."
  if [ ! -d ~/Games/ROMs/Nintendo/GBA ]; then mkdir ~/Games/ROMs/Nintendo/GBA; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Nintendo/GBA #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupGBAROMs ./*.gba
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupDSROMs(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up DS roms..."
  if [ ! -d ~/Games/ROMs/Nintendo/DS ]; then mkdir ~/Games/ROMs/Nintendo/DS; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Nintendo/DS #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupDSROMs ./*.nds
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backup3DSROMs(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up 3DS roms..."
  if [ ! -d ~/Games/ROMs/Nintendo/3DS ]; then mkdir ~/Games/ROMs/Nintendo/3DS; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/ROMs/Nintendo/3DS #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backup3DSROMs ./*.3ds
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupFlashGames(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up Flash games..."
  if [ ! -d ~/Games/Flash ]; then mkdir ~/Games/Flash; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/Flash #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupFlashGames ./*.swf
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupTextAdventures(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up text adventures..."
  if [ ! -d ~/Games/Text\ Adventures ]; then mkdir ~/Games/Text\ Adventures; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Games/Text\ Adventures #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupTextAdventures ./*.gblorb ./*.z3 ./*.z5 ./*.z8
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupStarcraftMaps(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up Starcraft maps..."
  for file in "$@"; do
    mv --backup=t "$@" ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads' #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
if [ -d ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/' ]; then #SKIP IF STARCRAFT MAPS FOLDER DOESN'T EXIST
  backupStarcraftMaps ./*.scm ./*scx
fi

################################################################################
# APPLICATIONS #################################################################
backupApplications(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up Linux applications..."
  if [ ! -d ~/Applications ]; then mkdir ~/Applications; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Applications #MOVES FILETYPES GIVEN TO THE FUNCTION
    ln -s ~/"Applications/$file" ~/"Desktop/$file Link" #CREATES A SYMBOLIC LINK ON THE DESKTOP
    chmod 777 ~/"Applications/$file"
  done
}
backupApplications ./*.appimage ./*.x86_64

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupPackages(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up Linux packages..."
  if [ ! -d ~/Applications/Linux\ Packages ]; then mkdir ~/Applications/Linux\ Packages; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Applications/Linux\ Packages #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupPackages ./*.deb ./*.rpm
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupWinApplications(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up Windows applications..."
  if [ ! -d ~/Applications/Windows ]; then mkdir ~/Applications/Windows; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Applications/Windows #MOVES FILETYPES GIVEN TO THE FUNCTION
    ln -s ~/"Applications/Windows/$file" ~/"Desktop/$file Link" #CREATES A SYMBOLIC LINK ON THE DESKTOP
  done
}
backupWinApplications ./*.exe
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
backupMacApplications(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up MacOS applications..."
  if [ ! -d ~/Applications/MacOS ]; then mkdir ~/Applications/MacOS; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Applications/MacOS #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupMacApplications ./*.app

################################################################################
# ARCHIVES #####################################################################
backupArchives(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up archives..."
  if [ ! -d ~/Documents/Unsorted\ Archives ]; then mkdir ~/Documents/Unsorted\ Archives; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Documents/Unsorted\ Archives #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupArchives ./*.7z ./*.tar.gz ./*.zip

################################################################################
# TORRENTS #####################################################################
backupTorrents(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up torrent files..."
  if [ ! -d ~/Downloads/Torrents ]; then mkdir ~/Downloads/Torrents; fi
  for file in "$@"; do
    mv --backup=t "$@" ~/Downloads/Torrents #MOVES FILETYPES GIVEN TO THE FUNCTION
  done
}
backupTorrents ./*.torrent

################################################################################
# MISCELLANEOUS ################################################################
backupUnconvertables(){
  (($#)) || return #CHECKS FOR REMAINING FILETYPES GIVEN TO THE FUNCTION, IF NONE, ABORTS
  echo "Backing up unconvertable files..."
  if [ ! -d ~/Desktop/Unconvertable ]; then mkdir ~/Desktop/Unconvertable; fi
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
echo "COMPLETE!"
cd
#touch ~/Desktop/cleanupreceipt.txt

#ADDED
#.divx
#.7z, .tar.gz, .zip
#symbolic links to .appimages, .x86_64, & .exe files
#.deb, .rpm
#Installs .otf., .ttf fonts locally
#FIXES
#Only echos and creates directories if relevant filetypes are detected
