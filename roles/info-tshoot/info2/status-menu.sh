 #!/bin/bash
 #
 # [PlexGuide Menu]
 #
 # GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
 # Author:   Admin9705 - Deiteq
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
 HEIGHT=15
 WIDTH=36
 CHOICE_HEIGHT=8
 BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
 TITLE="PGDrive Services Status Menu"
 MENU="Make a Selection Choice:"

 OPTIONS=(A "Gdrive"
          B "Gcrypt - Encrypted"
          C "Tdrive"
          D "Tcrypt - Encrypted"
          E "UnionFS"
          F "Move"
          G "Restart Menu"
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
        ## create log file if does not exist
        if [ -e "/opt/plexguide/gdrive.log" ]
        then
          echo "Log exists"
        else
          touch /opt/plexguide/gdrive.log
        fi

        ## obtains gdrive.service info and puts into a log to be displayed to the user
        clear
        systemctl status gdrive > /opt/plexguide/gdrive.log
        cat /opt/plexguide/gdrive.log
        echo
        echo "*** View the Log ***"
        echo
        read -n 1 -s -r -p "Press any key to continue "
        ;;

    B)
        ## create log file if does not exist
        if [ -e "/opt/plexguide/gcrypt.log" ]
        then
          echo "Log exists"
        else
          touch /opt/plexguide/gcrypt.log
        fi

        ## obtains gcrypt.service info and puts into a log to be displayed to the user
        clear
        systemctl status gcrypt > /opt/plexguide/gcrypt.log
        cat /opt/plexguide/gcrypt.log
        echo
        echo "*** View the Log ***"
        echo
        read -n 1 -s -r -p "Press any key to continue "
        ;;

    C)
        ## create log file if does not exist
        if [ -e "/opt/plexguide/tdrive.log" ]
        then
          echo "Log exists"
        else
          touch /opt/plexguide/tdrive.log
        fi

        ## obtains tdrive.service info and puts into a log to be displayed to the user
        clear
        systemctl status tdrive > /opt/plexguide/tdrive.log
        cat /opt/plexguide/tdrive.log
        echo
        echo "*** View the Log ***"
        echo
        read -n 1 -s -r -p "Press any key to continue "
        ;;

    D)
        ## create log file if does not exist
        if [ -e "/opt/plexguide/tcrypt.log" ]
        then
          echo "Log exists"
        else
          touch /opt/plexguide/tcrypt.log
        fi

        ## obtains tcrypt.service info and puts into a log to be displayed to the user
        clear
        systemctl status tcrypt > /opt/plexguide/tcrypt.log
        cat /opt/plexguide/tcrypt.log
        echo
        echo "*** View the Log ***"
        echo
        read -n 1 -s -r -p "Press any key to continue "
        ;;

    E)
        ## create log file if does not exist
        if [ -e "/opt/plexguide/unionfs.log" ]
        then
          echo "Log exists"
        else
          touch /opt/plexguide/unionfs.log
        fi

        ## obtains unionfs.service info and puts into a log to be displayed to the user
        clear
        systemctl status unionfs > /opt/plexguide/unionfs.log
        cat /opt/plexguide/unionfs.log
        echo
        echo "*** View the Log ***"
        echo
        read -n 1 -s -r -p "Press any key to continue "
        clear
        ;;

    F)
        ## create log file if does not exist
        if [ -e "/opt/plexguide/move.log" ]
        then
          echo "Log exists"
        else
          touch /opt/plexguide/move.log
        fi

        ## obtains move.service info and puts into a log to be displayed to the user
        clear
        systemctl status move > /opt/plexguide/move.log
        cat /opt/plexguide/move.log
        echo
        echo "*** View the Log ***"
        echo
        read -n 1 -s -r -p "Press any key to continue "
        clear
        ;;

    G)
        clear
        bash /opt/plexguide/roles/info-tshoot/info2/restart-menu.sh
        clear
        ;;

     Z)
        clear
        exit 0 ;;
esac

### loops until exit
bash /opt/plexguide/roles/info-tshoot/info2/status-menu.sh
