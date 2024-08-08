#!/usr/bin/env fish

echo $argv | xclip -selection clipboard -r
copyq remove 0
xdotool key ctrl+v
