#!/bin/bash
# ZeroLinux - Package Installation

PACKAGES_URL="https://raw.githubusercontent.com/zerolinux-os/zerolinux-packages/main/packages.list"

install_packages() {
    step "Installing ZeroLinux packages"

    # جلب قائمة الحزم
    info "Fetching packages list..."
    local tmpfile=$(mktemp)
    curl -sL "$PACKAGES_URL" -o "$tmpfile" || error "Failed to fetch packages list!"

    # تصفية التعليقات والأسطر الفارغة
    local packages=$(grep -v '^#' "$tmpfile" | grep -v '^$' | tr '\n' ' ')
    rm -f "$tmpfile"

    # تثبيت الحزم
    info "Installing packages (this may take a while)..."
    if ! pacman -S --noconfirm --needed $packages 2>/dev/null; then
        warning "Some packages failed, trying with paru..."
        paru -S --noconfirm --needed $packages
    fi
    success "Packages installed successfully"
}

install_zerolinux_packages() {
    step "Installing ZeroLinux custom packages"

    local pkgs=(
        "zerolinux-cleaner"
        "zerolinux-pm"
        "zerolinux-theme-grub"
        "zerolinux-theme-sddm"
        "zerolinux-icons"
        "zerolinux-wallpapers"
    )

    for pkg in "${pkgs[@]}"; do
        info "Installing $pkg..."
        local tmpdir=$(mktemp -d)
        git clone --depth=1 "https://github.com/zerolinux-os/zerolinux-packages.git" \
            "$tmpdir/repo" &>/dev/null
        cd "$tmpdir/repo/$pkg"
        sudo -u "$REAL_USER" makepkg -si --noconfirm &>/dev/null && \
            success "$pkg installed" || warning "$pkg failed"
        cd ~
        rm -rf "$tmpdir"
    done
}
