#!/usr/bin/env fish

set -l input (tac ~/.local/share/magazine/c-t | fuzzel -d --match-mode exact 2>/dev/null)
not test "$input" && return 1
set -l the (string split ' ' -- $input)
set -l title $the[1]
if string match -qr '!$' -- $title
    set -f repeat true
else
    set -f repeat false
end
set -l rest $the[2..]
# doing some titling logic here so that window rules work as expected; window title may change afterwards
set -l genre (resolve_time_counter_genre "$the[2]")
set -l prev_win_id (na -c "niri msg -j windows | from json | where is_focused == true | get id | first")
niri msg action do-screen-transition -d 180
niri msg action spawn -- foottitled.sh "$genre $title" -N timer.fish $repeat "$prev_win_id" $title $rest
indeed.rs -u ~/.local/share/magazine/c-t -- "$input"
tail -n 100 ~/.local/share/magazine/c-t | sponge ~/.local/share/magazine/c-t
