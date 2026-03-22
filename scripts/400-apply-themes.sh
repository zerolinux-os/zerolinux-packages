#!/bin/bash
echo "### Applying ZeroLinux themes ###"

# Clone repos
git clone --depth=1 https://github.com/zerolinux-os/zerolinux-themes.git /var/tmp/zl-themes
git clone --depth=1 https://github.com/zerolinux-os/zerolinux-config.git /var/tmp/zl-config
git clone --depth=1 https://github.com/zerolinux-os/zerolinux-branding.git /var/tmp/zl-branding

# Layan theme
mkdir -p /usr/share/plasma/desktoptheme
mkdir -p /usr/share/aurorae/themes
mkdir -p /usr/share/Kvantum
cp -r /var/tmp/zl-themes/themes/Layan /usr/share/plasma/desktoptheme/
cp -r /var/tmp/zl-themes/themes/Layan-Aurorae /usr/share/aurorae/themes/Layan
cp -r /var/tmp/zl-themes/themes/Layan-Kvantum /usr/share/Kvantum/Layan

# Icons
cp -r /var/tmp/zl-themes/icons/ZeroLinux-icons /usr/share/icons/
cp -r /var/tmp/zl-themes/icons/ZeroLinux-icons-symbolic /usr/share/icons/

# Cursor
cp -r /var/tmp/zl-themes/cursors/Bibata-Modern-Classic /usr/share/icons/

# SDDM
cp -r /var/tmp/zl-config/sddm/themes/ZeroLinux-sddm /usr/share/sddm/themes/
mkdir -p /etc/sddm.conf.d
cp /var/tmp/zl-config/sddm/config/kde_settings.conf /etc/sddm.conf.d/

# GRUB
mkdir -p /boot/grub/themes
cp -r /var/tmp/zl-config/grub/themes/ZeroLinux-grub /boot/grub/themes/ZeroLinux
sed -i 's|.*GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/ZeroLinux/theme.txt"|' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Wallpapers
mkdir -p /usr/share/wallpapers/ZeroLinux
cp /var/tmp/zl-themes/wallpapers/ZeroLinux/*.jpg /usr/share/wallpapers/ZeroLinux/ 2>/dev/null
cp /var/tmp/zl-themes/wallpapers/ZeroLinux/*.png /usr/share/wallpapers/ZeroLinux/ 2>/dev/null

# Fonts
cp -r /var/tmp/zl-branding/fonts/TTF /usr/share/fonts/ZeroLinux
fc-cache -f

# Branding
cp /var/tmp/zl-branding/branding/zerolinux.png /usr/share/pixmaps/
cp /var/tmp/zl-branding/branding/zerolinux-cleaner.png /usr/share/pixmaps/

# Cleanup
rm -rf /var/tmp/zl-themes /var/tmp/zl-config /var/tmp/zl-branding

echo "### Done! ###"
