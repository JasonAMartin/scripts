#!/bin/bash

#####
# This is a bash script that downloads and installs add-ons for ESO.
# It will also save the zips for archival reasons.
# I didn't like the Java program ESO players normally use for add-on management, so I made a simple Bash script to do the job.
# Version 1.0
# You need to set a few variables to make it work. From there, you can just run the script.
# I have this as an inport in .bashrc, so I can just run update-eso-addons from terminal. 
# If you don't do this, you'll need to add a line that kicks off update-eso-addons() when run.
#####

ESO_ADDONS_DIRECTORY="/some/dir"

ESO_ARCHIVE_DIRECTORY="/some/dir"

# Add urls for the add-ons you want here. This script will follow those links and get the zip file.

ESO_ADDON_URLS=(
  "https://www.esoui.com/downloads/download1346-DolgubonsLazyWritCrafter"
  "https://www.esoui.com/downloads/download57-HarvestMap.html"
  "https://www.esoui.com/downloads/download288-LoreBooks.html"
  "https://www.esoui.com/downloads/download1643-BanditsUserInterface.html"
  "https://www.esoui.com/downloads/download128-SkyShards.html"
  "https://www.esoui.com/downloads/download928-MasterMerchant.html"
  "https://www.esoui.com/downloads/download97-Dustman.html"
  "https://www.esoui.com/downloads/download1812-AlphaGear2.html"
  "https://www.esoui.com/downloads/download914-VotansSearchBox.html"
  "https://www.esoui.com/downloads/download2103-PerfectPixel.html"
  "https://www.esoui.com/downloads/download1022-QuestMap.html"
  "https://www.esoui.com/downloads/download1863-UrichsSkillPointFinder.html"
  "https://www.esoui.com/downloads/download1001-VotansAchievementsOverview.html"
  "https://www.esoui.com/downloads/download818-LuiExtended.html"
)

update-eso-addons() {
  # reset file to blank
  echo "" > "$ESO_ADDONS_DIRECTORY/addons.txt"

  # iterate though all addon urls and scrape out the download URL
  for i in "${ESO_ADDON_URLS[@]}"
  do
    :
    curl $i | grep 'src="https://cdn.esoui.com/downloads/' | grep -oP 'https:\/\/cdn.esoui.com\/downloads\/\s*[^?]+' | xargs echo "$1" >> "$ESO_ADDONS_DIRECTORY/addons.txt"
  done

  # replace urls with spaces with url encoding and fix replace error
  sed -i 's/ /%20/g' "$ESO_ADDONS_DIRECTORY/addons.txt"
  sed -i 's/%20https/https/g' "$ESO_ADDONS_DIRECTORY/addons.txt"

  # read in addons file line by line and call update-single-eso-addon function with ZIP file url for addon.
  while IFS= read -r line
  do
    if [ -n "$line" ]; then
      update-single-eso-addon "$line"
    fi
  done <"$ESO_ADDONS_DIRECTORY/addons.txt"
}

# Called with a zip file url.
# It will check addons_versions to see if I have previously downloaded the zip or not and if not:
# It will curl it, unzip to ESO addons directory and save the zip to the ESO archives.
update-single-eso-addon() {
    if cat "$ESO_ADDONS_DIRECTORY/addons_versions.txt" | grep $1
    then
      echo "NOTHING TO DO: $1"
    else
      ESO_ZIP="$(echo "$1" | grep -oP '([A-Z])\w+.zip')"
      echo "ADDING: $ESO_ZIP"
      echo $1 >> "$ESO_ADDONS_DIRECTORY/addons_versions.txt"
      curl "$1" --output "$ESO_ZIP" && unzip -o "$ESO_ZIP" -d "$ESO_ADDONS_DIRECTORY" && mv "$ESO_ZIP" $ESO_ARCHIVE_DIRECTORY
    fi
}

eso-addons() {
  actions=$(menu)
  printf "\r%b" "\033c" # this clear the screen
  echo "$actions"
  actions2=$(menu2)
  printf "\r%b" "\033c" # this clear the screen
}
