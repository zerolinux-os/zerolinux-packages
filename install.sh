#!/bin/bash
# ================================================
#   ZeroLinux - Installation Script
#   https://github.com/zerolinux-os
#   Version: 1.0.0
# ================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# تحميل المكتبات
source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/checks.sh"
source "$SCRIPT_DIR/lib/repos.sh"
source "$SCRIPT_DIR/lib/packages.sh"
source "$SCRIPT_DIR/lib/theming.sh"
source "$SCRIPT_DIR/lib/services.sh"

# Log file
LOG_FILE="/var/log/zerolinux-install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# ================================================
# Banner
# ================================================
clear
echo -e "
${CYAN}${BOLD}
  ███████╗███████╗██████╗  ██████╗ 
  ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
    ███╔╝ █████╗  ██████╔╝██║   ██║
   ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
  ███████╗███████╗██║  ██║╚██████╔╝
  ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ 
${NC}
${BOLD}         ZeroLinux Installer v1.0.0${NC}
${BLUE}    https://github.com/zerolinux-os${NC}
"

# ================================================
# التحقق من البيئة
# ================================================
step "Checking environment"
check_root
check_arch
check_internet
check_user

# ================================================
# تأكيد المستخدم
# ================================================
echo -e "\n${YELLOW}${BOLD}⚠️  This will transform your Arch Linux into ZeroLinux!${NC}"
echo -e "${YELLOW}   User: ${REAL_USER}${NC}"
echo -e "${YELLOW}   Log:  ${LOG_FILE}${NC}\n"
read -p "$(echo -e ${BOLD}Press ENTER to continue or Ctrl+C to cancel...${NC})"

# ================================================
# التثبيت
# ================================================
setup_repos
install_packages
install_zerolinux_packages
apply_theming
setup_services

# ================================================
# إعداد بيئة المستخدم
# ================================================
step "Setting up user environment"
info "Running user setup as $REAL_USER..."
sudo -u "$REAL_USER" bash "$SCRIPT_DIR/user-setup.sh"

# ================================================
# النهاية
# ================================================
echo -e "\n${GREEN}${BOLD}"
echo "  ╔════════════════════════════════════╗"
echo "  ║   ZeroLinux installed successfully ║"
echo "  ║   Please reboot your system!       ║"
echo "  ╚════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${CYAN}Log saved to: ${LOG_FILE}${NC}\n"

read -p "$(echo -e ${BOLD}Reboot now? [y/N]: ${NC})" reboot_now
if [[ "$reboot_now" =~ ^[Yy]$ ]]; then
    reboot
fi
