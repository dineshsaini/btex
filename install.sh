#!/usr/bin/env bash

if [ -n "$SUDO_USER" ]; then
   cat <<-EOF 1>&2
   Do not run this script with sudo.
   If install location requires permisssion it will ask.
EOF
exit 1
fi

INSTALL_LOC="$1"

if [ -z "$INSTALL_LOC" ]; then
   INSTALL_LOC=~/.local/share
fi

INSTALL_LOC="$INSTALL_LOC/btex"
INSTALL_USER=
LINK_DEST=

if [[ "$INSTALL_LOC/" =~  ^(~|$HOME)/ ]]; then
   INSTALL_USER="`whoami 2> /dev/null || echo $USER`"
   LINK_DEST=~/.local/bin
else
   INSTALL_USER="root"
   LINK_DEST=/usr/local/bin
fi

if ! [ -d "$INSTALL_LOC" ]; then
   sudo -u $INSTALL_USER -- mkdir -p "$INSTALL_LOC/"
fi

if ! [ -d "$LINK_DEST" ]; then
   sudo -u $INSTALL_USER -- mkdir -p $LINK_DEST/
fi

sudo -u $INSTALL_USER -- cp -r --update=all ./{btex,lib,uninstall.sh} "$INSTALL_LOC/"

sudo -u $INSTALL_USER -- ln -sf  "$INSTALL_LOC/btex" $LINK_DEST/btex

echo "Installed at '$LINK_DEST', make sure this dir exists in \$PATH variable."

