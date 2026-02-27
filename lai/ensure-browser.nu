#!/usr/bin/env -S nu --no-std-lib -n

niri msg -j windows
| from json
| where app_id == firefox
| where is_focused == false
| get id
| try { first }
| each {
	niri msg action focus-window --id $in
} | ignore
