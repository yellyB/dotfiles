#!/bin/bash

TARGET_SSID="Bunjang_Office_10F"
EXCLUDED_AUDIO_DEVICE="외장 헤드폰"

CURRENT_SSID=$(networksetup -getairportnetwork en0 | cut -d ':' -f2 | xargs)
# CURRENT_OUTPUT=$(SwitchAudioSource -c)
CURRENT_OUTPUT=$(/opt/homebrew/bin/SwitchAudioSource -c)
# echo "Current Output Device: $CURRENT_OUTPUT"

if [ "$CURRENT_SSID" == "$TARGET_SSID" ]; then
  if [[ "$CURRENT_OUTPUT" != *"$EXCLUDED_AUDIO_DEVICE"* ]]; then
    osascript -e "set volume output volume 0"
  fi
fi
