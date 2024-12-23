#!/bin/bash

# Set display for notifications
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# Configuration
LOW_BATTERY_LEVEL=25
FULL_BATTERY_LEVEL=80
CRITICAL_BATTERY_LEVEL=10
NOTIFICATION_TIMEOUT=10000
NOTIFICATION_ID=2593

# Get battery percentage
BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Get charging status
CHARGING=$(acpi -b | grep -c "Charging")

# Check if battery level was obtained successfully
if [ -n "$BATTERY_LEVEL" ]; then
    # Check for low battery
    if [ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY_LEVEL" ] && [ "$CHARGING" -eq 0 ]; then
        dunstify -u critical -r "$NOTIFICATION_ID" -t "$NOTIFICATION_TIMEOUT" \
            "Critical Battery Warning!" "Battery level is ${BATTERY_LEVEL}%\nPlease connect charger immediately!"
    elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY_LEVEL" ] && [ "$CHARGING" -eq 0 ]; then
        dunstify -u normal -r "$NOTIFICATION_ID" -t "$NOTIFICATION_TIMEOUT" \
            "Low Battery Warning" "Battery level is ${BATTERY_LEVEL}%"
    fi
    
    # Check for full battery while charging
    if [ "$BATTERY_LEVEL" -ge "$FULL_BATTERY_LEVEL" ] && [ "$CHARGING" -eq 1 ]; then
        dunstify -u normal -r "$NOTIFICATION_ID" -t "$NOTIFICATION_TIMEOUT" \
            "Battery Full" "Battery level is ${BATTERY_LEVEL}%\nYou can unplug the charger"
    fi
fi
