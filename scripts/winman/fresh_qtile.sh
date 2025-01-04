#!/bin/sh
FRESHLOGS=$1
display_server=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

echo "Installing Qtile and the chosen Display Server..." >> $FRESHLOGS

sudo pacman -S --needed --noconfirm \
  qtile python-distutils-extra >> $FRESHLOGS 2>&1

if [ -z "$2" ]; then
  echo "Which display server do you want?"
  echo "1. X11"
  echo "2. Wayland"
  read -p "Please, choose a number: " input_value
  display_server="$input_value"
fi

if [ "$display_server" = "2" ]; then
  sudo pacman -S --needed --noconfirm \
    wlroots python-pywlroots python-pywayland python-xkbcommon\
    wofi >> $FRESHLOGS 2>&1
else
  sudo pacman -S --needed --noconfirm \
    xorg xorg-xserver unclutter dmenu rofi  >> $FRESHLOGS 2>&1
fi

