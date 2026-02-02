#!/usr/bin/env fish

set -l width_flag --width 55
set -l input (tac ~/.local/share/magazine/L | fuzzel -d --match-mode exact $width_flag 2>/dev/null)
set -l saved_status $status
set -l input (string trim -l "$input")
if test $status -eq 0
    or test "$input" = ""
    set -f should_history false
else
    set -f should_history true
end
not test $saved_status -eq 0 && return 1
set -l engine_index (
    for line in (cat ~/.local/share/magazine/B)
        set -l bits (string split ' — ' $line)
        echo $bits[1] | string trim
    end | fuzzel -d --index --match-mode fzf --cache ~/.cache/mine/engined-search $width_flag 2>/dev/null
)
not test "$engine_index" && return 1
set -l engine (
    set -l bits (zat.rs ~/.local/share/magazine/B ",$engine_index" | string split ' — ')
    if test $saved_status -eq 0
        echo $bits[-1]
    else
        echo $bits[2]
    end
)
if not test "$engine"
    notify-send 'engine empty, somehow'
    return 1
end

set -l clean_input (string escape --style=url -- $input)
$BROWSER (string replace -- %% $clean_input $engine)
ensure_browser
if $should_history
    indeed.rs -u ~/.local/share/magazine/L -- $input
    tail -n 100 ~/.local/share/magazine/L | sponge ~/.local/share/magazine/L
else
    rg -vFx $input ~/.local/share/magazine/L | tail -n 500 | sponge ~/.local/share/magazine/L
end
_magazine_commit ~/.local/share/magazine/L 'search history'
