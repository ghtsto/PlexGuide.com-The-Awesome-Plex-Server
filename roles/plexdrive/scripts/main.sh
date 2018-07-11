#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq & FlickerRate
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

plexdrive --version > /tmp/pdversion 
pdversion=$( cat /tmp/pdversion)

############ Menu
HEIGHT=12
WIDTH=50
CHOICE_HEIGHT=5
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="PlexDrive for PG"
MENU="Choose one of the following options:"

OPTIONS=(A "PlexDrive4 "
         B "PlexDrive5 "
         C "Remove PlexDrive Tokens"
         D "Stop & Remove Current PD; then Reboot!"
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

            if [ "$pdversion" == "5.0.0" ]
            then
                if dialog --stdout --title "PAY ATTENTION!" \
                    --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
                    --yesno "\nYou Selected PLEXDRIVE4.  You are running PLEXDRIVE5 as of now!\n\nIf switching, we must stop the current one and remove it. Afterwards, we will reboot your SYSTEM and YOU MUST rerun PLEXDRIVE 4 Again.\n\nDo You Want to Proceed?" 14 50; then
                
                    systemctl stop plexdrive
                    rm -r /etc/systemd/system/plexdrive.service 
                    rm -r /usr/bin/plexdrive
                    dialog --title "PG Update Status" --msgbox "\nYour System Must Now Reboot!\n\nMake sure you come back and rerun PLEXDRIVE4 Again!" 0 0
                    clear
                    echo "Make Sure to Rerun PlexDrive4 through the Interface!"
                    echo ""
                    reboot
                else
                    dialog --title "PG Update Status" --msgbox "\nExiting - User Selected No" 0 0
                    exit 0 
                fi
            fi

            if dialog --stdout --title "PlexDrive 4 Install" \
              --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
              --yesno "\nDo you want to install PlexDrive4? Your System Will Reboot Automatically After!" 8 50; then
                clear

                    echo "true" > /tmp/alive
                    sudo ansible-playbook /opt/plexguide/pg.yml --tags plexdrive --skip-tags plexd5
                    #read -n 1 -s -r -p "Press any key to continue "
                    loop="true"
                    echo "true" > /tmp/alive
                    #while [ "$loop" = "true" ]
                    #do
                    #    dialog --infobox "Installing." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing.." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing..." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing...." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing....." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......" 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing........" 3 22
                    #    sleep 1
                    #    loop=$(cat /tmp/alive)
                    #done &
                mv /tmp/plexdrive-linux-amd64 plexdrive
                mv plexdrive /usr/bin/
                cd /usr/bin/
                chown root:root /usr/bin/plexdrive
                chmod 755 /usr/bin/plexdrive
                systemctl enable plexdrive
                bash -x /opt/plexguide/roles/plexdrive/scripts/check4.sh &>/dev/null &
                bash -x /opt/plexguide/roles/plexdrive/scripts/pd4.sh 2>&1 | tee /opt/appdata/plexguide/plexdrive.info
                loop="false"
            else
                dialog --title "PG Update Status" --msgbox "\nExiting - User Selected No" 0 0
                echo "Type to Restart the Program: sudo plexguide"
                exit 0
            fi

            ;;
        B)

            if [ "$pdversion" == "4.0.0" ]
            then
                if dialog --stdout --title "PAY ATTENTION!" \
                    --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
                    --yesno "\nYou Selected PLEXDRIVE4.  You are running PLEXDRIVE5 as of now!\n\nIf switching, we must stop the current one and remove it. Afterwards, we will reboot your SYSTEM and YOU MUST rerun PLEXDRIVE 5 Again.\n\nDo You Want to Proceed?" 14 50; then
                
                    systemctl stop plexdrive
                    rm -r /etc/systemd/system/plexdrive.service 
                    rm -r /usr/bin/plexdrive
                    dialog --title "PG Update Status" --msgbox "\nYour System Must Now Reboot!\n\nMake sure you come back and rerun PLEXDRIVE5 Again!" 0 0
                    clear
                    echo "Make Sure to Rerun PlexDrive5 through the Interface!"
                    echo ""
                    reboot
                else
                    dialog --title "PG Update Status" --msgbox "\nExiting - User Selected No" 0 0
                    exit 0 
                fi
            fi

            if dialog --stdout --title "PlexDrive 5 Install" \
              --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
              --yesno "\nDo you want to Install PlexDrive5? Your System Will Reboot Automatically After!" 8 50; then
                clear

                    echo "true" > /tmp/alive
                    sudo ansible-playbook /opt/plexguide/pg.yml --tags plexdrive --skip-tags plexd4 
                    read -n 1 -s -r -p "Press any key to continue"

                    loop="true"
                    echo "true" > /tmp/alive
                    #while [ "$loop" = "true" ]
                    #do
                    #    dialog --infobox "Installing." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing.." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing..." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing...." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing....." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......" 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing........" 3 22
                    #    sleep 1
                    #    loop=$(cat /tmp/alive)
                    #done &
                mv /tmp/plexdrive-linux-amd64 plexdrive 1>/dev/null 2>&1
                mv plexdrive /usr/bin/ 1>/dev/null 2>&1
                cd /usr/bin/
                chown root:root /usr/bin/plexdrive
                chmod 755 /usr/bin/plexdrive
                systemctl enable plexdrive
                
                bash /opt/plexguide/roles/plexdrive/scripts/check5.sh &>/dev/null &

                file="/root/.plexdrive/token.json"
                if [ -e "$file" ]
                    then
                        bash /opt/plexguide/roles/plexdrive/scripts/check5c.sh &>/dev/null &
                    else
                        clear 1>/dev/null 2>&1
                fi
                
                bash -x /opt/plexguide/roles/plexdrive/scripts/pd5.sh 2>&1 | tee /opt/appdata/plexguide/plexdrive.info
                loop="false"
            else
                dialog --title "PG Update Status" --msgbox "\nExiting - User Selected No" 0 0
                echo "Type to Restart the Program: sudo plexguide"
                exit 0
            fi
            ;;
        C)
            rm -r /root/.plexdrive 1>/dev/null 2>&1
            rm -r ~/.plexdrive 1>/dev/null 2>&1
            dialog --title "Token Status" --msgbox "\nThe Tokens were Removed" 0 0
            bash /opt/plexguide/roles/plexdrive/scripts/main.sh 
            ;;
        D)
            systemctl stop plexdrive 1>/dev/null 2>&1
            sudo rm -r /etc/systemd/system/plexdrive.service 1>/dev/null 2>&1
            bash /opt/plexguide/roles/plexdrive/scripts/main.sh 1>/dev/null 2>&1
            dialog --title "PD Status" --msgbox "\nWe Are Going To Restart Your System!\n\nMake sure you come back and pick a version of PlexDrive!" 0 0
            clear
            echo "Make sure to come back and pick a version of PlexDrive to ReRun!"
            echo ""
            reboot
            exit 0 ;;
        Z)
            clear
            exit 0 ;;
esac
