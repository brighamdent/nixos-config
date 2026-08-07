#!/bin/bash

SESSION_NAME="music"

# Check if the session exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
  # If session exists, attach to it and focus on the "main" window
  tmux send-keys -t $SESSION_NAME "wal -R" C-m
  tmux send-keys -t $SESSION_NAME "clear" C-m
  tmux set-option status off
  tmux attach-session -t $SESSION_NAME -c $SESSION_NAME:1
else
  # If session doesn't exist, create it
  tmux new-session -d -s $SESSION_NAME -n music

  tmux set-option status off
  tmux send-keys -t $SESSION_NAME "wal -R" C-m
  tmux send-keys -t $SESSION_NAME "clear" C-m
  tmux send-keys -t $SESSION_NAME "cmus" C-m
  # Attach to the session
  tmux attach-session -t $SESSION_NAME

fi
