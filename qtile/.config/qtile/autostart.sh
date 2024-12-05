#!/bin/sh
autorandr --change &
feh --bg-scale /mnt/Backup/Documents/Images/painting.jpg
picom --config ~/.config/picom/picom.conf &
blueman-applet &
nm-applet &
flameshot & 
libinput-gestures-setup start &
