#!/bin/bash

IP=$(/usr/sbin/ifconfig eth0 | grep "netmask" | awk '{print $2}')

if [ $IP ]; then
  echo " $IP "
else
  echo " No IP "
fi
