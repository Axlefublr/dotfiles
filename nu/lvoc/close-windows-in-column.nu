#!/usr/bin/env -S nu -n --no-std-lib

let the = niri msg -j windows | from json
let focused_column = $the
| where is_focused == true
| get layout.pos_in_scrolling_layout.0.0
$the
| where layout.pos_in_scrolling_layout.0 == $focused_column
| get id
| each { |id| niri msg action close-window --id $id }
