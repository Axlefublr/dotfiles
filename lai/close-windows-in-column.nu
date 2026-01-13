#!/usr/bin/env -S nu -n --no-std-lib

let the = niri msg -j windows | from json
let focused = $the | where is_focused == true
let focused_column = $focused | get layout.pos_in_scrolling_layout.0.0
let focused_workspace = $focused | get workspace_id.0

$the
| where layout.pos_in_scrolling_layout.0 == $focused_column
| where workspace_id == $focused_workspace
| get id
| each { |id| niri msg action close-window --id $id }
