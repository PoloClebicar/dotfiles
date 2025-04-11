#!/bin/bash

# Small delay to make sure Hyprland is ready
sleep 2 

MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Launch apps (they’ll jump to correct workspaces via window rules) if all the monitors are connected
if echo "$MONITORS" | grep -q "HDMI-A-1"; then
    ghostty &
    discord &
    spotify &
fi

# Brave aways open on the laptop screen, so it does no matter if the monitor is on or not
# Launch Brave in two different profiles
brave &

