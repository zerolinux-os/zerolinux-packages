#!/bin/bash
# ZeroLinux - Colors & Messages

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${CYAN}${BOLD}[ZeroLinux]${NC} $1"; }
success() { echo -e "${GREEN}${BOLD}[✓]${NC} $1"; }
warning() { echo -e "${YELLOW}${BOLD}[!]${NC} $1"; }
error()   { echo -e "${RED}${BOLD}[✗]${NC} $1"; exit 1; }
step()    { echo -e "\n${BLUE}${BOLD}━━━ $1 ━━━${NC}\n"; }
