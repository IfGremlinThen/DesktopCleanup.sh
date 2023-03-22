#!/bin/bash

#requires perl & ffmpeg
cd ~/Desktop

#RENAMES FILES WITH ODD CHARACTERS
rename -f 's///g' ./*
rename -f 's// - /g' ./*
rename -f 's//|/g' ./*
rename -f 's//?/g' ./*
rename -f 's//"/g' ./*
rename 's/\.([^.]+)$/.\L$1/' *

#TEXT
until [ ! -f *.doc ]; do mv ./*.doc ~/Documents/Unsorted; done
until [ ! -f *.html ]; do mv ./*.html ~/Documents/Unsorted; done
until [ ! -f *.pdf ]; do mv ./*.pdf ~/Documents/Unsorted; done
until [ ! -f *.rtf ]; do mv ./*.rtf ~/Documents/Unsorted; done
until [ ! -f *.txt ]; do mv ./*.txt ~/Documents/Unsorted; done
until [ ! -f *.xlsx ]; do mv ./*.xlsx ~/Documents/Unsorted; done

#IMAGES
until [ ! -f *.psd ]; do mv ./*.psd ~/Pictures/Photoshop; done
until [ ! -f *screen*.png ]; do mv ./*screen*.png ~/Pictures/Unsorted/Screenshots; done
until [ ! -f Screen*.png ]; do mv ./Screen*.png ~/Pictures/Unsorted/Screenshots; done
until [ ! -f *.gif ]; do mv ./*.gif ~/Pictures/Unsorted; done
until [ ! -f *.jpg ]; do mv ./*.jpg ~/Pictures/Unsorted; done
until [ ! -f *.jpeg ]; do mv ./*.jpeg ~/Pictures/Unsorted; done
for file in *.avif; do ffmpeg -i "$file" "$file".png; done
rm ./*.avif #CONVERTS .AVIF TO .PNG AND REMOVES REMAINING .AVIF FILES
for file in *.bmp; do ffmpeg -i "$file" "$file".png; done
rm ./*.bmp #CONVERTS .BMP TO .PNG AND REMOVES REMAINING .BMP FILES
for file in *.webp; do ffmpeg -i "$file" "$file".png; done
rm ./*.webp #CONVERTS .WEBP TO .PNG AND REMOVES REMAINING .WEBP FILES
until [ ! -f *.png ]; do mv ./*.png ~/Pictures/Unsorted; done

#AUDIO
until [ ! -f *.aiff ]; do mv ./*.aiff ~/Music/Unsorted; done
until [ ! -f *.flac ]; do mv ./*.flac ~/Music/Unsorted; done
until [ ! -f *.mp3 ]; do mv ./*.mp3 ~/Music/Unsorted; done
until [ ! -f *.m4b ]; do mv ./*.m4b ~/Music/Unsorted; done
until [ ! -f *.ogg ]; do mv ./*.ogg ~/Music/Unsorted; done
for file in *.m4a; do ffmpeg -i "$file" "$file".wav; done
rm ./*.m4a #CONVERTS .M4A TO .WAV AND REMOVES REMAINING .M4A FILES
for file in *.mpga; do ffmpeg -i "$file" "$file".mp3; done
rm ./*.mpga #CONVERTS .MPGA TO .MP3 AND REMOVES REMAINING .MPGA FILES
until [ ! -f *.wav ]; do mv ./*.wav ~/Music/Unsorted; done

#VIDEO
until [ ! -f *.3gp ]; do mv ./*.3gp ~/Videos/Unsorted; done
until [ ! -f *.avi ]; do mv ./*.avi ~/Videos/Unsorted; done
until [ ! -f *.mkv ]; do mv ./*.mkv ~/Videos/Unsorted; done
until [ ! -f *.m4v ]; do mv ./*.m4v ~/Videos/Unsorted; done
for file in *.mov; do ffmpeg -i "$file" "$file".mp4; done
rm ./*.mov #CONVERTS .MOV TO .MP4 AND REMOVES REMAINING .MOV FILES
for file in *.webm; do ffmpeg -i "$file" "$file".mp4; done
rm ./*.webm #CONVERTS .WEBM TO .MP4 AND REMOVES REMAINING .WEBM FILES
until [ ! -f *.mp4 ]; do mv ./*.mp4 ~/Videos/Unsorted; done

#GAMES
until [ ! -f *.gba ]; do mv ./*.gba ~/Games/ROMs/Gameboy\ Advance; done
until [ ! -f *.nes ]; do mv ./*.nes ~/Games/ROMs; done
until [ ! -f *.sav ]; do mv ./*.sav ~/Games/ROMs/Save\ Files; done
until [ ! -f *.sav ]; do mv ./*.oops ~/Games/ROMs/Save\ Files; done
until [ ! -f *.sfc ]; do mv ./*.sfc ~/Games/ROMs; done
until [ ! -f *.smc ]; do mv ./*.smc ~/Games/ROMs/Super\ Nintendo; done
until [ ! -f *.scm ]; do mv ./*.scm ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads'; done
until [ ! -f *.scx ]; do mv ./*.scx ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/BroodWar/Downloads'; done

#MISCELLANEOUS
until [ ! -f *.flv ]; do mv ./*.flv ~/Desktop/Unconvertable; done
until [ ! -f *.graffle ]; do mv ./*.graffle ~/Desktop/Unconvertable; done
until [ ! -f *.icns ]; do mv ./*.icns ~/Desktop/Unconvertable; done
until [ ! -f *.mid ]; do mv ./*.mid ~/Desktop/Unconvertable; done
until [ ! -f *.swf ]; do mv ./*.swf ~/Desktop/Unconvertable; done
until [ ! -f *.svg ]; do mv ./*.svg ~/Desktop/Unconvertable; done
cd
echo "Desktop cleaning in progress!"
