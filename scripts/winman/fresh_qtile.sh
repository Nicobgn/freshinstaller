#!/bin/sh
FRESHLOGS=$1
display_server=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

echo "Installing Qtile and the chosen Display Server..." >> $FRESHLOGS

sudo pacman -S --needed --noconfirm \
  qtile python-distutils-extra >> $FRESHLOGS 2>&1

if [[ "$display_server" == "2" ]]; then
  sudo pacman -S --needed --noconfirm \
    wlroots python-pywlroots python-pywayland python-xkbcommon\
    wofi >> $FRESHLOGS 2>&1
else
  sudo pacman -S --needed --noconfirm \
    xorg xorg-xserver unclutter dmenu rofi  >> $FRESHLOGS 2>&1
fi

