#!/bin/bash

# Define the directory where this script resides.
# When executed from ~/dotfiles/xfce-dotfiles/, this will correctly set DOTFILES_DIR to that path.
DOTFILES_DIR="$(dirname "$(readlink -f "$0")")"
CONFIG_DIR="$HOME/.config"

echo "Starting XFCE dotfiles setup process from $DOTFILES_DIR ..."

# --- Bash/Shell configs ---
echo "Linking Bash/Shell configs..."
ln -sf "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/bash/bash_logout" "$HOME/.bash_logout"

# --- XFCE Core configs (desktop, panel, terminal, xfconf) ---
# These are located under 'xfce4/' within your xfce-dotfiles folder
echo "Linking XFCE core configurations (desktop, panel, terminal, xfconf)..."
mkdir -p "$CONFIG_DIR/xfce4" # Ensure the core ~/.config/xfce4 directory exists

# Link individual XFCE configuration folders
ln -sf "$DOTFILES_DIR/xfce4/desktop" "$CONFIG_DIR/xfce4/desktop"
ln -sf "$DOTFILES_DIR/xfce4/panel" "$CONFIG_DIR/xfce4/panel"
ln -sf "$DOTFILES_DIR/xfce4/terminal" "$CONFIG_DIR/xfce4/terminal"

# Corrected handling for xfconf nesting:
# Source is ~/dotfiles/xfce-dotfiles/xfce4/xfconf/xfce-perchannel-xml
# Target is ~/.config/xfce4/xfconf/xfce-perchannel-xml
mkdir -p "$CONFIG_DIR/xfce4/xfconf" # Ensure ~/.config/xfce4/xfconf/ exists

# Remove existing xfce-perchannel-xml directory if it's not a symlink, to allow clean linking
if [ -d "$CONFIG_DIR/xfce4/xfconf/xfce-perchannel-xml" ] && ! [ -L "$CONFIG_DIR/xfce4/xfconf/xfce-perchannel-xml" ]; then
    echo "  Removing existing $CONFIG_DIR/xfce4/xfconf/xfce-perchannel-xml directory..."
    rm -rf "$CONFIG_DIR/xfce4/xfconf/xfce-perchannel-xml"
fi
ln -sf "$DOTFILES_DIR/xfce4/xfconf/xfce-perchannel-xml" "$CONFIG_DIR/xfce4/xfconf/xfce-perchannel-xml"

# --- Miscellaneous .config files (Redshift) ---
echo "Linking miscellaneous configs (Redshift)..."
ln -sf "$DOTFILES_DIR/misc_config/Redshift/redshift.conf" "$CONFIG_DIR/redshift.conf"

# --- Autostart configs ---
echo "Linking Autostart configs..."
mkdir -p "$CONFIG_DIR/autostart" # Ensure ~/.config/autostart exists
ln -sf "$DOTFILES_DIR/autostart/redshift.desktop" "$CONFIG_DIR/autostart/redshift.desktop"

# --- Themes and Icons ---
echo "Linking Themes and Icons..."
ln -sf "$DOTFILES_DIR/themes" "$HOME/.themes"
ln -sf "$DOTFILES_DIR/icons" "$HOME/.icons"

echo "XFCE dotfiles setup complete!"
echo "-------------------------------------------------------------------------"
echo "IMPORTANT: After running this script, you will need to:"
echo "1. Log out and log back into your XFCE session for changes to take full effect."
echo "2. For shell changes, open a new terminal session."
echo "-------------------------------------------------------------------------"
