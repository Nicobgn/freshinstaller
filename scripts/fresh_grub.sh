#!/bin/sh
FRESHLOGS=$1
repo=$2
theme=$3
style=$4
side=$5
screensize=$6
color=$7

if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

if [ -z "$2" ]; then
  echo "Which theme group do you want?"
  echo "1. Vinceliuice/Elegant-grub2-themes (github)"
  echo "2. Vinceliuice/grub2-themes (github)"
  read -p "Which one do you want? (Choose a number): " input_value
  repo="$input_value"
fi

if [ -d "/tmp/grub-theme" ]; then
  rm -rf "/tmp/grub-theme"
fi

if [ "$repo" == "1" ]; then
  git clone https://github.com/vinceliuice/Elegant-grub2-themes.git /tmp/grub-theme >> $FRESHLOGS 2>&1
  
  if [ -z "$3" ]; then
    echo "Which theme do you want?"
    echo "Forest"
    echo "Mojave"
    echo "Mountain"
    echo "Wave"
    read -p "Please, select an option (lowercase): " input_value
    theme="$input_value"
  fi

  if [ -z "$4" ]; then
    echo "Which style do you want?"
    echo "Window"
    echo "Float"
    echo "Sharp"
    echo "Blur"
    read -p "Please, select an option (lowercase): " input_value
    style="$input_value"
  fi

  if [ -z "$5" ]; then
    echo "Which side do you want?"
    echo "Left"
    echo "Right"
    read -p "Please, select an option (lowercase): " input_value
    side="$input_value"
  fi

  if [ -z "$6" ]; then
    echo "Which is your screen size?"
    echo "1080p (FHD)"
    echo "2K"
    echo "4K"
    read -p "Please, select an option (lowercase): " input_value
    screensize="$input_value"
  fi

  if [ -z "$7" ]; then
    echo "Which color theme do you want?"
    echo "Dark"
    echo "Light"
    read -p "Please, select an option (lowercase): " input_value
    color="$input_value"
  fi

  sudo /tmp/grub-theme/install.sh -t "$theme" -p "$style" -i "$side" -c "$color" -s $screensize -b >> $FRESHLOGS 2>&1

elif [ "$repo" == "2" ]; then
  git clone https://github.com/vinceliuice/grub2-themes.git /tmp/grub-theme >> $FRESHLOGS 2>&1

  if [ -z "$3" ]; then
    echo "Which theme do you want?"
    echo "Tela"
    echo "Vimix"
    echo "Stylish"
    echo "Whitesur"
    read -p "Please, select an option (lowercase): " input_value
    theme="$input_value"
  fi

  if [ -z "$4" ]; then
    echo "Which icon color do you want?"
    echo "Color"
    echo "White"
    echo "Whitesur"
    read -p "Please, select an option (lowercase): " input_value
    style="$input_value"
  fi
  
  if [ -z "$6" ]; then
    echo "Which is your screen size?"
    echo "1080p (FHD)"
    echo "2K"
    echo "4K"
    echo "Ultrawide"
    echo "Ultrawide2k"
    read -p "Please, select an option (lowercase): " input_value
    screensize="$input_value"
  fi

  sudo /tmp/grub-theme/install.sh -t "$theme" -i "$style" -s "$screensize" -b >> $FRESHLOGS 2>&1
fi

