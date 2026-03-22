#!/bin/bash
# ZeroLinux - User Configuration (run as normal user)

source "$(dirname "$0")/lib/colors.sh"

CONFIG_REPO="https://github.com/zerolinux-os/zerolinux-config.git"

setup_user() {
    step "Configuring user environment"

    local tmpdir=$(mktemp -d)
    git clone --depth=1 "$CONFIG_REPO" "$tmpdir/config" &>/dev/null

    # --- KDE Config ---
    info "Applying KDE configuration..."
    mkdir -p ~/.config
    cp "$tmpdir/config/kde-config/kdeglobals" ~/.config/
    cp "$tmpdir/config/kde-config/kwinrc" ~/.config/
    cp "$tmpdir/config/kde-config/plasmarc" ~/.config/
    cp "$tmpdir/config/kde-config/plasma-org.kde.plasma.desktop-appletsrc" ~/.config/
    cp "$tmpdir/config/kde-config/kscreenlockerrc" ~/.config/
    cp "$tmpdir/config/kde-config/konsolerc" ~/.config/
    success "KDE configuration applied"

    # --- Kvantum ---
    info "Applying Kvantum theme..."
    mkdir -p ~/.config/Kvantum
    cp -r "$tmpdir/config/kde-config/Kvantum/." ~/.config/Kvantum/
    success "Kvantum applied"

    # --- GTK ---
    info "Applying GTK theme..."
    mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
    cp -r "$tmpdir/config/kde-config/gtk-3.0/." ~/.config/gtk-3.0/
    cp -r "$tmpdir/config/kde-config/gtk-4.0/." ~/.config/gtk-4.0/
    success "GTK theme applied"

    # --- Konsole Profile ---
    info "Applying Konsole profile..."
    mkdir -p ~/.local/share/konsole
    cp -r "$tmpdir/config/kde-config/konsole/." ~/.local/share/konsole/
    success "Konsole profile applied"

    # --- ZSH ---
    info "Applying ZSH configuration..."
    cp "$tmpdir/config/kde-config/.zshrc" ~/
    success "ZSH configured"

    # --- Icons في home ---
    info "Applying user icons..."
    mkdir -p ~/.local/share/icons
    cp -r /usr/share/icons/ZeroLinux-icons ~/.local/share/icons/
    success "User icons applied"

    rm -rf "$tmpdir"
    success "User environment configured successfully!"
}

setup_user
