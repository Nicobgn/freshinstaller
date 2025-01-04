#!/bin/sh
FRESHLOGS="/var/log/freshinstaller"
grubi=$1
efi_directory=$2
bootloader_id=$3

if [[ ! -d "/var/log" ]]; then 
  mkdir -p "/var/log"
fi

echo "Installing everything that we would need" >> $FRESHLOGS

sudo pacman -S --needed --noconfirm \
  grub os-prober efibootmgr networkmanager \
  base-devel bluez git openssl curl wget \
  vim neovim tree ttf-firacode-nerd noto-fonts-cjk >> $FRESHLOGS 2>&1
echo "Everything was installed, and you can see it on $FRESHLOGS!"

echo "The next part is to install grub, we will install it on the EFI way, skip it if you need it."
echo "The script will wait 10 seconds before continue, in case of you need to cancel."
sleep 10

if [ -z $1]; then
  read -p "Do you want us to install grub? (yes/no)" input_value
  grubi="$input_value"
fi

if [[ "$grubi" = "y" ]] || [[ "$grubi" = "yes" ]]; then
  if [ -z "$2" ]; then
    read -p "Which is your EFI directory?: " input_value
    efi_directory="$input_value"
  fi

  if [ -z "$3" ]; then
    echo "The bootloader id is the name of the start point of GRUB"
    echo "This means it will be the name displayed on the BIOS Boot Menu"
    read -p "What name will you assign to it?: " input_value
    bootloader_id="$input_value"
  fi

  grub-install --target=x86_64-efi --efi-directory=$efi_directory --bootloader-id=$bootloader_id
fi

echo "The next part is not meant to be run as root"
echo "Also, it wont work properly if you haven't booted on Arch."
echo "We recommend you to skip it if you dont meet the conditions."
echo "We will let you 10 seconds to cancel it if you need."

sleep 10

if [[ $(whoami) != "root" ]]; then
  ./fresh_user_installer.sh $FRESHLOGS
fi

