#!/bin/bash

# Set display for notifications
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# Configuration
NOTIFICATION_TIMEOUT=5000  # 5 seconds
NOTIFICATION_ID=2594      # Unique ID for charging notifications

# Get battery percentage
BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Check battery state
BATTERY_STATE=$1

case "$BATTERY_STATE" in
    "0"|"charging")
        dunstify -u normal -r "$NOTIFICATION_ID" -t "$NOTIFICATION_TIMEOUT" \
            "Battery Charging" "Battery level is ${BATTERY_LEVEL}%"
        ;;
    "1"|"discharging")
        dunstify -u normal -r "$NOTIFICATION_ID" -t "$NOTIFICATION_TIMEOUT" \
            "Battery Unplugged" "Battery level is ${BATTERY_LEVEL}%"
        ;;
esac
