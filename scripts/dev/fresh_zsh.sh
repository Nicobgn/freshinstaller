#!/bin/sh
FRESHLOGS=$1
EXTRADIR=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi
if [ -z "$2" ]; then
  EXTRADIR="$HOME/.local/extra"
fi
if [ -d "$HOME/.local/extra" ]; then
  mkdir -p $HOME/.local/extra
fi

echo "Installing Z Shell, Oh-My-Zsh and some extra content!" >> $FRESHLOGS

sudo pacman -S --needed --noconfirm zsh>> $FRESHLOGS 2>&1

if [[ ! -d "$EXTRADIR/oh-my-zsh" ]]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git $EXTRADIR/oh-my-zsh >> $FRESHLOGS 2>&1
fi

if [[ ! -d "$EXTRADIR/oh-my-zsh/custom/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$EXTRADIR/oh-my-zsh/custom}/themes/powerlevel10k >> $FRESHLOGS 2>&1
fi

if [[ ! -d "$EXTRADIR/oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]]; then 
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-$EXTRADIR/oh-my-zsh/custom}/plugins/fast-syntax-highlighting >> $FRESHLOGS 2>&1
fi

chsh -s $(which zsh) >> $FRESHLOGS 2>&1

echo "Zsh and Oh-My-Zsh were installed!"
echo "We also added a theme (powerlevel10k) and a plugin (fast-syntax-highlighting)!"
echo "Ensure it succeeded on $FRESHLOGS!"

