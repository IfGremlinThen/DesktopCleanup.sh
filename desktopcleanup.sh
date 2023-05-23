#!/bin/bash

#REQUIRES PERL & FFMPEG
################################################################################
#SCHEDULES DESKTOPCLEANUP EVERY 15 MINUTES W/ CRONTAB
if sudo grep "desktopcleanup.sh" "/var/spool/cron/crontabs/$USER"
then
  echo "Your Desktop Cleanup is scheduled!"
else
  echo "Scheduling desktopcleanup.sh every 15 minutes."
  crontab -l | { cat; echo "*/15 * * * * bash ~/Documents/desktopcleanup.sh"; } | crontab -
fi
#crontab -r #FOR UNINSTALL
################################################################################
cd ~/Desktop
################################################################################
#RENAMES FILES WITH FOREIGN MACOS CHARACTERS
rename -f 's///g' ./*
rename -f 's// - /g' ./*
rename -f 's//|/g' ./*
rename -f 's//?/g' ./*
rename -f 's//"/g' ./*
rename 's/\.([^.]+)$/.\L$1/' *
################################################################################
#TEXT
if [ ! -d ~/Documents/Unsorted ]; then #IF UNSORTED DOCUMENTS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Documents/Unsorted
fi
until [ ! -f *.ctb ]; do mv --backup=t ./*.ctb ~/Documents/Unsorted; done
until [ ! -f *.doc ]; do mv --backup=t ./*.doc ~/Documents/Unsorted; done
until [ ! -f *.html ]; do mv --backup=t ./*.html ~/Documents/Unsorted; done
until [ ! -f *.pdf ]; do mv --backup=t ./*.pdf ~/Documents/Unsorted; done
until [ ! -f *.rtf ]; do mv --backup=t ./*.rtf ~/Documents/Unsorted; done
until [ ! -f *.txt ]; do mv --backup=t ./*.txt ~/Documents/Unsorted; done
until [ ! -f *.xlsx ]; do mv --backup=t ./*.xlsx ~/Documents/Unsorted; done
################################################################################
#IMAGES
if [ ! -d ~/Pictures/Unsorted/Screenshots ]; then #IF UNSORTED PICTURES FOLDERS DON'T EXIST, CREATE THEM
  mkdir ~/Pictures/Unsorted ~/Pictures/Unsorted/Screenshots
fi
if [ ! -d ~/Pictures/Photoshop ]; then #IF PHOTOSHOP FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Pictures/Photoshop
fi
until [ ! -f *.gif ]; do mv --backup=t ./*.gif ~/Pictures/Unsorted; done
until [ ! -f *.jpg ]; do mv --backup=t ./*.jpg ~/Pictures/Unsorted; done
until [ ! -f *.jpeg ]; do mv --backup=t ./*.jpeg ~/Pictures/Unsorted; done
until [ ! -f *screen*.png ]; do mv --backup=t ./*screen*.png ~/Pictures/Unsorted/Screenshots; done
until [ ! -f Screen*.png ]; do mv --backup=t ./Screen*.png ~/Pictures/Unsorted/Screenshots; done
until [ ! -f *.psd ]; do mv --backup=t ./*.psd ~/Pictures/Photoshop; done
if [ -f *.avif ]; then #CONVERTS .AVIF TO .PNG AND REMOVES REMAINING .AVIF FILES
  for file in *.avif; do ffmpeg -i "$file" "$file".png; done
  until [ ! -f *.avif ]; do rm ./*.avif; done
fi
if [ -f *.bmp ]; then #CONVERTS .BMP TO .PNG AND REMOVES REMAINING .BMP FILES
  for file in *.bmp; do ffmpeg -i "$file" "$file".png; done
  until [ ! -f *.bmp ]; do rm ./*.bmp; done
fi
if [ -f *.webp ]; then #CONVERTS .WEBP TO .PNG AND REMOVES REMAINING .WEBP FILES
  for file in *.webp; do ffmpeg -i "$file" "$file".png; done
  until [ ! -f *.webp ]; do rm ./*.webp; done
fi
until [ ! -f *.png ]; do mv --backup=t ./*.png ~/Pictures/Unsorted; done #MOVES ALL CONVERTED .PNGs
################################################################################
#AUDIO
if [ ! -d ~/Music/Unsorted ]; then #IF UNSORTED MUSIC FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Music/Unsorted
fi
until [ ! -f *.aiff ]; do mv --backup=t ./*.aiff ~/Music/Unsorted; done
until [ ! -f *.flac ]; do mv --backup=t ./*.flac ~/Music/Unsorted; done
until [ ! -f *.mp3 ]; do mv --backup=t ./*.mp3 ~/Music/Unsorted; done
until [ ! -f *.m4b ]; do mv --backup=t ./*.m4b ~/Music/Unsorted; done
until [ ! -f *.ogg ]; do mv --backup=t ./*.ogg ~/Music/Unsorted; done
if [ -f *.m4a ]; then #CONVERTS .M4A TO .WAV AND REMOVES REMAINING .M4A FILES
  for file in *.m4a; do ffmpeg -i "$file" "$file".wav; done
  until [ ! -f *.m4a ]; do rm ./*.m4a; done
fi
if [ -f *.mpga ]; then #CONVERTS .MPGA TO .MP3 AND REMOVES REMAINING .MPGA FILES
  for file in *.mpga; do ffmpeg -i "$file" "$file".mp3; done
  until [ ! -f *.mpga ]; do rm ./*.mpga; done
fi
until [ ! -f *.wav ]; do mv --backup=t ./*.wav ~/Music/Unsorted; done #MOVES CONVERTED .WAVs
until [ ! -f *.mp3 ]; do mv --backup=t ./*.mp3 ~/Music/Unsorted; done #MOVES CONVERTED .MP3s
################################################################################
#VIDEO
if [ ! -d ~/Videos/Unsorted ]; then #IF UNSORTED VIDEOS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Videos/Unsorted
fi
until [ ! -f *.3gp ]; do mv --backup=t ./*.3gp ~/Videos/Unsorted; done
until [ ! -f *.avi ]; do mv --backup=t ./*.avi ~/Videos/Unsorted; done
until [ ! -f *.mkv ]; do mv --backup=t ./*.mkv ~/Videos/Unsorted; done
until [ ! -f *.m4v ]; do mv --backup=t ./*.m4v ~/Videos/Unsorted; done
if [ -f *.mov ]; then #CONVERTS .MOV TO .MP4 AND REMOVES REMAINING .MOV FILES
  for file in *.mov; do ffmpeg -i "$file" "$file".mp4; done
  until [ ! -f *.mov ]; do rm ./*.mov; done
fi
if [ -f *.webm ]; then #CONVERTS .WEBM TO .MP4 AND REMOVES REMAINING .WEBM FILES
  for file in *.webm; do ffmpeg -i "$file" "$file".mp4; done
  until [ ! -f *.webm ]; do rm ./*.webm; done
fi
until [ ! -f *.mp4 ]; do mv --backup=t ./*.mp4 ~/Videos/Unsorted; done #MOVES CONVERTED .MP4s
################################################################################
#GAMES
if [ ! -d ~/Games/ROMs/Nintendo ]; then #IF NINTENDO GAMES FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Games/ROMs/Nintendo/GBA ~/Games/ROMs/Nintendo/NES ~/Games/ROMs/Nintendo/SNES ~/Games/ROMs/Nintendo/N64 ~/Games/ROMs/Nintendo/DS ~/Games/ROMs/Nintendo/3DS
fi
if [ ! -d ~/Games/Flash ]; then #IF FLASH GAMES FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Games/Flash
fi
until [ ! -f *.swf ]; do mv --backup=t ./*.swf ~/Games/Flash; done
until [ ! -f *.sav ]; do mv --backup=t ./*.sav ~/Games/ROMs/Save\ Files; done
until [ ! -f *.srm ]; do mv --backup=t ./*.srm ~/Games/ROMs/Save\ Files; done
until [ ! -f *.oops ]; do mv --backup=t ./*.oops ~/Games/ROMs/Save\ Files; done
until [ ! -f *.gba ]; do mv --backup=t ./*.gba ~/Games/ROMs/Nintendo/GBA; done
until [ ! -f *.nes ]; do mv --backup=t ./*.nes ~/Games/ROMs/Nintendo/NES; done
until [ ! -f *.smc ]; do mv --backup=t ./*.smc ~/Games/ROMs/Nintendo/SNES; done
until [ ! -f *.sfc ]; do mv --backup=t ./*.sfc ~/Games/ROMs/Nintendo/SNES; done
until [ ! -f *.n64 ]; do mv --backup=t ./*.n64 ~/Games/ROMs/Nintendo/N64; done
until [ ! -f *.z64 ]; do mv --backup=t ./*.z64 ~/Games/ROMs/Nintendo/N64; done
until [ ! -f *.nds ]; do mv --backup=t ./*.nds ~/Games/ROMs/Nintendo/DS; done
until [ ! -f *.3ds ]; do mv --backup=t ./*.3ds ~/Games/ROMs/Nintendo/3DS; done
if [ -d ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/' ]; then #SKIP IF STARCRAFT MAPS FOLDER DOESN'T EXIST
  until [ ! -f *.scm ]; do mv --backup=t ./*.scm ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads'; done
  until [ ! -f *.scx ]; do mv --backup=t ./*.scx ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/BroodWar/Downloads'; done
fi

################################################################################
#APPLICATIONS
if [ ! -d ~/Applications ]; then #IF APPLICATIONS FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Applications
fi
until [ ! -f *.appimage ]; do mv --backup=t ./*.appimage ~/Applications; done
################################################################################
#MISCELLANEOUS
if [ ! -d ~/Desktop/Unconvertable ]; then #IF UNCONVERTABLE FOLDER DOESN'T EXIST, CREATE IT
  mkdir ~/Desktop/Unconvertable
fi
until [ ! -f *.flv ]; do mv --backup=t ./*.flv ~/Desktop/Unconvertable; done
until [ ! -f *.graffle ]; do mv --backup=t ./*.graffle ~/Desktop/Unconvertable; done
until [ ! -f *.icns ]; do mv --backup=t ./*.icns ~/Desktop/Unconvertable; done
until [ ! -f *.mid ]; do mv --backup=t ./*.mid ~/Desktop/Unconvertable; done
until [ ! -f *.svg ]; do mv --backup=t ./*.svg ~/Desktop/Unconvertable; done
################################################################################
#RENAME HIDDEN BACKUPS CREATED BY MV
cd ~/Documents/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
cd ~/Pictures/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
cd ~/Music/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
cd ~/Videos/Unsorted && rename -f 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
cd ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads' && rename 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
cd ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/BroodWar/Downloads' && rename 's/((?:\..+)?)\.~(\d+)~$/-$2$1/' *.~*~
cd
################################################################################

#touch ~/Desktop/cleanupreceipt.txt
