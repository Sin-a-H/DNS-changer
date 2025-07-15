#!/bin/bash

# DNS Manager Uninstaller

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges. Please run with sudo."
    exit 1
fi

INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/usr/local/etc"
ZSH_COMPLETION_DIR="/usr/local/etc/bash_completion.d"
ZSHRC="$HOME/.zshrc"

echo "Uninstalling DNS Manager..."

# Remove installed files
rm -f "$INSTALL_DIR/setdns"
rm -f "$CONFIG_DIR/dns_settings.txt"
rm -f "$ZSH_COMPLETION_DIR/setdns"

# Remove any setdns-related lines from .zshrc
if [ -f "$ZSHRC" ]; then
    sed -i.bak '/setdns/d' "$ZSHRC"
    echo "Removed related lines from $ZSHRC (backup created as $ZSHRC.bak)"
fi


echo "Uninstall complete."

