#!/bin/sh

SESSION_NAME="float"

# Check if the session exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    tmux send-keys -t $SESSION_NAME "wal -R" C-m
    tmux send-keys -t $SESSION_NAME "clear" C-m
    # If session exists, attach to it and focus on the "main" window
    tmux attach-session -t $SESSION_NAME -c $SESSION_NAME:1
else
    # If session doesn't exist, create it
    tmux new-session -d -s $SESSION_NAME -n main
    tmux new-window -t $SESSION_NAME: -n server
    tmux new-window -t $SESSION_NAME: -n misc
    tmux select-window -t $SESSION_NAME:1
    tmux send-keys -t $SESSION_NAME "wal -R" C-m
    tmux send-keys -t $SESSION_NAME "clear" C-m
    # Attach to the session
    tmux attach-session -t $SESSION_NAME
fi
