#!/bin/bash
# ZeroLinux - Run all scripts in order

echo "
 ███████╗███████╗██████╗  ██████╗ 
 ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
   ███╔╝ █████╗  ██████╔╝██║   ██║
  ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
 ███████╗███████╗██║  ██║╚██████╔╝
 ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ 
   ZeroLinux Installer v2.0
"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash $DIR/100-install-base.sh
bash $DIR/200-install-kde.sh
bash $DIR/300-install-aur.sh
bash $DIR/400-apply-themes.sh
bash $DIR/500-apply-kde-config.sh
bash $DIR/600-services.sh

echo ""
echo "### ZeroLinux installation complete! ###"
echo "### Please reboot your system! ###"
echo ""
read -p "Reboot now? [y/N]: " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    reboot
fi
