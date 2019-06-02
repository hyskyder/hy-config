#!/bin/bash

SessionName=work
WindowName=main

tmux new-session -d -s $SessionName -n $WindowName -x 1000 -y 1000
tmux split-window -d -h -t "$TMUX_SESSION_NAME:$TMUX_MAINWINDOW_NAME"

tmux send -t "$TMUX_SESSION_NAME:$TMUX_MAINWINDOW_NAME.1" "python3" ENTER
tmux attach -t "$TMUX_SESSION_NAME:$TMUX_MAINWINDOW_NAME.0"