#!/bin/bash
# ZeroLinux - System Services & Configuration

setup_services() {
    step "Configuring system services"

    # تفعيل SDDM
    info "Enabling SDDM..."
    systemctl enable sddm &>/dev/null
    success "SDDM enabled"

    # تفعيل NetworkManager
    info "Enabling NetworkManager..."
    systemctl enable NetworkManager &>/dev/null
    success "NetworkManager enabled"

    # تفعيل Bluetooth
    info "Enabling Bluetooth..."
    systemctl enable bluetooth &>/dev/null
    success "Bluetooth enabled"

    # تفعيل Timeshift
    info "Enabling Timeshift..."
    systemctl enable cronie &>/dev/null
    success "Timeshift enabled"

    # ضبط ZSH كـ shell افتراضي
    info "Setting ZSH as default shell..."
    chsh -s /bin/zsh "$REAL_USER" &>/dev/null
    success "ZSH set as default shell"

    # تفعيل Flatpak
    info "Adding Flathub repository..."
    flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo &>/dev/null
    success "Flathub added"

    # ضبط حقوق المستخدم
    info "Configuring user permissions..."
    usermod -aG wheel,audio,video,storage,optical "$REAL_USER" &>/dev/null
    success "User permissions configured"
}
