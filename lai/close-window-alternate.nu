#!/usr/bin/env -S nu --no-std-lib -n

let focused = niri msg -j windows
| from json
| where is_focused == true
| first
| get id
niri msg action focus-window-previous
niri msg action close-window --id $focused
