#!/usr/bin/env bash

dir="$HOME/.config/waybar"
style="dracula"

# terminate waybar
killall -q waybar

# wait until processes have been shut down
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done

# launch the bar
STATEFILE="/tmp/waybar-tray-state"

echo 0 > $STATEFILE
waybar -c "$dir/$style/config" -s "$dir/$style/style.css" &
