#!/bin/bash

#REQUIRES PERL & FFMPEG FOR BONUS FEATURES

################################################################################
# SCRIPT LOGGING ###############################################################
LOG="$HOME/Documents/desktopcleanup.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "### $TIMESTAMP" >> "$LOG"
exec > >(tee -a "$LOG") 2>&1

################################################################################
# TERMINAL COLORS ##############################################################
RED="\e[31m"
DEFAULT="\e[0m"

################################################################################
# SCHEDULES DESKTOPCLEANUP EVERY 15 MINUTES W/ CRONTAB #########################
if ! crontab -l | grep -q "desktopcleanup.sh"; then
  echo -e "${RED}crontab job not found.${DEFAULT} Scheduling desktopcleanup.sh every 15 minutes."
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
shopt -s nocaseglob #ENABLE CASE-INSENSITIVITY FOR GLOBBING
shopt -s nocasematch #ENABLE CASE-INSENSITIVITY FOR GLOBBING

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
        if [ ! -f "$source/$(basename "$file").part" ]; then #CHECK FOR TEMP FILE
          ((count++))
          if [ "$count" -eq 1 ]; then echo "Moving ${3}..."; fi #ECHO MOVE
          if [ ! -d "$destination" ]; then mkdir -p "$destination"; fi #CREATES DESTINATION
          mv --backup=t "$file" "$destination"
          #POSTCHECK FOR SPECIAL RULES# # # # # # # # # # # # # # # # # # # # #
          if [[ "${3}" == "fonts" ]]; then
            fc-cache -f #UPDATES FONT CACHE
          elif [[ "${3}" == "Linux applications" || "${3}" == "Windows applications" ]]; then
            chmod +x "$destination/$(basename "$file")" #MAKES EXECUTABLE
            ln -s "$destination/$(basename "$file")" ~/"Desktop/$(basename "$file" | cut -d. -f1)" #LINKS
          elif [[ "${3}" == "pictures" && "$(basename "$file")" =~ (screen.*shot|screen.*cap) ]]; then
            if [ ! -d ~/Pictures/Unsorted/Screenshots ]; then mkdir -p ~/Pictures/Unsorted/Screenshots; fi
            mv --backup=t "$destination/$(basename "$file")" ~/Pictures/Unsorted/Screenshots
          #elif [[ "${3}" == "audio" && $(stat -c %s "$file") -lt 1048576 ]]; then #CHECKS FOR SfX
          #  if [ ! -d ~/Music/SFX ]; then mkdir -p ~/Music/SFX; fi
          #  mv --backup=t "$destination/$(basename "$file")" ~/Music/SFX
          fi
          # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
        else echo -e "${RED}Temporary file found.${DEFAULT} Skipping..."
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
          if [ ! -f "$source/$(basename "$file").part" ]; then #CHECK FOR TEMP FILE
            ffmpeg -loglevel error -i "$file" "${file%.*}.${2}" && rm "$file"
          else echo -e "${RED}Temporary file found.${DEFAULT} Skipping conversion..."
          fi
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
commonBackup "." ~/Pictures/Projects "graphical projects" ".kra" ".psd" ".xcf"
commonBackup "." ~/Pictures/Unsorted "pictures" ".gif" ".jpg" ".jpeg" ".png" ".raw" ".svg" ".tiff"

################################################################################
# AUDIO ########################################################################
commonConvert "." "mp3" ".m4a" ".mpga"
commonBackup "." ~/Music/Sheet\ Music "sheet music files" ".mid" ".midi"
commonBackup "." ~/Music/Soundfonts "soundfonts" ".sf2"
commonBackup "." ~/Music/Unsorted "audio" ".aiff" ".flac" ".mp3" ".m4b" ".ogg" ".wav"

################################################################################
# VIDEO ########################################################################
commonConvert "." "mp4" ".divx" ".flv" ".mov" ".mpg" ".webm"
commonBackup "." ~/Videos/Projects "video projects" ".flb" ".kdenlive" ".mlt" ".osp" ".ove" ".xges"
commonBackup "." ~/Videos/Subtitles "subtitles" ".srt"
commonBackup "." ~/Videos/Unsorted "videos" ".3gp" ".avi" ".m4v" ".mkv" ".mp4" ".ogx"

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
commonBackup "." ~/Games/TCGs "decklists" ".ydk"

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
shopt -u nocaseglob #DISABLE CASE-INSENSITIVTY FOR GLOBBING
shopt -u nocasematch #DISABLE CASE-INSENSITIVTY FOR MATCHING

################################################################################
echo "COMPLETE!"
cd || exit

#TO-DO
#Add support for .run files
#Make fc-cache run only once
#Fix sending large music files to ~/Music/SFX
#ADDITIONS
#Added support for .kra (Krita), .xcf (Gimp)
#Added support for .flb, .kdenlive, .mlt, .osp, .ove, .xges (Video Projects)
#Added support for .ogx (Videos)
#Added support for .ydk (TCGs)
#Added timestamps to logging
#Moves sub-1Mb audio files to ~/Music/SFX
#CHANGES
#Changed ~/Pictures/Photoshop to ~/Pictures/Projects
#Silenced grep output & removed crontab job affirmation
#Drop extensions from links
#REMOVED
#FIXES
#Skips handling files with `.part`s in the same directory
#Restored font cache updating
#Fix Linking and Executability
#Fix Screenshots
