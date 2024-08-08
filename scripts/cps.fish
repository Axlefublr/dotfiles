#!/usr/bin/env fish

echo $argv | xclip -selection clipboard -r
xdotool key ctrl+v
copyq remove 0
