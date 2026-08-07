#!/bin/bash

# notify-send "Script started"

monitors_output=$(hyprctl monitors all)

if [[ "$monitors_output" =~ HDMI-A-1 || "$monitors_output" =~ DP-1 ]]; then
  # notify-send "HDMI-A-1 detected"
  if [[ $1 == "open" ]]; then
    hyprctl keyword monitor "eDP-1, 1920x1200@60,1920x0,1.25"
    # notify-send "eDP-1 configured"
  else
    hyprctl keyword monitor "eDP-1,disable"
    # notify-send "eDP-1 disabled"
  fi
else
  hyprctl keyword monitor "eDP-1, 1920x1200@60,1920x0,1.25"
  # notify-send "HDMI-A-1 not detected"
fi
