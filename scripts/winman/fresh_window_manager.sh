#!/bin/sh

FRESHLOGS=$1
whichwm=$2
display_server=$3
wantsddm=$4
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

if [[ -z "$2" ]]; then
  echo "1. Qtile"
  read -p "Which Window Manager will you be using? (Choose a number): " input_value
  whichwm="$input_value"
fi

if [[ -z "$3" ]]; then
  echo "You did not specified a Display Server"
  echo "1. X11"
  echo "2. Wayland"
  echo "Default: X11"
  read -p "Which one do you want? (Choose a number): " input_value
  display_server="$input_value"
fi

{
  sudo pacman -S --needed --noconfirm \
  pavucontrol feh dunst wezterm \
  vivaldi polybar spotify-launcher playerctl \
  libxdamage at-spi2-core
} >> $FRESHLOGS 2>&1

if [[ "$whichwm" == "1" ]]; then
  echo "Installing Qtile and the chosen Display Server"
  ./fresh_qtile.sh $FRESHLOGS
  
  echo "Everything in order to use qtile is installed!"
  echo "Let's proceed with the session manager (SDDM)!"
fi


if [ -z $4 ]; then
  read -p "Do you want to use SDDM? (yes/no): " input_value
  wantsddm="$input_value"
fi

if [[ "$wantsddm" == "yes" ]] || [[ "$wantsddm" == "y" ]]; then
  ../fresh_sddm.sh
fi

