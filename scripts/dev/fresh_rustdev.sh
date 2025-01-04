#!/bin/sh
FRESHLOGS=$1
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

echo "Installing Rust Stable version!"
echo "Installing Rust Stable version!" >> $FRESHLOGS
sudo pacman -S --needed --noconfirm rustup >> $FRESHLOGS 2>&1

rustup install stable >> $FRESHLOGS 2>&1
echo "Rust was installed."
echo "Ensure it succeeded on $FRESHLOGS!"

