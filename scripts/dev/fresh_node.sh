#!/bin/sh
FRESHLOGS=$1
EXTRADIR=$2
if [ -z "$1" ]; then
  FRESHLOGS="/var/log/freshinstaller"
fi

{
  export NVM_DIR="$EXTRADIR/nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"

  nvm install --lts

} >> $FRESHLOGS 2>&1

../notifier.sh "Node Version Manager and Node LTS Installed!"
../notifier.sh "Don't forget to add NVM to path"
../notifier.sh "Ensure it succeeded on $FRESHLOGS!"

