# apps para instalar

```bash
sudo yay -S base-devel ntfs-3g picom neovim lxappearance brightnessctl bluez bluz-utils blueman git lazygit github-cli nodejs npm rofi autorandr sof-firmware xclip unzip intel-ucode vlc python3 zoxide zsh eza fzf ufw stow discord firefox kitty ttf-hack-nerd
```

## para reconhecer o disco backup (sda1)

- colocar dentro do **/etc/fstab**

UUID=789CC5889CC5417C /mnt/backup ntfs3 uid=1000,gid=1000,rw,user,exec,umask=000 0 0
