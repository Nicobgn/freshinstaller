#!/bin/sh
FRESHLOGS=$1
EXTRADIR=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

echo "Installing LunarVim!"
echo "Installing LunarVim!" >> $FRESHLOGS

sudo pacman -S --needed --noconfirm \
  python-pynvim >> $FRESHLOGS 2>&1

./fresh_rustdev.sh $FRESHLOGS
./fresh_node.sh $FRESHLOGS $EXTRADIR

LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) >> $FRESHLOGS 2>&1
sudo ln -sr $LOCALBIN/lvim /usr/bin

echo "LunarVim installed!"
echo "Please check the logs to verify if it succeeded on $FRESHLOGS!"

