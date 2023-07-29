#!/bin/bash

ip_address=$(/bin/cat /home/bytehxz/Documents/Entorno/victima | awk '{print $1}')
machine_name=$(/bin/cat /home/bytehxz/Documents/Entorno/victima | awk '{print $2}')
 


if [ $ip_address ] && [ $machine_name ]; then
    iconT="󰯐 "
    echo "<txt><span weight='Bold' fgcolor='Red'><i>$iconT</i></span><span weight='Bold' fgcolor='Cyan'><i>$ip_address</i></span> - <span weight='Bold' fgcolor='Gray'><i>$machine_name</i></span></txt>"
else
    noTar="󰈉 "
    Ntarget="No target"
    echo "<txt><span weight='Bold' fgcolor='Cyan'><i>$noTar</i></span><span weight='Bold' fgcolor='White'><i>$Ntarget</i></span></txt>"
fi
