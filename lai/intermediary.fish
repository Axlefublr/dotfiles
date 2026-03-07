#!/usr/bin/env fish

mkfifo ~/.local/share/mine/task-scheduler
mkfifo ~/.local/share/mine/task-scheduler-intermediary
tail -f ~/.local/share/mine/task-scheduler-intermediary >~/.local/share/mine/task-scheduler
