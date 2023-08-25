#!/bin/bash

#REQUIRES PERL & FFMPEG

################################################################################
# SCRIPT LOGGING ###############################################################
LOG_FILE="$HOME/Documents/desktopcleanup.log"
exec > >(tee -a "$LOG_FILE") 2>&1

################################################################################
# TERMINAL COLORS ##############################################################
RED="\e[31m"
DEFAULT="\e[0m"

################################################################################
# SCHEDULES DESKTOPCLEANUP EVERY 15 MINUTES W/ CRONTAB #########################
if crontab -l | grep "desktopcleanup.sh"; then
  echo "Your Desktop Cleanup is scheduled!"
else
  echo -e "${RED}cron job not found.${DEFAULT} Scheduling desktopcleanup.sh every 15 minutes."
  crontab -l | { cat; echo "*/15 * * * * bash ~/Documents/desktopcleanup.sh"; } | crontab -
fi
#crontab -l | grep -v "desktopcleanup.sh" | crontab - #RUN TO UNINSTALL

################################################################################
# CD ###########################################################################
cd ~/Desktop || exit

################################################################################
# RENAMES FILES WITH FOREIGN MACOS CHARACTERS ##################################
declare -A foreignCharacters=(
  [""]=" - " #0xF002, HYPHEN
  [""]="\"" #0xF020, QUOTATION MARKS
  [""]="" #0xF021
  [""]="?" #0xF025, #QUESTION MARK
  [""]="|" #0xF027, VERTICAL BAR
  [""]="" #0xF00D
)

if [ -x "/usr/bin/rename" ]; then
  for char in "${!foreignCharacters[@]}"; do
    rename -f "s/$char/${foreignCharacters[$char]}/g" ./*
  done
else echo -e "${RED}rename command not found.${DEFAULT} Skipping renaming..."
fi

################################################################################
# GLOB SETUP ###################################################################
shopt -s nocaseglob #ENABLE CASE-INSENSITIVITY

################################################################################
# COMMON FUNCTIONS #############################################################
commonBackup() {
  local source="$1"
  local destination="$2"
  local filetypes=("${@:4}")
  local count=0

  for ext in "${filetypes[@]}"; do
    for file in "$source"/*"$ext"; do
      if [ -f "$file" ]; then
        ((count++))
        if [ "$count" -eq 1 ]; then echo "Backing up ${3}..."; fi
        if [ ! -d "$destination" ]; then mkdir -p "$destination"; fi
        mv --backup=t "$file" "$destination"
        if [[ "${file##*.}" == "appimage" || \
              "${file##*.}" == "x86_64" || \
              "${file##*.}" == "exe" ]]; then
          chmod +x "$destination/$(basename "$file")" #MAKES EXECUTABLE
          ln -s "$destination/$(basename "$file")" ~/"Desktop/$file Link" #LINKS TO DESKTOP
        fi
      fi
    done
  done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
commonConvert() {
  local source="$1"
  local filetypes=("${@:3}")
  local count=0

  for ext in "${filetypes[@]}"; do
    for file in "$source"/*"$ext"; do
      if [ -f "$file" ]; then
        ((count++))
        if [ "$count" -eq 1 ]; then echo "Converting to .${2}..."; fi
        if [ -x "/usr/bin/ffmpeg" ]; then
          ffmpeg -loglevel error -i "$file" "${file%.*}.${2}" && rm "$file"
        else echo -e "${RED}ffmpeg command not found.${DEFAULT} Skipping conversion..."
        fi
      fi
    done
  done
}

################################################################################
# FONTS ########################################################################
commonBackup "." ~/.local/share/fonts "fonts" ".otf" ".ttf"
fc-cache #UPDATES FONT CACHE

################################################################################
# APPLICATIONS #################################################################
commonBackup "." ~/Applications/Linux\ Packages "Linux packages" ".deb" ".rpm" ".flatpak" ".flatpakref"
commonBackup "." ~/Applications "Linux applications" ".appimage" ".x86_64"
commonBackup "." ~/Applications/Windows "Windows applications" ".exe"
commonBackup "." ~/Applications/MacOS "MacOS applications" ".app"
commonBackup "." ~/Applications/Android "Android applications"
commonBackup "." ~/Applications/Mozilla\ Extensions "Mozilla extensions" ".xpi"

################################################################################
# DOCUMENTS ####################################################################
commonBackup "." ~/Documents/Books "books" ".epub" ".pdf"
commonBackup "." ~/Documents/Unsorted "documents" ".ctb" ".doc" ".rtf" ".txt" ".xlsx"
commonBackup "." ~/Documents/Webpages "webpages" ".html" ".url"
#DISABLED BY DEFAULT, DELETE THE FOLLOWING '#' TO RE-ENABLE:
#commonBackup "." ~/Documents/Scripts "scripts" ".applescript" ".css" ".php" ".py" ".sh"
#commonBackup "." ~/Documents/Unsorted\ Archives "archives" ".7z" ".rar" ".tar.gz" ".zip"

################################################################################
# PICTURES #####################################################################
commonConvert "." "png" ".avif" ".bmp" ".webp"
commonBackup "." ~/Pictures/Photoshop "Photoshop files" ".psd"
commonBackup "." ~/Pictures/Unsorted "pictures" ".gif" ".jpg" ".jpeg" ".png" ".raw" ".svg" ".tiff"
commonBackup "." ~/Pictures/Unsorted/Screenshots "screenshots" "screen.png" "Screen*.png"

################################################################################
# AUDIO ########################################################################
commonConvert "." "mp3" ".m4a" ".mpga"
commonBackup "." ~/Music/Sheet\ Music "sheet music files" ".mid" ".midi"
commonBackup "." ~/Music/Soundfonts "soundfonts" ".sf2"
commonBackup "." ~/Music/Unsorted "audio" ".aiff" ".flac" ".mp3" ".m4b" ".ogg" ".wav"

################################################################################
# VIDEO ########################################################################
commonConvert "." "mp4" ".divx" ".flv" ".mov" ".mpg" ".webm"
commonBackup "." ~/Videos/Subtitles "subtitles" ".srt"
commonBackup "." ~/Videos/Unsorted "videos" ".3gp" ".avi" ".m4v" ".mkv" ".mp4"

################################################################################
# GAMES ########################################################################
commonBackup "." ~/Games/Flash "Flash games" ".swf"
commonBackup "." ~/Games/ROMs/Nintendo/NES "NES roms" ".nes"
commonBackup "." ~/Games/ROMs/Nintendo/SNES "SNES roms" ".smc" ".sfc"
commonBackup "." ~/Games/ROMs/Nintendo/N64 "N64 roms" ".n64" ".z64"
commonBackup "." ~/Games/ROMs/Nintendo/GBA "GBA roms" ".gba"
commonBackup "." ~/Games/ROMs/Nintendo/DS "DS roms" ".nds"
commonBackup "." ~/Games/ROMs/Nintendo/3DS "3DS roms" ".3ds"
commonBackup "." ~/Games/ROMs/Hacks "romhacks" ".ips" ".rnqs"
commonBackup "." ~/Games/Save\ Files "save files" ".sav" ".srm" ".oops"
commonBackup "." ~/Games/Text\ Adventures "text adventures" ".gblorb" ".z3" ".z5" ".z8"

if [ -d ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads' ]; then
  commonBackup "." ~/'.wine/drive_c/Program Files (x86)/StarCraft/Maps/downloads' "Starcraft maps" ".scm" ".scx"
fi

################################################################################
# DOWNLOADS ####################################################################
commonBackup "." ~/Downloads/Torrents "torrent files" ".torrent"

################################################################################
# MISCELLANEOUS ################################################################
commonBackup "." ~/Desktop/Dangerous\ Files "dangerous files" ".m4p"
commonBackup "." ~/Downloads/Unconvertable "unconvertable files" ".graffle" ".icns" ".numbers"

################################################################################
# GLOB SETDOWN #################################################################
shopt -u nocaseglob #DISABLE CASE-INSENSITIVTY

################################################################################
echo "COMPLETE!"
cd || exit
#touch ~/Desktop/cleanupreceipt.txt

#TO-DO
#ADDITIONS
#Added support for .mid, .midi (Sheet Music)
#Added support for .xpi (Mozilla extensions)
#Added support for .flatpak
#Added support for .rnqs files (Pokemon, ROMs/Hacks)
#Added support for .url under Webpages
#Now creates a .log file for bash output
#Color-coded error messages
#CHANGES
#Moved .html to ~/Documents/Webpages
#Renamed ROMs/Patches to ROMs/Hacks
#REMOVED
#FIXES
#ffmpeg fully replaces the extension
#Passes `shellcheck`
#Rewrote entire script to consolidate functions and remove glob errors
#Only runs `perl` & `ffmpeg` commands if they are installed
#Removed `rename` command to rename uppercase characters to lowercase
