#!/bin/bash
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Flicker-Rate
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

HEIGHT=10
WIDTH=50
CHOICE_HEIGHT=4
TITLE="Install Dark Themes"
MENU="Select App Theme"

OPTIONS=(A "DarkerNZBget - ydkmlt84 & Tronyx"
         X "Uninstall All Themes"
         Z "Exit")
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
            bash /opt/plexguide/menus/themes/darkernzbget.sh \
            -i docker -c nzbget && read -p "Press Any Key To Continue." ;;
        X)
            ansible-playbook /opt/plexguide/pg.yml --tags nzbget;;
        Z)
            clear
            exit 0 ;;
esac

bash /opt/plexguide/roles/main.sh
