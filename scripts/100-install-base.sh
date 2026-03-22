#!/bin/bash
echo "### Installing base packages ###"
sudo pacman -S --noconfirm --needed base-devel linux-headers networkmanager grub efibootmgr os-prober update-grub pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pavucontrol-qt vlc zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting git wget curl rsync btop htop fastfetch unzip p7zip flatpak timeshift inxi hwinfo nvtop vscodium gparted ntfs-3g dosfstools exfatprogs btrfs-progs kvantum chromium
echo "### Done! ###"
