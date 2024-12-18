#!/bin/sh
autorandr --change &
feh --bg-scale /mnt/Backup/Documents/Images/painting.jpg
picom -b --config ~/.config/picom/picom.conf &
dunst &
blueman-applet &
nm-applet &
flameshot & 
libinput-gestures-setup start &
