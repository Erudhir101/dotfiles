#!/usr/bin/env bash

config="$HOME/.config/rofi/power-menu.rasi"

actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n$(printf '\u200A')  Suspend\n  Hibernate\n  Logout")

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}")

# Get the session type
session_type="$XDG_SESSION_TYPE"

# Define logout commands based on session type
wayland_logout_cmd="hyprctl dispatch exit 0"

# --- CUSTOMIZE THIS ---
# Define your X11 logout command here.
# This depends on your specific X11 window manager or desktop environment.
# Common examples:
# i3:           i3-msg exit
# Openbox:      openbox --exit
# GNOME:        gnome-session-quit --logout
# XFCE:         xfce4-session-logout --logout
# Generic (may work, but can be abrupt): pkill X
# ----------------------
x11_logout_cmd="i3-msg exit"

# Perform actions based on the selected option
case "$selected_option" in
*Lock)
  # Note: hyprlock is specific to Hyprland (Wayland).
  # If you need a different lock screen for X11,
  # you would add a similar if/elif structure here.
  hyprlock
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
  case "$session_type" in
    "wayland")
      echo "Logging out from Wayland..." # Optional: Add some feedback
      # Execute the Wayland logout command
      eval "$wayland_logout_cmd"
      ;;
    "x11")
      # Check if the X11 command is set (not the default placeholder)
      if [ "$x11_logout_cmd" = "YOUR_X11_LOGOUT_COMMAND_HERE" ]; then
          echo "Error: X11 logout command not configured in the script!"
          exit 1 # Exit with an error
      fi
      echo "Logging out from X11..." # Optional: Add some feedback
      # Execute the X11 logout command
      eval "$x11_logout_cmd"
      ;;
    *)
      # Fallback for unknown session types
      echo "Unknown session type: '$session_type'. Cannot perform specific logout."
      echo "Attempting generic systemctl logout..."
      # A generic logout attempt
      systemctl logout || exit 1
      ;;
  esac
  ;;
esac
