#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################

#######################
base="/mnt/gdrive/plexguide/wordpress/"

dialog --title "[ EXAMPLE: mysubdomain or plexguide ]" \
--backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
--inputbox "Type the Wordpress Subdomain/ID: " 8 50 2>/var/plexguide/wp.temp.id
id=$(cat /var/plexguide/wp.temp.id)

  if dialog --stdout --title "WP Server Subdomain/ID Restore" \
        --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
        --yesno "\nWordPress SubDomain/ID: $id\n\nCorrect?" 0 0; then
    ### Ensure Location Get Stored for Variables Role
    echo "$id" > /var/plexguide/wp.id
  else
    dialog --title "Server ID Choice" --msgbox "\nSelected - Not Correct - Rerunning!" 0 0
      bash /opt/plexguide/menus/wordpress/main.sh
      exit
  fi

############################## If Exists on Google Drive
file="/mnt/gdrive/plexguide/backup/wordpress/$id/$id/wordpress-$id.tar"
if [ -e "$file" ]
  then
    clear ## replace me  
  else
  dialog --title "--- WARNING ---" --msgbox "\nCannot Restore WP Server! Data Does Not Exist on GDrive!" 0 0
  exit
fi

file="/mnt/gdrive/plexguide/backup/wordpress/$id/$id-db/wordpress-$id-db.tar"
if [ -e "$file" ]
  then
    clear ## replace me  
  else
  dialog --title "--- WARNING ---" --msgbox "\nCannot Restore WP Server! DataBase Data Does Not Exist on GDrive!" 0 0
  exit
fi

clear
ansible-playbook /opt/plexguide/pg.yml --tags restorewp
read -n 1 -s -r -p "Press any key to continue"