#!/bin/bash

TRAY_ID_FILE="/tmp/polybar-tray-id"
TRAY_ID=$(cat $TRAY_ID_FILE)

polybar-msg -p $TRAY_ID cmd toggle
