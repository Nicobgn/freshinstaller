#!/bin/sh
FRESHLOGS=$1
EXTRADIR="$HOME/.local/extra"
zshell=$2
lunarv=$3
rustdev=$4
nodedev=$5
winman=$6

EXISTS_EXTRA() {
  if [[ ! -d "$EXTRADIR" ]]; then
    mkdir -p $EXTRADIR
  fi
}

echo "This script is meant to be runned once booted on Arch, and not in root."
echo "Use it cautiously."
echo "If you are not under those conditions, you will have 5 seconds to cancel."
sleep 5

echo "You choosed to stay running."
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

echo "Installing Yet Another Yogurt (yay)" >> $FRESHLOGS
{
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si
  cd /
} >> $FRESHLOGS 2>&1
./notifier.sh "Yet Another Yogurt was installed."
./notifier.sh "Ensure it was succeeded on $FRESHLOGS!"

if [ -z "$2" ]; then
  read -p "Do you want to install z shell? (yes/no): " input_value
  zshell="$input_value"
fi

if [ -z "$3" ]; then
  read -p "Do you want to install LunarVim? (yes/no): " input_value
  lunarv="$input_value"
fi

if [[ "$zshell" == "yes" ]] || [[ "$zshell" == "y" ]]; then
  EXISTS_EXTRA
  ./dev/fresh_zsh.sh $FRESHLOGS $EXTRADIR
fi

if [[ "$lunarv" == "yes" ]] || [[ "$lunarv" == "y" ]]; then
  EXISTS_EXTRA
  ./dev/lunarvim.sh "$FRESHLOGS"

else 
  if [ -z "$4" ]; then
    read -p "Will you use rust? (yes/no): " input_value
    rustdev="$input_value"
  fi

  if [[ "$rustdev" == "yes" ]] || [[ "$rustdev" == "y" ]]; then
    ./dev/fresh_rustdev.sh $FRESHLOGS
  fi

  if [ -z "$5" ]; then
    read -p "Will you use node? (yes/no): " input_value
    nodedev="$input_value"
  fi

  if [[ "$nodedev" == "yes" ]] || [[ "$nodedev" == "y" ]]; then
    EXISTS_EXTRA
    ./dev/fresh_node.sh $FRESHLOGS $EXTRADIR
  fi
fi

if [ -z "$6" ]; then
  read -p "Do you want to install Qtile as Window Manager? (yes/no): " input_value
  winman="$input_value"
fi

if [[ "$winman" == "yes" ]] || [[ "$winman" == "y" ]]; then
  ./winman/fresh_window_manager.sh
fi

