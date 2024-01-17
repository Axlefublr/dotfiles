#!/usr/bin/env fish

mkdir -p /tmp/log

xremap --mouse --watch ~/prog/dotfiles/xremap/config.yml &> /tmp/log/xremap.txt & disown
ydotoold &> /tmp/log/ydotoold.txt & disown
gromit-mpx -k "none" -u "none" &> /tmp/log/gromit-mpx.txt & disown
ollama serve &> /tmp/log/ollama.txt & disown

kitty --hold kitten @set-window-title timerkitty & disown
kitty -T meow & disown