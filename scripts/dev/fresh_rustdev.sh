#!/bin/sh
FRESHLOGS=$1
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

echo "Installing Rust Stable version!" >> $FRESHLOGS
{
  sudo pacman -S --needed --noconfirm rustup

  rustup install stable
} >> $FRESHLOGS 2>&1
../notifier.sh "Rust was installed."
../notifier.sh "Ensure it succeeded on $FRESHLOGS!"

