#!/bin/bash

status="$(grep -Po '^charging\s+state:\s+\K.*$' /proc/acpi/battery/BAT0/state)"

if [[ $status = 'charging' ]]; then
    ##Charging, Do something

elif [[ $status = 'discharging' ]]; then
    ##Discharging, Do something

elif [[ $status = 'charged' ]]; then
    ##Charged, Do something

else
    ##Battery not found, Do something
fi
