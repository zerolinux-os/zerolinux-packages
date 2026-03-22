#!/bin/bash
# ZeroLinux - Environment Checks

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "يجب تشغيل السكربت بصلاحيات root: sudo bash install.sh"
    fi
    success "Root privileges confirmed"
}

check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        error "هذا السكربت مخصص لـ Arch Linux فقط!"
    fi
    success "Arch Linux detected"
}

check_internet() {
    if ! ping -c 1 archlinux.org &>/dev/null; then
        error "لا يوجد اتصال بالإنترنت!"
    fi
    success "Internet connection confirmed"
}

check_user() {
    if [[ -z "$SUDO_USER" ]]; then
        error "شغّل السكربت بـ sudo وليس root مباشرة: sudo bash install.sh"
    fi
    REAL_USER="$SUDO_USER"
    REAL_HOME="/home/$SUDO_USER"
    success "User detected: $REAL_USER"
}
