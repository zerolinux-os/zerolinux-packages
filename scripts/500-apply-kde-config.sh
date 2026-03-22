#!/bin/bash
echo "### Applying KDE configuration ###"

REAL_USER=$(logname)
REAL_HOME="/home/$REAL_USER"

git clone --depth=1 https://github.com/zerolinux-os/zerolinux-config.git /tmp/zl-config

# KDE config
mkdir -p $REAL_HOME/.config
cp /tmp/zl-config/kde-config/kdeglobals $REAL_HOME/.config/
cp /tmp/zl-config/kde-config/kwinrc $REAL_HOME/.config/
cp /tmp/zl-config/kde-config/plasmarc $REAL_HOME/.config/
cp /tmp/zl-config/kde-config/plasma-org.kde.plasma.desktop-appletsrc $REAL_HOME/.config/
cp /tmp/zl-config/kde-config/kscreenlockerrc $REAL_HOME/.config/
cp /tmp/zl-config/kde-config/konsolerc $REAL_HOME/.config/

# Kvantum
mkdir -p $REAL_HOME/.config/Kvantum
cp -r /tmp/zl-config/kde-config/Kvantum/. $REAL_HOME/.config/Kvantum/

# GTK
mkdir -p $REAL_HOME/.config/gtk-3.0
mkdir -p $REAL_HOME/.config/gtk-4.0
cp -r /tmp/zl-config/kde-config/gtk-3.0/. $REAL_HOME/.config/gtk-3.0/
cp -r /tmp/zl-config/kde-config/gtk-4.0/. $REAL_HOME/.config/gtk-4.0/

# Konsole
mkdir -p $REAL_HOME/.local/share/konsole
cp -r /tmp/zl-config/kde-config/konsole/. $REAL_HOME/.local/share/konsole/

# ZSH
cp /tmp/zl-config/kde-config/.zshrc $REAL_HOME/

# Fix ownership
chown -R $REAL_USER:$REAL_USER $REAL_HOME/.config
chown -R $REAL_USER:$REAL_USER $REAL_HOME/.local
chown $REAL_USER:$REAL_USER $REAL_HOME/.zshrc

rm -rf /tmp/zl-config

echo "### Done! ###"
