#!/bin/sh

# Check if we're in a desktop environment and all conditions for notify-send are met
if [[ -n "$DISPLAY" || "$XDG_SESSION_TYPE" == "x11" || "$XDG_SESSION_TYPE" == "wayland" ]] && 
   pgrep -x "dunst" > /dev/null &&
   dunstctl is-paused | grep -q "false"; then
  notify-send "$1"
else
  echo "$1"
fi

