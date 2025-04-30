#!/bin/bash

choice=$(
  echo -e " Shutdown\n Restart\n Logout\n Suspend\n Lock" | dmenu -c -i -p "Power:" -l 5 | sed "s/^[^ ]* //"
)

case "$choice" in
Shutdown) exec systemctl poweroff ;;
Restart) exec systemctl reboot ;;
Logout)
  echo "Logging out from session: $DESKTOP_SESSION"
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
  elif [[ "$DESKTOP_SESSION" == 'sway' ]]; then
    sway exit
  else
    echo "Logout command not defined for session: $DESKTOP_SESSION"
  fi
  ;;
Suspend) exec systemctl suspend ;;
Lock)
  if [[ "$DESKTOP_SESSION" == 'qtile' ]]; then
    betterlockscreen -l blur
  elif [[ "$DESKTOP_SESSION" == 'sway' ]]; then
    swaylock
  elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
    betterlockscreen -l blur
  elif [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
    hyprlock
  fi
  ;;
*)
  echo "No valid option selected."
  ;;
esac
