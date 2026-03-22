#!/bin/bash
echo "### Installing KDE Plasma ###"
sudo pacman -S --noconfirm --needed plasma-desktop sddm plasma-nm plasma-pa plasma-systemmonitor kscreen bluedevil powerdevil kde-gtk-config breeze-gtk kwin kdeplasma-addons flatpak-kcm xdg-desktop-portal-kde polkit-kde-agent kwallet-pam kwalletmanager dolphin dolphin-plugins konsole kate ark spectacle gwenview okular kcalc filelight partitionmanager kdeconnect ttf-jetbrains-mono-nerd ttf-hack-nerd ttf-meslo-nerd ttf-fira-code ttf-ubuntu-font-family ttf-dejavu
echo "### Done! ###"
