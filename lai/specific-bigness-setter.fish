#!/usr/bin/env fish

fuzzel -dl 0 </dev/null | read -tal input
test "$input" || return 1
for bit in (velvidek.rs $input)
    set -l trimmed (string trim -c i $bit)
    if test $status -eq 0
        niri msg action set-window-height "$trimmed"%
    else
        niri msg action set-column-width "$trimmed"%
    end
end
niri msg action center-visible-columns
Image
