#!/bin/bash
# ZeroLinux - Theming & Identity

THEMES_REPO="https://github.com/zerolinux-os/zerolinux-themes.git"
CONFIG_REPO="https://github.com/zerolinux-os/zerolinux-config.git"
BRANDING_REPO="https://github.com/zerolinux-os/zerolinux-branding.git"

apply_theming() {
    step "Applying ZeroLinux identity"

    local tmpdir=$(mktemp -d)

    # جلب المستودعات
    info "Fetching themes..."
    git clone --depth=1 "$THEMES_REPO" "$tmpdir/themes" &>/dev/null
    git clone --depth=1 "$CONFIG_REPO" "$tmpdir/config" &>/dev/null
    git clone --depth=1 "$BRANDING_REPO" "$tmpdir/branding" &>/dev/null

    # --- Layan Theme ---
    info "Installing Layan theme..."
    cp -r "$tmpdir/themes/themes/Layan" /usr/share/plasma/desktoptheme/
    cp -r "$tmpdir/themes/themes/Layan-Kvantum" /usr/share/Kvantum/Layan
    cp -r "$tmpdir/themes/themes/Layan-Aurorae" /usr/share/aurorae/themes/Layan
    success "Layan theme installed"

    # --- Icons ---
    info "Installing icons..."
    cp -r "$tmpdir/themes/icons/ZeroLinux-icons" /usr/share/icons/
    cp -r "$tmpdir/themes/icons/ZeroLinux-icons-symbolic" /usr/share/icons/
    success "Icons installed"

    # --- Cursor ---
    info "Installing cursor..."
    cp -r "$tmpdir/themes/cursors/Bibata-Modern-Classic" /usr/share/icons/
    success "Cursor installed"

    # --- GRUB ---
    info "Applying GRUB theme..."
    cp -r "$tmpdir/config/grub/themes/ZeroLinux-grub" /boot/grub/themes/ZeroLinux
    sed -i 's|^#\?GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/ZeroLinux/theme.txt"|' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg &>/dev/null
    success "GRUB theme applied"

    # --- SDDM ---
    info "Applying SDDM theme..."
    cp -r "$tmpdir/config/sddm/themes/ZeroLinux-sddm" /usr/share/sddm/themes/
    mkdir -p /etc/sddm.conf.d
    cp "$tmpdir/config/sddm/config/kde_settings.conf" /etc/sddm.conf.d/
    success "SDDM theme applied"

    # --- Wallpapers ---
    info "Installing wallpapers..."
    mkdir -p /usr/share/wallpapers/ZeroLinux
    cp "$tmpdir/themes/wallpapers/ZeroLinux/"* /usr/share/wallpapers/ZeroLinux/ 2>/dev/null
    success "Wallpapers installed"

    # --- Fonts ---
    info "Installing fonts..."
    cp -r "$tmpdir/branding/fonts/TTF" /usr/share/fonts/
    fc-cache -f &>/dev/null
    success "Fonts installed"

    # --- Branding ---
    info "Installing branding..."
    cp "$tmpdir/branding/branding/zerolinux.png" /usr/share/pixmaps/
    cp "$tmpdir/branding/branding/zerolinux-cleaner.png" /usr/share/pixmaps/
    success "Branding installed"

    rm -rf "$tmpdir"
    success "ZeroLinux identity applied successfully"
}
