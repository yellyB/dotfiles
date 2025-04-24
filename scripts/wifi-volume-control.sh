#!/bin/bash

TARGET_SSID="Bunjang_Office_10F"
CURRENT_SSID=$(networksetup -getairportnetwork en0 | cut -d ':' -f2 | xargs)

if [ "$CURRENT_SSID" == "$TARGET_SSID" ]; then
  osascript -e "set volume output volume 0"
fi
