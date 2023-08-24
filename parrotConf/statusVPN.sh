#!/usr/bin/bash

IP=$(/usr/sbin/ifconfig tun0 | grep "netmask" | awk '{print $2}')

if [ $IP ]; then
  echo "  $IP"
else
  echo "  No VPN"
fi

