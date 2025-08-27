#!/usr/bin/env fish

not test -p ~/.local/share/mine/waybar-screen-record && mkfifo ~/.local/share/mine/waybar-screen-record
tail -f ~/.local/share/mine/waybar-screen-record
