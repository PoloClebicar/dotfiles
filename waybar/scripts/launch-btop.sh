#!/bin/bash

# Check if we're in a tmux session
if tmux has-session 2>/dev/null; then
  if tmux list-windows -F '#W' | grep -q '^btop$'; then
    tmux select-window -t btop
  else
    tmux new-window -n btop btop
  fi
else
  ghostty -e tmux new-session -s main -n btop btop
fi
