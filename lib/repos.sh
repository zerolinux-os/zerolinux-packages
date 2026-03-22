#!/bin/bash
# ZeroLinux - Repository Setup

setup_repos() {
    step "Setting up repositories"

    # إضافة chaotic-aur
    if ! grep -q "chaotic-aur" /etc/pacman.conf; then
        info "Adding Chaotic-AUR..."
        pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com &>/dev/null
        pacman-key --lsign-key 3056513887B78AEB &>/dev/null
        pacman -U --noconfirm \
            'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
            'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' &>/dev/null
        echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
        success "Chaotic-AUR added"
    else
        warning "Chaotic-AUR already configured"
    fi

    # تحديث المستودعات
    info "Updating package database..."
    pacman -Sy --noconfirm &>/dev/null
    success "Repositories updated"

    # تثبيت paru
    if ! command -v paru &>/dev/null; then
        info "Installing paru..."
        pacman -S --noconfirm paru &>/dev/null
        success "paru installed"
    else
        warning "paru already installed"
    fi
}
