#!/bin/bash

set -e

echo "Instalando dependências essenciais (git, base-devel)..."
sudo pacman -S --needed --noconfirm git base-devel
cd
if ! command -v yay &> /dev/null; then
    echo "Instalando o AUR Helper 'yay'..."
    git clone https://aur.archlinux.org/yay.git
    cd yay/
    makepkg -si --noconfirm
    cd ..
    rm -rf yay/
else
    echo "'yay' já está instalado. Pulando..."
fi

yay -Syu --noconfirm

echo "Instalando pacotes de software, fontes e ambiente Sway..."
yay -S --needed --noconfirm intel-ucode network-manager-applet pavucontrol ufw nodejs kitty neovim python python-pip ripgrep fzf zoxide zsh tmux zellij discord firefox swaybg swaylock swayidle waybar flameshot fuzzel mako kanata ntfs-3g ttf-hack-nerd ttf-noto-nerd ttf-jetbrains-mono-nerd ttf-fira-code

echo "Configurando e ativando o firewall UFW..."
sudo systemctl enable ufw.service
sudo ufw enable

echo "Configurando o segundo HD..."
echo 'UUID=789CC5889CC5417C /mnt/backup ntfs-3g uid=1000,gid=1000,rw,user,exec,umask=0022 0 0' | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo mount -a 
