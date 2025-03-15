#!/bin/sh
FRESHLOGS=$1
EXTRADIR=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi
if [ -z "$2" ]; then
  EXTRADIR="$HOME/.local/extra"
fi
if [ ! -d "$HOME/.local/extra"]; then
  mkdir -p $HOME/.local/extra
fi


export NVM_DIR="$EXTRADIR/nvm" && (
  if [ -d "$NVM_DIR" ]; then
    echo "NVM is already installed"
  else
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  fi
) >> $FRESHLOGS 2>&1 && \. "$NVM_DIR/nvm.sh" >> $FRESHLOGS 2>&1

if [ -n "node --version" ]; then
  nvm install --lts >> $FRESHLOGS 2>&1
else 
  echo "There is a version of node installed, if you want to install lts please do it manually by running nvm install --lts"
fi

echo "Node Version Manager and Node LTS Installed!"
echo "Don't forget to add NVM to path"
echo "Ensure it succeeded on $FRESHLOGS!"

