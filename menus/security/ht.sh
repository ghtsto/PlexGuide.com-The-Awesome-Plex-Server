#!/bin/bash
#
# [HT Generator]
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
echo "INFO - @APPGUARD Starting Process Interface" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  
  dialog --title "PG APP Guard Protection" --msgbox "\nPurpose is to generate username and passwords for APPS without PROTECTION such as Heimdall, RuTorrent & Others.\n\nYour Password will Be Hashed for Protection.\n\nNOTE, your PORTS MUST BE CLOSED for this to work well! APP GUARD only protects by SUBDOMAIN ACCESS, not Ports!!!" 0 0

  dialog --title "Create a USERNAME (case senstive)" \
  --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
  --inputbox "USERNAME: " 8 50 2>/var/plexguide/server.ht.username
  user=$(cat /var/plexguide/server.ht.username)

    dialog --title "Create a PASSWORD (case senstive)" \
  --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
  --inputbox "PASSWORD: " 8 50 2>/var/plexguide/server.ht.pw
  pw=$(cat /var/plexguide/server.ht.pw)

  if dialog --stdout --title "Username & Password" \
        --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
        --yesno "\n$user - $pw\n\nCorrect?" 0 0; then
    dialog --title "Path Choice" --msgbox "\nUsername & Password are SET!" 0 0
    echo "INFO - Username & Password for AppGuard - SET" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

    ### Builds the Username & Password
    htpasswd -cbs /var/plexguide/server.ht $user $pw 1>/dev/null 2>&1
    echo "INFO - Password for AppGuard is Hashed" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

    ### Password is Hased, Files no Longer Needed
    rm -r /var/plexguide/server.ht.pw 1>/dev/null 2>&1
    rm -r /var/plexguide/server.ht.username 1>/dev/null 2>&1

    #### Rebuild Containers
    bash /opt/plexguide/menus/security/rebuild-ht.sh

    dialog --title "PG APP Guard Security" --msgbox "\nContainers without protection are now Protected!\n\nIf you need to change the USERNAME and/or PASSWORD, rerun this program!" 0 0

    echo "[ON]" > /var/plexguide/server.appguard
    echo "SUCCESS - APPGuard Deployed" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

    exit
  else
    echo "WARNING - Elected To Not Deploy AppGuard" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    dialog --title "PG APP Guard Status" --msgbox "\nYou noted that the Username & Password is NOT CORRECT!\n\nRestarting Process!" 0 0
    bash /opt/plexguide/menus/security/ht.sh
    exit
  fi

esac