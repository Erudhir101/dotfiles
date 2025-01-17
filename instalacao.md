# apps para instalar

```bash
sudo yay -S base-devel ntfs-3g picom neovim tmux lxappearance brightnessctl pavucontrol bluez bluz-utils blueman git lazygit github-cli nodejs npm rofi autorandr sof-firmware xclip wl-clipboard unzip intel-ucode vlc python3 jre8-openjdk zoxide zsh eza fzf ufw stow discord libreoffice-fresh firefox kitty ghostty ttf-hack-nerd adobe-source-sans-pro-fonts noto-fonts-cjk
```

## para reconhecer o disco backup (sda1)

- colocar dentro do **/etc/fstab**

UUID=789CC5889CC5417C /mnt/backup ntfs3 uid=1000,gid=1000,rw,user,exec,umask=000 0 0

- usando as configuracoes do archwiki

/dev/sda /mnt/backup ntfs-3g uid=userid,gid=groupid,dmask=022,fmask=133 0 0
