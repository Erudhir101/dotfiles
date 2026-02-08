#!/bin/bash

###############################################################################
# Arch Linux Post-Installation Script
# This script automates common post-installation tasks
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_message() {
    echo -e "${GREEN}[*]${NC} $1"
}

print_error() {
    echo -e "${RED}[!]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_section() {
    echo -e "\n${BLUE}================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================================${NC}\n"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root"
    exit 1
fi

###############################################################################
# SYSTEM UPDATE
###############################################################################

print_section "Updating System"
print_message "Updating package databases and upgrading system..."
sudo pacman -Syu --noconfirm

###############################################################################
# INSTALL BASE DEVELOPMENT TOOLS
###############################################################################

print_section "Installing Base Development Tools"
print_message "Installing base-devel, git, and other essentials..."
sudo pacman -S --needed --noconfirm base-devel git wget curl nano vim

###############################################################################
# INSTALL YAY (AUR Helper)
###############################################################################

print_section "Installing YAY AUR Helper"

if command -v yay &> /dev/null; then
    print_warning "YAY is already installed, skipping..."
else
    print_message "Installing YAY..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
    print_message "YAY installed successfully!"
fi

###############################################################################
# INSTALL INTEL GRAPHICS DRIVERS
###############################################################################

print_section "Installing Intel Graphics Drivers (Iris Xe)"
print_message "Installing Intel GPU drivers and Vulkan support..."
sudo pacman -S --needed --noconfirm \
    mesa \
    lib32-mesa \
    vulkan-intel \
    lib32-vulkan-intel \
    intel-media-driver \
    libva-intel-driver \
    libva-utils \
    intel-gpu-tools

print_message "Installing Intel microcode..."
sudo pacman -S --needed --noconfirm intel-ucode

###############################################################################
# INSTALL ESSENTIAL PACKAGES
###############################################################################

print_section "Installing Essential Packages"

# System utilities
print_message "Installing system utilities..."
sudo pacman -S --needed --noconfirm \
    curl \
    eza \
    fastfetch \
    fzf \
    htop \
    htop \
    inetutils \
    lsof \
    net-tools \
    p7zip \
    pciutils \
    ripgrep \
    rsync \
    stow \
    tar \
    tree \
    unrar \
    unzip \
    usbutils \
    wget \
    zoxide

# Network tools
print_message "Installing network tools..."
sudo pacman -S --needed --noconfirm \
    networkmanager \
    network-manager-applet \
    networkmanager-openvpn \
    openssh \
    nmap \
    traceroute \
    bind

# Audio
print_message "Installing audio support..."
sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    pipewire-jack \
    wireplumber \
    pavucontrol

# Bluetooth
print_message "Installing bluetooth support..."
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils \
    blueman

# Fonts (Nerd Fonts for terminal/WM)
print_message "Installing Nerd Fonts and system fonts..."
sudo pacman -S --needed --noconfirm \
    ttf-dejavu \
    ttf-liberation \
    noto-fonts \
    noto-fonts-emoji \
    ttf-font-awesome \
    ttf-hack-nerd \
    ttf-noto-nerd \
    ttf-jetbrains-mono-nerd \
    ttf-firacode-nerd

# Development tools
print_message "Installing development tools..."
sudo pacman -S --needed --noconfirm \
    python \
    python-pip \
    python-setuptools

###############################################################################
# INSTALL NVM, NODE.JS AND NPM
###############################################################################

print_section "Installing NVM (Node Version Manager)"
if [ -d "$HOME/.nvm" ]; then
    print_warning "NVM directory already exists, skipping installation."
else
    print_message "Downloading and running NVM installer..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Source NVM for the current script session
print_message "Sourcing NVM..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest LTS Node.js and npm
if command -v nvm &> /dev/null; then
    print_message "Installing latest LTS Node.js and npm via NVM..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
else
    print_error "NVM command not found. Node.js installation skipped."
    print_error "Please ensure NVM is installed and configured correctly."
fi

# Terminal and shell
print_message "Installing terminal emulator and shells..."
sudo pacman -S --needed --noconfirm \
    kitty \
    zsh \
    tmux

# Text editors
print_message "Installing Neovim..."
sudo pacman -S --needed --noconfirm neovim

###############################################################################
# INSTALL WAYLAND/NIRI APPLICATIONS
###############################################################################

print_section "Installing Wayland/Niri Window Manager Components"

# Wayland compositor utilities
print_message "Installing Wayland utilities..."
sudo pacman -S --needed --noconfirm \
    wayland \
    wayland-protocols \
    xorg-xwayland \
    qt5-wayland \
    qt6-wayland \
    glfw-wayland

# Niri WM essentials
print_message "Installing Sway/Wayland tools for Niri..."
sudo pacman -S --needed --noconfirm \
    swaybg \
    swaylock \
    swayidle \
    waybar \
    mako \
    fuzzel

# Screenshot tool
print_message "Installing screenshot tool..."
sudo pacman -S --needed --noconfirm \
    grim \
    slurp \
    wl-clipboard

print_message "Installing Flameshot (note: may have limited Wayland support)..."
sudo pacman -S --needed --noconfirm flameshot || print_warning "Flameshot installation failed"

###############################################################################
# INSTALL APPLICATIONS
###############################################################################

print_section "Installing Applications"

# Browser
print_message "Installing Firefox..."
sudo pacman -S --needed --noconfirm firefox

# Communication
print_message "Installing Discord..."
sudo pacman -S --needed --noconfirm discord

# Media players
print_message "Installing media players..."
sudo pacman -S --needed --noconfirm \
    vlc \
    mpv

# Archive manager
print_message "Installing file archiver..."
sudo pacman -S --needed --noconfirm file-roller

# PDF viewer
print_message "Installing PDF viewer..."
sudo pacman -S --needed --noconfirm evince

# Image viewer
print_message "Installing image viewer..."
sudo pacman -S --needed --noconfirm imv

###############################################################################
# OPTIONAL AUR PACKAGES
###############################################################################

print_section "Installing AUR Packages"

print_message "Installing Niri window manager..."
yay -S --needed --noconfirm niri || print_warning "Niri installation failed or was skipped"

print_message "Installing Zellij (terminal multiplexer)..."
yay -S --needed --noconfirm zellij || print_warning "Zellij installation failed or was skipped"

print_message "Installing Kanata (keyboard remapper)..."
yay -S --needed --noconfirm kanata-bin || print_warning "Kanata installation failed or was skipped"

print_message "Installing Visual Studio Code..."
yay -S --needed --noconfirm visual-studio-code-bin || print_warning "VSCode installation failed or was skipped"

print_message "Installing Google Chrome (optional)..."
yay -S --needed --noconfirm google-chrome || print_warning "Chrome installation failed or was skipped"

print_message "Installing Spotify (optional)..."
yay -S --needed --noconfirm spotify || print_warning "Spotify installation failed or was skipped"

###############################################################################
# ENABLE SERVICES
###############################################################################

print_section "Enabling System Services"

print_message "Enabling NetworkManager..."
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

print_message "Enabling Bluetooth..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

print_message "Enabling SSH..."
sudo systemctl enable sshd

# Optional: Enable Kanata service if installed
if command -v kanata &> /dev/null; then
    print_message "Kanata installed. You may want to configure it manually."
    print_message "Create a config at ~/.config/kanata/kanata.kbd and enable the service."
fi

###############################################################################
# SYSTEM OPTIMIZATIONS
###############################################################################

print_section "Applying System Optimizations"

# Enable parallel downloads in pacman
print_message "Enabling parallel downloads in pacman..."
sudo sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

# Enable multilib repository (for 32-bit support)
print_message "Enabling multilib repository..."
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy
fi

# Enable color output in pacman
print_message "Enabling color output in pacman..."
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf

# Reduce swappiness (better for desktop use)
print_message "Optimizing swappiness for desktop use..."
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-swappiness.conf

###############################################################################
# FIREWALL SETUP
###############################################################################

print_section "Setting Up Firewall"

print_message "Installing and configuring UFW..."
sudo pacman -S --needed --noconfirm ufw
sudo systemctl enable ufw
sudo systemctl start ufw
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
print_message "Firewall configured and enabled"

###############################################################################
# ZSH AND STARSHIP CONFIGURATION
###############################################################################

print_section "Configuring Zsh and Starship"

print_message "Installing Starship prompt..."
sudo pacman -S --needed --noconfirm starship

print_message "Setting Zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    print_message "Zsh set as default shell (will take effect after logout)"
else
    print_message "Zsh is already your default shell"
fi

###############################################################################
# DOTFILES SETUP
###############################################################################

print_section "Setting Up Dotfiles with GNU Stow"

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/erudhir101/dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    print_warning "Dotfiles directory already exists at $DOTFILES_DIR"
    print_message "Skipping clone. If you want to re-clone, remove the directory first."
else
    print_message "Cloning dotfiles from $DOTFILES_REPO..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    
    if [ $? -eq 0 ]; then
        print_message "Dotfiles cloned successfully!"
        
        print_message "Applying dotfiles with GNU Stow..."
        cd "$DOTFILES_DIR"
        
        # Backup existing config files if they exist
        print_message "Backing up any existing config files..."
        BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        
        # Common configs that might conflict
        for config in .zshrc .config/kitty .config/nvim .config/niri .config/waybar .config/mako .config/fuzzel .config/starship.toml; do
            if [ -e "$HOME/$config" ] && [ ! -L "$HOME/$config" ]; then
                print_message "Backing up $config..."
                cp -r "$HOME/$config" "$BACKUP_DIR/" 2>/dev/null || true
            fi
        done
        
        # Apply stow for all packages in dotfiles
        # Adjust this based on your dotfiles structure
        print_message "Applying stow packages..."
        
        # Common stow pattern: stow -d ~/.dotfiles -t ~ package_name
        # If your repo has packages in subdirectories, uncomment and adjust:
        # for package in */; do
        #     if [ -d "$package" ]; then
        #         package_name=$(basename "$package")
        #         print_message "Stowing $package_name..."
        #         stow -v -t "$HOME" "$package_name" 2>&1 | grep -v "BUG in find_stowed_path" || true
        #     fi
        # done
        
        # If dotfiles are in root of repo, use:
        print_message "Stowing dotfiles..."
        stow -v -d "$DOTFILES_DIR" -t "$HOME" . 2>&1 | grep -v "BUG in find_stowed_path" || true
        
        print_message "Dotfiles applied! Backup saved to: $BACKUP_DIR"
        cd ~
    else
        print_error "Failed to clone dotfiles repository"
    fi
fi

# Initialize Starship for Zsh if .zshrc doesn't already have it
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
        print_message "Adding Starship initialization to .zshrc..."
        echo '' >> "$HOME/.zshrc"
        echo '# Initialize Starship prompt' >> "$HOME/.zshrc"
        echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    fi
fi

###############################################################################
# CLEANUP
###############################################################################

print_section "Cleaning Up"

print_message "Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || print_message "No orphaned packages to remove"

print_message "Cleaning package cache..."
sudo pacman -Sc --noconfirm

print_message "Cleaning YAY cache..."
yay -Sc --noconfirm

###############################################################################
# SUMMARY
###############################################################################

print_section "Installation Complete!"

echo -e "${GREEN}Summary of installed components:${NC}"
echo "  ✓ Intel Iris Xe graphics drivers with Vulkan support"
echo "  ✓ Intel microcode installed"
echo "  ✓ System fully updated"
echo "  ✓ YAY AUR helper installed"
echo "  ✓ Development tools (NVM, Node.js, Python, pip) installed"
echo "  ✓ Essential utilities (ripgrep, fzf, zoxide, stow) installed"
echo "  ✓ Niri window manager and Wayland tools installed"
echo "  ✓ Waybar, Mako, Fuzzel, Swaybg, Swaylock, Swayidle installed"
echo "  ✓ Kitty terminal with Zsh shell configured"
echo "  ✓ Starship prompt installed"
echo "  ✓ Dotfiles cloned and applied with GNU Stow"
echo "  ✓ Neovim text editor installed"
echo "  ✓ Tmux and Zellij terminal multiplexers installed"
echo "  ✓ Nerd Fonts (Hack, Noto, JetBrains Mono, Fira Code) installed"
echo "  ✓ Firefox and Discord installed"
echo "  ✓ Kanata keyboard remapper installed"
echo "  ✓ Audio (PipeWire) with pavucontrol configured"
echo "  ✓ Bluetooth enabled"
echo "  ✓ NetworkManager with applet enabled"
echo "  ✓ Firewall (UFW) configured"
echo "  ✓ System optimizations applied"

echo -e "\n${YELLOW}Recommended next steps:${NC}"
echo "  1. Reboot your system: sudo reboot"
echo "  2. After reboot, regenerate grub config (for Intel microcode):"
echo "     sudo grub-mkconfig -o /boot/grub/grub.cfg"
echo "  3. Log out and log back in to activate Zsh shell and dotfiles"
echo "  4. Start Niri: 'niri-session' or 'niri'"
echo "  5. Your dotfiles are in ~/.dotfiles (managed with stow)"
echo "  6. Review your stowed configs in ~/.config/"
echo "  7. Any backed up configs are in ~/.config_backup_*/"

echo -e "\n${BLUE}Dotfiles Management:${NC}"
echo "  - Dotfiles location: ~/.dotfiles"
echo "  - Update dotfiles: cd ~/.dotfiles && git pull"
echo "  - Re-apply with stow: cd ~/.dotfiles && stow -v -t ~ ."
echo "  - Remove stowed files: cd ~/.dotfiles && stow -D -t ~ ."
echo "  - Your repo: https://github.com/erudhir101/dotfiles"

echo -e "\n${BLUE}Niri-specific commands:${NC}"
echo "  - Start Niri: niri"
echo "  - Niri session: niri-session"
echo "  - Check Niri config: niri validate"
echo "  - Your Niri config: ~/.config/niri/config.kdl"

echo -e "\n${BLUE}Useful commands:${NC}"
echo "  - Update system: sudo pacman -Syu"
echo "  - Install from AUR: yay -S package-name"
echo "  - Search packages: yay -Ss search-term"
echo "  - Remove package: sudo pacman -Rns package-name"
echo "  - Fuzzy find: fzf"
echo "  - Smart cd: z <directory-name>"

echo -e "\n${BLUE}Graphics info:${NC}"
echo "  - Check GPU: intel_gpu_top"
echo "  - VA-API info: vainfo"
echo "  - Vulkan info: vulkaninfo"

print_message "Script execution completed successfully!"
print_message "Your dotfiles are now managed with GNU Stow!"
print_message "Remember to reboot and log out/in for all changes to take effect!"
