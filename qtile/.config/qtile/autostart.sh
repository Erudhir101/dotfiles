#!/bin/sh
autorandr --change &
feh --bg-scale ~/.config/wallpapers/'red sunset'.png &
picom ~/.config/picom/picom.conf &
libinput-gestures-setup start &
blueman-applet &
nm-applet &
