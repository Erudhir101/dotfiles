#!/bin/sh
autorandr --change &
feh --bg-scale /mnt/Backup/Documents/Images/'8bits CyberPunk'.png
picom -b --config ~/.config/picom/picom.conf &
dunst &
blueman-applet &
nm-applet &
flameshot & 
libinput-gestures-setup start &
