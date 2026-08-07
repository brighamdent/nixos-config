#!/bin/bash

# Get the list of available sinks
sinks=$(pactl list short sinks | awk '{print $1}')

# Get the current default sink
current_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Find the current sink index
current_sink_index=$(echo "$sinks" | grep -n "^$current_sink$" | cut -d: -f1)

echo "current_sink_index" $current_sink_index

# Calculate the next sink index (wrap around if necessary)
next_sink_index=$(( (current_sink_index % $(echo "$sinks" | wc -l)) + 1 ))

# Get the sink ID of the next sink
next_sink=$(echo "$sinks" | sed -n "${next_sink_index}p")

echo "next index" $next_sink_index

# Set the next sink as the default
pactl set-default-sink "$next_sink"

# # Move all currently playing audio to the new sink
# pactl list short sink-inputs | while read -r input; do
#     input_id=$(echo "$input" | awk '{print $1}')
#     pactl move-sink-input "$input_id" "$next_sink"
# done
