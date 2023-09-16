#!/bin/bash

IP=$(/usr/sbin/ifconfig enp0s8 | grep "netmask" | awk '{print $2}')
Msg=" "

if [ $IP ]; then
  #echo "<txt><span weight='Bold' fgcolor='Cyan'><i>$Msg</i></span><span weight='Bold' fgcolor='LightGreen'><i>$IP</i></span></txt>"
  echo "  $IP"
else
  #echo "<txt><span weight='Bold' fgcolor='Cyan'><i>$Msg</i></span><span weight='Bold' fgcolor='LightGreen'><i>No IP</i></span></txt>"
  echo "  No IP"
fi
