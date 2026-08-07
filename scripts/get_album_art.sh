#!/bin/bash

# Get the file path of the currently playing song using mpc
current_song=$(mpc -f "%file%" current)

# Define the path to your music library
music_library="$HOME/media/music/Liked Songs"

# Construct the full path to the currently playing song
current_song_path="$music_library/$current_song"

# Define the output file path for album art
output_file="/tmp/cover.jpg"

# Extract album art using ffmpeg and overwrite the existing file without asking for confirmation
ffmpeg -y -i "$current_song_path" -an -vcodec copy "$output_file" > /dev/null 2>&1
