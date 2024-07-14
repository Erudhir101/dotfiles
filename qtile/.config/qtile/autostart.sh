#!/bin/sh
autorandr --change &
feh --bg-scale ~/.config/wallpapers/'red sunset'.png &
picom -b &
libinput-gestures-setup start &
blueman-applet &
nm-applet &
