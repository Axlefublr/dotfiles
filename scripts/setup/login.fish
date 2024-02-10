#!/usr/bin/env fish

mkdir -p /tmp/log

xremap --mouse ~/prog/dotfiles/xremap/xremap.yml >> /tmp/log/xremap.txt & disown
ydotoold >> /tmp/log/ydotoold.txt & disown
gromit-mpx -k "none" -u "none" >> /tmp/log/gromit-mpx.txt & disown
# ollama serve >> /tmp/log/ollama.txt & disown

vivaldi-stable --force-dark-mode >> /tmp/log/vivaldi.txt & disown
code >> /tmp/log/vscode.txt & disown

winwaitclass code 0.5 0 20
kitty -d ~/prog/dotfiles & disown
# winmoveall code 4
# wmctrl -s 4

winwaitclass vivaldi-stable 0.5 0 20
winmoveall vivaldi-stable 1
winwaitname 'Discord' 0.5 0 20
wmctrl -r 'Discord' -t 8
winwaitname 'YouTube' 0.5 0 20
wmctrl -r 'YouTube' -t 10

loopuntil is-internet 0.5 0 60
spotify-launcher -v >> /tmp/log/spotify.txt & disown

sleep 10
xset r rate 170 40 >> /tmp/log/xset.txt
xset s off >> /tmp/log/xset.txt
xmodmap ~/prog/dotfiles/x11/xmodmap.txt >> /tmp/log/xmodmap.txt
