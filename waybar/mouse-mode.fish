#!/usr/bin/env fish

not test -p ~/.local/share/mine/waybar-mouse-mode && mkfifo ~/.local/share/mine/waybar-mouse-mode
tail -f ~/.local/share/mine/waybar-mouse-mode
