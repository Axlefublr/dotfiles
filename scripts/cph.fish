#!/usr/bin/env fish

echo $argv >/dev/shm/compose_shell_command
source /dev/shm/compose_shell_command | xclip -selection clipboard -r
xdotool key ctrl+v
copyq remove 0
