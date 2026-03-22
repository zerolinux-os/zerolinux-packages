#!/bin/bash
# ZeroLinux - Package Installation

PACKAGES_URL="https://raw.githubusercontent.com/zerolinux-os/zerolinux-packages/main/packages.list"

install_packages() {
    step "Installing ZeroLinux packages"

    info "Fetching packages list..."
    local tmpfile=$(mktemp)
    curl -sL "$PACKAGES_URL" -o "$tmpfile"
    if [[ ! -s "$tmpfile" ]]; then
        error "Failed to fetch packages list!"
    fi

    local packages=$(grep -v "^#" "$tmpfile" | grep -v "^$" | sed "s/[[:space:]]//g" | tr "\n" " ")
    rm -f "$tmpfile"

    info "Installing packages with pacman..."
    pacman -S --noconfirm --needed $packages 2>/dev/null || true

    info "Installing AUR packages with paru..."
    sudo -u "$REAL_USER" paru -S --noconfirm --needed $packages 2>/dev/null || true

    success "Packages installed successfully"
}

install_zerolinux_packages() {
    step "Installing ZeroLinux custom packages"

    local tmpdir=$(mktemp -d)
    chown "$REAL_USER":"$REAL_USER" "$tmpdir"

    info "Cloning zerolinux-packages..."
    sudo -u "$REAL_USER" git clone --depth=1 \
        "https://github.com/zerolinux-os/zerolinux-packages.git" \
        "$tmpdir/repo" || error "Failed to clone zerolinux-packages!"

    local pkgs=(
        "zerolinux-theme-grub"
        "zerolinux-theme-sddm"
        "zerolinux-icons"
        "zerolinux-wallpapers"
        "zerolinux-pm"
        "zerolinux-cleaner"
    )

    for pkg in "${pkgs[@]}"; do
        info "Installing $pkg..."
        cd "$tmpdir/repo/$pkg"
        sudo -u "$REAL_USER" makepkg -si --noconfirm && \
            success "$pkg installed" || warning "$pkg failed"
        cd /tmp
    done

    rm -rf "$tmpdir"
}
