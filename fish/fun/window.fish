#!/usr/bin/env fish

function get_windows
    niri msg windows | sd '\n  ' ';' | sd '\n\n' '\n'
end
funcsave get_windows >/dev/null

function matches
    get_windows | rg $argv
end
funcsave matches >/dev/null

function not_matches
    if get_windows | rg $argv
        return 1
    else
        return 0
    end
end
funcsave not_matches >/dev/null

function matches_except
    get_windows | rg -v $argv[1] | rg $argv[2]
end
funcsave matches_except >/dev/null

function win_wait
    loopuntil "matches '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait >/dev/null

function win_wait_closed
    loopuntil "not_matches '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait_closed >/dev/null

function win_wait_except
    loopuntil "matches_except '$argv[1]' '$argv[2]'" $argv[3..] | awk '{print $1}'
end
funcsave win_wait_except >/dev/null

function move_all
    if not set -q argv[2]
        return 1
    end
    set -l tag (math $argv[1] - 1)
    for win_id in $argv[2..]
        wmctrl -ir $win_id -t $tag
    end
end
funcsave move_all >/dev/null

function get_current_desktop
    wmctrl -d | awk '$2 == "*" { print $1 }'
end
funcsave get_current_desktop >/dev/null

function ensure_browser
    if not test (get_current_desktop) -eq 1
        wmctrl -s 1
    end
end
funcsave ensure_browser >/dev/null
