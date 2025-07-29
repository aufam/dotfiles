#!/bin/bash

cd
session=$(tmux list-sessions 2>/dev/null | grep -v "(attached)" | head -n 1 | cut -d: -f1)
if [ -n "$session" ]; then
  exec tmux attach -t "$session"
else
  exec tmux
fi
