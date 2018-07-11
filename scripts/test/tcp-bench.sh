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
# REMOTE REQUIREMENTS:
# PlexGuide Dev on remote
# SSH key auth on remote
# iperf, permissive firewall
#
# LOCAL REQUIREMENTS:
# iperf, permissive firewall
#
# Install SSH keys on remote:
#
# Usage: ./tcp-bench <ip.address>
###################
which nslookup &>/dev/null || echo please install dnsutils
which nc &>/dev/null || echo please install nc
which iperf &>/dev/null || echo please install iperf

trys=10
ip=195.201.98.159
#ip=107.155.94.69
#ip=$1
bufferlen=8
time=60

pingtest() {
        local ping_link=$( echo ${1#*//} | cut -d"/" -f1 )
        local ping_ms=$( ping -w1 -c1 $ping_link | grep 'rtt' | cut -d"/" -f5 )
        if [[ $ping_ms == "" ]]; then
                printf "error"
        else
                printf "%3i.%sms" "${ping_ms%.*}" "${ping_ms#*.}"
        fi
}

benchmark(){
  echo -n '' > $1
  nohup ssh $ip 'pkill iperf' >nohup.out 2>&1 &
	echo -n '='
	ssh $ip "ansible-playbook /opt/plexguide/pg.yml\
		 --tags network_tuning --skip-tags $1 &>/dev/null"
	echo -n '='
  nohup ssh $ip 'reboot now' >nohup.out 2>&1 &
	echo -n '='
  sleep 10
	echo -n '='
  while ! nc -nz $ip 22 ; do sleep 3;done
	echo -n '='
  sleep 5
	echo -n '='
  nohup ssh $ip 'iperf -s' >nohup.out 2>&1 &
	sleep 5
	start=$(date +%s)
	echo -n '~'
	for i in $(seq $trys); do
		iperf -c $ip -d -t $time | grep Mbits >> $1
		echo -n '='
	done
	echo ''

	avgup=$(sed -n 2~2p $1 | awk '{ total += $7; count++ } END { print total/count }')
	avgdown=$(sed -n 1~2p $1 | awk '{ total += $7; count++ } END { print total/count }')
	end=$(date +%s)
	elapsed=$(( $end - $start ))
	minutes=$(( $elapsed / 60 ))

  if [[ $2 == 'baseline' ]]; then
    baseline_avgup=$avgup
    baseline_avgdown=$avgdown
  fi

  if [[ avgup != '' ]]; then
    perc_up=$(bc <<< "scale=2; ($avgup - $baseline_avgup)/$baseline_avgup * 100")
    perc_down=$(bc <<< "scale=2; ($avgdown - $baseline_avgdown)/$baseline_avgdown * 100")
  else
    perc_up=0
    perc_down=0
  fi

	echo "AVG Down Speed: $avgdown mbit/s ($signdown$perc_down%)"
	echo "AVG Up Speed  : $avgup mbit/s ($sign$perc_up%)"
	echo "Elapsed Time  : $minutes minutes"
	echo "======================================="
	echo
}

echo
echo "PLEXGUIDE TCP TUNER BENCHMARK"
echo "======================================="
echo "Sample Size: $trys"
echo "Buffer Size: $bufferlen KB"
echo "TCP Window : 128 KB"
echo "Time       : $time seconds"
#echo "NZB Article: $(du -h $1 | awk '{print $1}')"
echo "Ping       :$(pingtest $ip)"
echo "======================================="
echo ""

echo "Baseline"
benchmark 'bbr,klaver,tj,seedboxer' baseline

echo "BBR"
benchmark 'klaver,tj,seedboxer'

echo "BBR + Klaver"
benchmark 'tj,seedboxer'

echo "BBR + tj"
benchmark 'klaver,seedboxer'

echo "BBR + seedboxer"
benchmark 'klaver,tj'
