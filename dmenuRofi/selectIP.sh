#!/bin/bash
#

optionIP=$(echo -e "PwnIP\nIP VPN\nTarget" | rofi -dmenu -i -theme ~/.config/polybar/cuts/scripts/rofi/launcher.rasi)

myIPpwn=$(bash /home/bytehxz/Documents/Entorno/pwnedRed.sh)
vpnIP=$(bash /home/bytehxz/Documents/Entorno/statusVPN.sh 2>/dev/null)
targetIP=$(cat /home/bytehxz/Documents/Entorno/victima | awk '{print $1}')

# Para seleccionar que IP me va a colocar
if [ "$optionIP" == "PwnIP" ]; then 
  echo $myIPpwn 
elif [ "$optionIP" == "IP VPN" ]; then
  echo $vpnIP
elif [ "$optionIP" == "Target" ]; then
  echo $targetIP 
else
  echo -e "Opcion no valida"
fi
