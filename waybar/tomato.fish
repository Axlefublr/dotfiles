#!/usr/bin/env fish

not test -p ~/.local/share/mine/waybar-tomato && mkfifo ~/.local/share/mine/waybar-tomato
tail -f ~/.local/share/mine/waybar-tomato
