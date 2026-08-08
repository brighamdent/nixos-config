#!/bin/bash
REPO_DIR=~/Documents/Notes

inotifywait -m -e modify,create,delete "$REPO_DIR" |
while read -r _ action _; do
    if [ "$action" != "DELETE_SELF" ]; then
        # Run the command
        cd "$REPO_DIR" || exit
        # Add all changes
        git add .
        # Commit changes with a timestamp
        git commit -m "Synced on $(date)"
        # Push to the remote repository
        git push origin main
    fi
done
