#!/usr/bin/env fish

not test -p ~/.local/share/mine/waybar-gaming && mkfifo ~/.local/share/mine/waybar-gaming
tail -f ~/.local/share/mine/waybar-gaming
