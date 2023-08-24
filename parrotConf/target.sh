#!/bin/bash

ip_address=$(/bin/cat /home/bytehxz/Documents/Entorno/victima | awk '{print $1}')
machine_name=$(/bin/cat /home/bytehxz/Documents/Entorno/victima | awk '{print $2}')
 

if [ $ip_address ] && [ $machine_name ]; then
    echo "$ip_address - $machine_name"
else
    echo "  No target"
fi
