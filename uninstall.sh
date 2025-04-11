#!/usr/bin/env bash

if [ -n "$SUDO_USER" ]; then
   cat <<-EOF 1>&2
   Do not run this script with sudo.
   If uninstall script requires permisssion it will ask.
EOF
exit 1
fi

__FILE__=`realpath "${BASH_SOURCE[0]}"`

INSTALL_LOC="`dirname "$__FILE__"`"
INSTALL_USER=
LINK_DEST=


if [[ "$INSTALL_LOC/" =~  ^(~|$HOME)/ ]]; then
   INSTALL_USER="`whoami 2> /dev/null || echo $USER`"
   LINK_DEST=~/.local/bin
else
   INSTALL_USER="root"
   LINK_DEST=/usr/local/bin
fi

sudo -u $INSTALL_USER -- rm -f $LINK_DEST/btex

sudo -u $INSTALL_USER -- rm -rf "$INSTALL_LOC/"

echo "Successfully uninstalled."
