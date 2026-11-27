#!/usr/bin/env -S nu --no-std-lib -n

niri msg -j windows
| from json
| where is_focused == true
| where app_id == firefox
| where title like 'Discord'
| where title ends-with ' | The Rock Collection — Mozilla Firefox'
| is-not-empty
| if not $in { exit 1 }
