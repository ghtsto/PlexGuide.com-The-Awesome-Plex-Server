 #!/bin/bash

clear

sudo touch /var/plexguide/asked.processor
################# Virtual Machine Check
#dialog --title "Hello" --msgbox 'Hello world!' 6 20

if (whiptail --title "Virutal Machine Question" --yesno "Are You Utilizing A Virtual Machine or VPS?" 8 56) then

    whiptail --title "Virutal Machine - Yes" --msgbox "We are unable to adjust your CPU performance while utilizing a VM or VPS. Trust me, it does not work if you try!" 9 66
    exit
else
    whiptail --title "Virutal Machine - No" --msgbox "We recommend that you select performance mode. By default, your utilizing ondemand mode. Mode does not kick in until you REBOOT!" 9 66
fi

while [ 1 ]
do
CHOICE=$(
whiptail --title "Processor Performance" --menu "Make your choice" 12 38 5 \
    "1)" "Performance Mode"  \
    "2)" "Ondemand Mode"  \
    "3)" "Conservative Mode"  \
    "4)" "View Processor Policy"  \
    "5)" "Exit  "  3>&2 2>&1 1>&3
)

result=$(whoami)
case $CHOICE in
    "1)")
    clear
    ansible-playbook /opt/plexguide/roles/processor/processor.yml  --tags performance
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    bash /opt/plexguide/roles/processor/scripts/reboot.sh
    ;;

    "2)")
    clear
    ansible-playbook /opt/plexguide/roles/processor/processor.yml  --tags ondemand
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    bash /opt/plexguide/roles/processor/scripts/reboot.sh
    ;;

    "3)")
    clear
    ansible-playbook /opt/plexguide/roles/processor/processor.yml  --tags conservative
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    bash /opt/plexguide/roles/processor/scripts/reboot.sh
    ;;

    "4)")
    clear
    cpufreq-info
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;

    "5)")
      clear
      exit 0
      ;;
esac
done
exit
