#!/bin/bash

STATEFILE="/tmp/waybar-tray-state"

if [[ $(cat $STATEFILE) -eq 0 ]] ; then
    waybar -c ~/.config/waybar/dracula/config_tray -s ~/.config/waybar/dracula/style_tray.css &

    echo 1 > $STATEFILE
else
    kill $(pgrep waybar | tail -n 1)

    echo 0 > $STATEFILE
fi
