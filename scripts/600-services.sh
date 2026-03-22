#!/bin/bash
echo "### Configuring services ###"

REAL_USER=$(logname)

# Enable services
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cronie

# ZSH as default shell
chsh -s /bin/zsh $REAL_USER

# Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# User groups
usermod -aG wheel,audio,video,storage,optical $REAL_USER

echo "### Done! ###"
