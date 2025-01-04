#!/bin/sh
FRESHLOGS=$1
theme=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi
if [ ! -f "$FRESHLOGS" ]; then
  sudo touch "$FRESHLOGS"
  sudo chmod 666 "$FRESHLOGS"
fi

sudo echo "Sudo privileges enabled!"

if [ -z "$2" ]; then
  echo "You forgot to tell which theme do you want."
  echo "1. Sugar Candy"
  echo "2. Chili"
  echo "3. Both"
  echo "Anything else: Nothing"
  read -p "Which one do you want? (Choose a number): " input_value
  theme="$input_value"
fi

{
  sudo pacman -S --needed --noconfirm \
    git sddm qt5 qt5-quickcontrols2 qt5-graphicaleffects qt5-svg 
} >> $FRESHLOGS 2>&1

if [ ! -f "/etc/sddm.conf" ]; then
  sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf
fi

if [ ! -d "/usr/share/sddm/themes" ]; then
  sudo mkdir /usr/share/sddm /usr/share/sddm/themes
fi

case "$theme" in
  1)
    echo "## You chose Sugar Candy theme" >> "$FRESHLOGS"
    
    git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git /usr/share/sddm/themes/sugar-candy >> "$FRESHLOGS" 2>&1
    echo "Sugar Candy theme is installed!"
    echo "Enable it by editing /etc/sddm.conf!"
    ;;
  2)
    echo "## You chose Chili theme" >> "$FRESHLOGS"
    
    git clone https://github.com/MarianArlt/sddm-chili.git /usr/share/sddm/themes/chili >> "$FRESHLOGS" 2>&1
    echo "Chili theme is installed!"
    echo "Enable it by editing /etc/sddm.conf!"
    ;;
  3)
    echo "## You chose both themes (Sugar Candy and Chili)" >> "$FRESHLOGS"
    
    git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git /usr/share/sddm/themes/sugar-candy >> "$FRESHLOGS" 2>&1
    git clone https://github.com/MarianArlt/sddm-chili.git /usr/share/sddm/themes/chili >> "$FRESHLOGS" 2>&1
    echo "Sugar Candy and Chili themes are installed!"
    echo "Choose one by editing /etc/sddm.conf!"
    ;;
  *)
    echo "You chose none of the listed SDDM Themes. The default theme will be used!"
    ;;
esac

