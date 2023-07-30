#!/bin/sh

interface="$(ip tuntap show | cut -d : -f1 | head -n 1)"
ip="$(ip a s "${interface}" 2>/dev/null \
        | grep -o -P '(?<=inet )[0-9]{1,3}(\.[0-9]{1,3}){3}')"

MsgErr=" "
MsgOk=" "

if [ "${ip}" != "" ]; then
  echo "<txt><span weight='Bold' fgcolor='LightGreen'><i>$MsgOk</i></span><span weight='Bold' fgcolor='LightGray'><i>$ip</i></span></txt>"
else
  echo "<txt><span weight='Bold' fgcolor='Red'><i>$MsgErr</i></span><span weight='Bold' fgcolor='LightGray'><i>Disconnected</i></span></txt>"
fi
