#!/usr/bin/env fish

function doti
    if status is-interactive
        _doti $argv
    else
        kitty -T timer fish -c "_doti $argv"
    end
end
funcsave doti >/dev/null

function _doti
    clx
    while true
        if set -q argv[1]
            termdown $argv[1] || break
        else
            termdown 25m || break
        end
        echo "You just acted! Rest now?"
        read -p rdp -ln 1 should_continue
        if not test $should_continue
            break
        end
        clx

        if set -q argv[2]
            termdown $argv[2] || break
        else
            termdown 5m || break
        end
        echo "You just rested! Act now?"
        read -p rdp -ln 1 should_continue
        if not test $should_continue
            break
        end
        clx
    end
    clx
end
funcsave _doti >/dev/null

function down
    if status is-interactive
        _down $argv
    else
        kitty -T timer fish -c "_down $(string escape $argv)" 2>/dev/null
    end
end
funcsave down >/dev/null

function _down
    termdown $argv
    if not status is-interactive
        and test "$argv" # termdown with no arguments counts up, which can only exit if I specifically close it myself
        notify-send -t 0 "timer for $argv is up!"
    end
end
funcsave _down >/dev/null

function timer
    if status is-interactive
        _timer "$argv"
    else
        kitty -T timer fish -c "_timer $(string escape $argv)" 2>/dev/null
    end
end
funcsave timer >/dev/null

function _timer
    while true
        termdown $argv || break
        read -p rdp -ln 1 response
        if not test $response
            break
        end
        if test $response = ' '
            clx
            continue
        else if test $response = e
            exit
        else
            break
        end
    end
    clx
end
funcsave _timer >/dev/null

function alarm
    if status is-interactive
        _alarm "$argv"
    else
        kitty -T timer fish -c "_alarm $(string escape $argv)"
    end
end
funcsave alarm >/dev/null

function _alarm
    set -l input $argv[1]
    set -l first (string sub -l 1 $input)
    if test $first != 0 && test $first != 1 && test $first != 2
        set input '0'$input
    end
    set -l input (string pad -r -c 0 -w 6 $input)
    echo "set time: $input"
    echo "current:  $(date +%H%M%S)"
    if test $input -lt (date +%H%M%S)
        echo 'input lower than current, reversing'
        while test $input -lt (date +%H%M%S)
            sleep 0.1
        end
        echo 'finished reversing'
    end
    while test $input -gt (date +%H%M%S)
        sleep 0.1
    end
    if status is-interactive
        bell
    else
        notify-send -t 0 "alarm set for $argv[1] is ringing!"
    end
end
funcsave _alarm >/dev/null

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
        task "$year years ago: $description"
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
        task "$description"
    end
end
funcsave yearless_parse >/dev/null

function daily_parse
    for line in (cat ~/prog/noties/once.txt | string split '\n')
        set -l match (string match -gr '(\\d+.\\d+.\\d+) (\\d+:\\d+) — (.*)' $line)
        set -l date $match[1]
        set -l time $match[2]
        set -l description $match[3]
        if not test $date = (date '+%y.%m.%d')
            continue
        end
        task "today at $time — $description"
    end
end
funcsave daily_parse >/dev/null
