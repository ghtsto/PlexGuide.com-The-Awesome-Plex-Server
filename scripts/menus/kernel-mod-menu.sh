 #!/bin/bash

clear

################# init message

if (whiptail --title "Here Be Dragons" --yesno "Warning: Adjusting Kernel Parameters May Break Network Adapters or Even Brick Your Machine. Continue?" 8 56) then
  echo ok
else
  exit 0
fi

if (whiptail --title "Network Speed" --yesno "Is Your Server On at least a 500mbit line?" 8 56) then
  echo good
else
    whiptail --title "Network Speed - No" --msgbox "We reccomend only enabling BBR on slower networks." 9 66
fi

while [ 1 ]
do
CHOICE=$(
whiptail --title "Kernel Profiles" --menu "See Wiki For More Info + iperf Network Benchmarks. Install New Kernel First!" 14 50 6 \
    "1)" "Enable BBR TCP Congestion Control"  \
    "2)" "Klaver + BBR"  \
    "3)" "TJ007 + BBR"  \
    "4)" "Seedboxer + BBR"  \
    "5)" "Install Latest Generic Kernel"  \
    "6)" "Install Xanmod Kernel"  \
    "7)" "Exit"  3>&2 2>&1 1>&3
)

result=$(whoami)
case $CHOICE in
    "1)")
    clear
      # check if bbr is avail
      skip_tags='tj,klaver,seedboxer'
      if [[ $(grep 'CONFIG_TCP_CONG_BBR=' /boot/config-$(uname -r)) || $(cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep bbr) ]]
        then
        ansible-playbook /opt/plexguide/pg.yml --tags network_tuning --skip-tags $skip_tags
        cat /etc/sysctl.conf
        read -n 1 -s -r -p "Press any key to continue "
        bash /opt/plexguide/roles/processor/scripts/reboot.sh
      else
        whiptail --title "Unsupported Kernel" --msgbox "Your Kernel, $(uname -r) does not support BBR. Please Update Your Kernel." 9 66
        bash /opt/plexguide/scripts/menus/kernel-mod-menu.sh
      fi
    ;;

    "2)")
      clear
      # check if bbr is avail
      skip_tags='tj,seedboxer'
      if [[ $(grep 'CONFIG_TCP_CONG_BBR' /boot/config-$(uname -r)) || $(cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep bbr) ]]
      then
        ansible-playbook /opt/plexguide/pg.yml --tags network_tuning --skip-tags $skip_tags
        cat /etc/sysctl.conf
        read -n 1 -s -r -p "Press any key to continue "
        bash /opt/plexguide/roles/processor/scripts/reboot.sh
      else
        whiptail --title "Unsupported Kernel" --msgbox "Your Kernel, $(uname -r) does not support BBR. Please Update Your Kernel." 9 66
        bash /opt/plexguide/scripts/menus/kernel-mod-menu.sh
      fi
    ;;

    "3)")
      clear
      # check if bbr is avail
      skip_tags='klaver,seedboxer'
      if [[ $(grep 'CONFIG_TCP_CONG_BBR' /boot/config-$(uname -r)) || $(cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep bbr) ]]
      then
        ansible-playbook /opt/plexguide/pg.yml --tags network_tuning --skip-tags $skip_tags
        cat /etc/sysctl.conf
        echo ""
        read -n 1 -s -r -p "Press any key to continue "
        bash /opt/plexguide/roles/processor/scripts/reboot.sh
      else
        whiptail --title "Unsupported Kernel" --msgbox "Your Kernel, $(uname -r) does not support BBR. Please Update Your Kernel." 9 66
        bash /opt/plexguide/scripts/menus/kernel-mod-menu.sh
      fi
    ;;

    "4)")
      clear
      # check if bbr is avail
      skip_tags='klaver,tj'
      if [[ $(grep 'CONFIG_TCP_CONG_BBR' /boot/config-$(uname -r)) || $(cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep bbr) ]]
      then
        ansible-playbook /opt/plexguide/pg.yml --tags network_tuning --skip-tags $skip_tags
        cat /etc/sysctl.conf
        echo ""
        read -n 1 -s -r -p "Press any key to continue "
        bash /opt/plexguide/roles/processor/scripts/reboot.sh
      else
        whiptail --title "Unsupported Kernel" --msgbox "Your Kernel, $(uname -r) does not support BBR. Please Update Your Kernel." 9 66
        bash /opt/plexguide/scripts/menus/kernel-mod-menu.sh
      fi
    ;;

    "5)")
      clear
        if (whiptail --title "Kernel Upgrade" --yesno "Are You Sure You Want To Upgrade Your Kernel? (warning: this may break drivers)" 8 56) then
          sudo apt update -y && sudo apt sudo apt install --install-recommends linux-generic-hwe-16.04
          bash /opt/plexguide/roles/processor/scripts/reboot.sh
        else
            whiptail --title "Kernel Upgrade" --msgbox "Canceling Kernel Upgrade." 9 66
        fi
    ;;

    "6)")
      clear
        if (whiptail --title "Kernel Upgrade" --yesno "Are You Sure You Want To Install An Expirimental Kernel? (warning: this may break drivers)" 8 56) then
          echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - http://deb.xanmod.org/gpg.key | sudo apt-key add -
          sudo apt update && sudo apt install linux-xanmod-4.15
          bash /opt/plexguide/roles/processor/scripts/reboot.sh
        else
            whiptail --title "Kernel Upgrade" --msgbox "Canceling Kernel Upgrade." 9 66
        fi
    ;;

    "7)")
      clear
      exit 0
      ;;
esac
done
exit
