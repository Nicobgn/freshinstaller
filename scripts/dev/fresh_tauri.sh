#!/bin/sh
FRESHLOGS="$1"

if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshlogs"
fi

echo "Installing dependencies to develop with Tauri"
echo "Installing dependencies to develop with Tauri" >> $FRESHLOGS

sudo pacman -S --needed --noconfirm \
  base-devel webkit2gtk curl wget file \
  openssl appmenu-gtk-module gtk3 \
  libappindicator-gtk3 librsvg libvips \
  >> $FRESHLOGS 2>&1

if ! node --version &> /dev/null; then
  ./fresh_node.sh
fi

if ! rustc --version &> /dev/null; then
  ./fresh_rust.sh
fi

