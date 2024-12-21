#!/usr/bin/env fish

while true
    inotifywait -qq -e close_write -e move_self ~/.local/share/magazine/comma
    sleep 0.1
    ~/.local/share/magazine/comma >~/.local/share/magazine/0
end
