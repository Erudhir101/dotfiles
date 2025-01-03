#!/usr/bin/env bash

config="$HOME/.config/rofi/power-menu.rasi"

actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n$(printf '\u200A')  Suspend\n  Hibernate\n  Logout")

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -theme "${config}")

# Perform actions based on the selected option
case "$selected_option" in
*Lock)
      if [[ "$DESKTOP_SESSION" == 'qtile' ]]; then
			betterlockscreen -l blur
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
			# i3lock --image /mnt/backup/Documents/Images/womanincamp.png --show-failed-attempts
			betterlockscreen -l blur
			elif [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
        hyprlock
			fi
  ;;
*Shutdown)
  systemctl poweroff
  ;;
*Reboot)
  systemctl reboot
  ;;
*Suspend)
  systemctl suspend
  ;;
*Hibernate)
  systemctl hibernate
  ;;
*Logout)
      if [[ "$DESKTOP_SESSION" == 'qtile' ]]; then
        qtile cmd-obj -o cmd -f shutdown
			elif [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			elif [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
        hyprctl dispatch exit 0
			elif [[ "$DESKTOP_SESSION" == 'dwm' ]]; then
       pkill -KILL -u $USER 
			fi
  ;;
esac
