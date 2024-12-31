#!/bin/sh
FRESHLOGS=$1
EXTRADIR=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

echo "Installing Z Shell, Oh-My-Zsh and some extra content!" >> $FRESHLOGS
{
  sudo pacman -S --needed --noconfirm zsh

  if [[ ! -d "$EXTRADIR/oh-my-zsh" ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $EXTRADIR/oh-my-zsh
  fi

  if [[ ! -d "$EXTRADIR/oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      ${ZSH_CUSTOM:-$EXTRADIR/oh-my-zsh/custom}/themes/powerlevel10k
  fi

  if [[ ! -d "$EXTRADIR/oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]]; then 
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
      ${ZSH_CUSTOM:-$EXTRADIR/oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  fi

  chsh -s $(which zsh)
} >> $FRESHLOGS 2>&1

../notifier.sh "Zsh and Oh-My-Zsh were installed!"
../notifier.sh "We also added a theme (powerlevel10k) and a plugin (fast-syntax-highlighting)!"
../notifier.sh "Ensure it succeeded on $FRESHLOGS!"

