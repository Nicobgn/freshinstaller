#!/bin/sh
FRESHLOGS=$1
theme=$2

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

if [ -z "/etc/sddm.conf" ]; then
  cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf
fi

if [[ ! -d "/usr/share/sddm/themes" ]]; then
  mkdir /usr/share/sddm /usr/share/sddm/themes
fi

if [ "$theme" == "1" ]; then
  echo "## You choosed Sugar Candy theme" >> $FRESHLOGS
  {
    git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git /usr/share/sddm/themes/sugar-candy
  } >> $FRESHLOGS 2>&1

  ../notifier.sh "Sugar Candy theme is installed!"
  ../notifier.sh "Enable it by editing /etc/sddm.conf!"

elif [ "$theme" == "2"]; then
  echo "You choosed Chili theme" >> $FRESHLOGS
  {
    git clone https://github.com/MarianArlt/sddm-chili.git /usr/share/sddm/themes/chili
  } >> $FRESHLOGS 2>&1

  ../notifier.sh "Chili theme is installed!"
  ../notifier.sh "Enable it by editing /etc/sddm.conf!"

elif [ "$theme" == "3" ]; then
  echo "You choosed both! (Sugar Candy an Chili themes)" >> $FRESHLOGS
  {
    git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git /usr/share/sddm/themes/sugar-candy
    git clone https://github.com/MarianArlt/sddm-chili.git /usr/share/sddm/themes/chili
  } >> $FRESHLOGS 2>&1
  
  ../notifier.sh "Sugar Candy and Chili themes are installed!"
  ../notifier.sh "Choose one by editing /etc/sddm.conf!"

else
  ../notifier.sh "You choosed none of the listed SDDM Themes, you will use the default one!"
fi

