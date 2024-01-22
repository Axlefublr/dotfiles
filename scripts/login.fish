#!/usr/bin/env fish

mkdir -p /tmp/log

xremap --mouse --watch ~/prog/dotfiles/xremap/config.yml &> /tmp/log/xremap.txt & disown
ydotoold &> /tmp/log/ydotoold.txt & disown
gromit-mpx -k "none" -u "none" &> /tmp/log/gromit-mpx.txt & disown
ollama serve &> /tmp/log/ollama.txt & disown

kitty --hold kitten @set-window-title timerkitty & disown
kitty -T meow & disown

winwaitclass code 1 0 30
winmoveall code 4
winwaitclass vivaldi-stable 1 0 30
winmoveall vivaldi-stable 1
winwaitname 'Discord' 1 0 30
wmctrl -r 'Discord' -t 8
winwaitname 'Watch later' 1 0 30
wmctrl -r 'Watch later' -t 10
winwaitname 'Anki' 1 0 30
loopuntil close-anki-popup 1 0.5 30