#!/usr/bin/env fish

xremap --mouse --watch ~/prog/dotfiles/xremap/config.yml & disown
ydotoold & disown
gromit-mpx -k "none" -u "none" & disown

kitty --hold kitten @set-window-title timerkitty & disown
kitty -T meow & disown