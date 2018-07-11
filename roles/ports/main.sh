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
export NCURSES_NO_UTF8_ACS=1
echo 'INFO - @Ports OPEN/Close Menu' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

############################################################ Recall Server Port Status
status=$(cat /var/plexguide/server.ports.status)

dialog --title "Very Important" --msgbox "\nYour Applications Port Status: $status\n\nYou must decide to keep your PORTS opened or closed. Close the PORTS if the REVERSE PROXY (subdomains) are working!" 0 0

############ Menu
HEIGHT=10
WIDTH=52
CHOICE_HEIGHT=4
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="Make a Choice"
MENU="Ports are Currently >>> $status"

OPTIONS=(A "Ports: OPEN"
         B "Ports: CLOSED"
         Z "Exit - No Change")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        A)
        dialog --infobox "Please Wait!" 3 35
        sleep 1
            echo "[OPEN]" > /var/plexguide/server.ports.status
            rm -r /var/plexguide/server.ports
            touch /var/plexguide/server.ports
echo 'INFO - Select to OPEN Ports' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

            ;;
        B)
        dialog --infobox "Please Wait!" 3 50
        sleep 1
        dialog --title "WARNING! WARNING! WARNING!" --msgbox "\nYou are CLOSING your PORTS! What does that mean? Visit ports.plexguide.com for detailed info!\n\nBasically, a program such as Sonnar cannot communicate to NZBGET. In the host field, instead of https://nzbget.plexguide.com, just put the name of the container; in this case - nzbget.\n\nVisit the site for more information!" 0 0
            echo "[CLOSED]" > /var/plexguide/server.ports.status
            echo "127.0.0.1:" > /var/plexguide/server.ports
echo 'INFO - Select to CLOSE Ports' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

            ;;
        Z)
            clear
            exit 0 ;;
esac

clear
bash /opt/plexguide/roles/traefik/scripts/rebuild.sh
echo "" & read -n 1 -s -r -p "Press any key to continue"
dialog --title "Final Note" --msgbox "\nYour Containers Are Built!" 0 0
