#!/usr/bin/env fish

function timer
    while true
        termdown $argv || return 1
        read -ln 1 response
        if not test $response
            return 1
        end
        if test $response = e
            exit
        else if test $response = ' '
            clear -x
            continue
        else
            break
        end
    end
    clear -x
end
funcsave timer >/dev/null

function alarm
    set -l input $argv[1]
    set -l first (string sub -l 1 $input)
    if test $first != 0 && test $first != 1 && test $first != 2
        set input '0'$input
    end
    set -l input (string pad -r -c 0 -w 6 $input)
    while test $input -gt (date +%H%M%S)
        sleep 0.1
    end
    sleep 0.5
    bell
end
funcsave alarm >/dev/null

function doti
    while true
        kitten @set-window-title action
        if set -q argv[1]
            termdown $argv[1] || break
        else
            termdown 25m || break
        end
        echo "You just acted! Rest now?"
        read -ln 1 should_continue
        if not test $should_continue
            break
        end
        clear

        kitten @set-window-title rest
        if set -q argv[2]
            termdown $argv[2] || break
        else
            termdown 5m || break
        end
        echo "You just rested! Act now?"
        read -ln 1 should_continue
        if not test $should_continue
            break
        end
        clear
    end
    clear
    kitten @set-window-title
end
funcsave doti >/dev/null

function yeared_parse
    for line in (cat ~/prog/noties/anniversaries.txt | string split '\n')
        set -l match (string match -gr '(\\d+).(\\d+.\\d+) — (.*)' $line)
        set -l year $match[1]
        set -l date $match[2]
        set -l description $match[3]
        if not test $date = (date +%m.%d)
            continue
        end
        set year (math (date +%y) - $year)
        indeed ~/.local/share/magazine/6 "$year years ago: $description"
        update_magazine 6
    end
end
funcsave yeared_parse >/dev/null

function yearless_parse
    for line in (cat ~/prog/noties/yearly.txt | string split '\n')
        set -l match (string match -gr '(\\d+.\\d+) — (.*)' $line)
        set -l date $match[1]
        set -l description $match[2]
        if not test $date = (date +%m.%d)
            continue
        end
        indeed ~/.local/share/magazine/6 "$description"
        update_magazine 6
    end
end
funcsave yearless_parse >/dev/null

function daily_parse
    for line in (cat ~/prog/noties/events.txt | string split '\n')
        set -l match (string match -gr '(\\d+.\\d+.\\d+) (\\d+:\\d+) — (.*)' $line)
        set -l date $match[1]
        set -l time $match[2]
        set -l description $match[3]
        if not test $date = (date '+%y.%m.%d')
            continue
        end
        indeed ~/.local/share/magazine/6 "today at $time — $description"
        update_magazine 6
    end
end
funcsave daily_parse >/dev/null