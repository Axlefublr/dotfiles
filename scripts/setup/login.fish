#!/usr/bin/env fish

mkdir -p /tmp/log

xremap --mouse ~/prog/dotfiles/xremap/xremap.yml >> /tmp/log/xremap.txt & disown
ydotoold >> /tmp/log/ydotoold.txt & disown
gromit-mpx -k "none" -u "none" >> /tmp/log/gromit-mpx.txt & disown
# ollama serve >> /tmp/log/ollama.txt & disown

# vivaldi-stable --force-dark-mode >> /tmp/log/vivaldi.txt & disown
code >> /tmp/log/vscode.txt & disown
# kitty --hold kitten @set-window-title timerkitty & disown
# kitty -T meow & disown

# winwaitclass code 0.5 0 20
kitty -d ~/prog/dotfiles & disown
# winwaitname 'dotfiles' 0.5 0 20
# wmctrl -r 'dotfiles' -t 0
# wmctrl -s 0
# wm-rotate
# wm-rotate
# for __ in (seq 1 5)
# 	wm-increase-master-window-size
# end
# sleep 1

# winmoveall code 4
# wmctrl -s 4
# wm-rotate
# wm-rotate
# sleep 1

# winwaitclass vivaldi-stable 0.5 0 20
# winmoveall vivaldi-stable 1
# winwaitname 'Discord' 0.5 0 20
# wmctrl -r 'Discord' -t 8
# winwaitname 'YouTube' 0.5 0 20
# wmctrl -r 'YouTube' -t 10

# wmctrl -s 6
# wm-decrease-master-windows
# sleep 1

# wmctrl -s 7
# wm-decrease-master-windows
# sleep 1

loopuntil is-internet 0.5 0 60
spotify-launcher -v >> /tmp/log/spotify.txt & disown

xmodmap ~/prog/dotfiles/x11/xmodmap.txt >> /tmp/log/xmodmap.txt
