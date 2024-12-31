#!/bin/sh
# NOTE: This script was created by Nicobgn just to save his own configs
# use it at your own risk.

# NOTE: In case that you dont have $HOME defined, it will ensure it.
if [ -z "$HOME" ]; then
  echo "HOME is not defined. Given its default value."
  HOME="/home/$(whoami)" 
fi

sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

# NOTE: DEFINITIONS and folders
CONFIGDIR="$HOME/.config"
DOTFILES="$HOME/.local/dotfiles"
EXTRADIR="$HOME/.local/extra"
LOCALBIN="$HOME/.local/bin"

mkdir -p $HOME/Projects $HOME/Pictures $HOME/Pictures/Screenshots \
  $HOME/Pictures/Wallpapers $HOME/Downloads $HOME/.local \ 
  $HOME/.local/appimages $EXTRADIR $LOCALBIN

sudo pacman -Syu --needed
sudo pacman -S --needed linux linux-lts linux-headers linux-firmware \
  base base-devel git

# NOTE: Install Yet Another Yogurt
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay && makepkg -si

# NOTE: Install every pacman programs and dependencies
sudo pacman -S --needed \
  networkmanager bluez alsa-utils pulseaudio reflector pavucontrol \
  unclutter picom dunst feh vivaldi os-prober efibootmgr grub sddm \
  xorg dmenu rofi qtile polybar vivaldi neovim vim wmctrl wezterm \
  ttf-firacode-nerd noto-fonts-cjk playerctl rustup \
  python-pynvim python-distutils-extra spotify-launcher \
  at-spi2-core libxdamage xorg-server

yay -S --needed --answerclean a --answerdiff n \
  zscroll

# INFO: This part installs OH-MY-ZSH and its plugins.

if [ -z "$EXTRADIR/oh-my-zsh" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git $EXTRADIR/oh-my-zsh
fi

if [ -z "$EXTRADIR/oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$EXTRADIR/oh-my-zsh/custom}/themes/powerlevel10k
fi

if [ -z "$EXTRADIR/oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then 
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-$EXTRADIR/oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi

chsh -s $(which zsh)

# INFO: This part will install Node Version Manager
export NVM_DIR="$EXTRADIR/nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

# INFO: Install rust stable version and Node LTS 
rustup install stable
nvm install --lts

LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
sudo ln -sr $LOCALBIN/lvim /usr/bin

# INFO: Enables SDDM service to ensure a good account management.
sudo systemctl enable sddm

# INFO: Install GRUB (You should make your config later if default is not enough)
sudo grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB

