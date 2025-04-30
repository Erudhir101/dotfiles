#!/bin/sh
autorandr --change &
feh --bg-scale /media/erudhir/Documents/Images/'8bits CyberPunk'.png 
picom -b --config ~/.config/picom/picom.conf &
dunst &
blueman-applet &
nm-applet &
flameshot & 
# libinput-gestures-setup start &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & # Graphical authentication agent
