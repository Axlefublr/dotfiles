#!/usr/bin/env fish

function runner
    set preset ~/.local/share/magazine/L
    set histori ~/.local/share/magazine/H
    truncate -s 0 ~/bs/runner_input
    for line in (echo "$(cat $histori)" | tac | awk '!seen[$0]++' | tac)
        if not contains $line (cat $preset)
            echo $line
        end
    end | while read -l line
        set last $last $line
    end
    printf '%s\n' $last | tail -n 30 >$histori
    begin
        echo "$(cat $preset)"
        cat $histori
    end | rofi -dmenu 2>/dev/null >~/bs/runner_input
    indeed $histori (cat ~/bs/runner_input)
    if set -q argv[1]
        set output "$(source ~/bs/runner_input &| tee ~/.local/share/magazine/o)"
        notify-send -t 2000 "$output"
    else
        source ~/bs/runner_input
    end
    _magazine_commit ~/.local/share/magazine/H command history
    _magazine_commit ~/.local/share/magazine/o command output
end
funcsave runner >/dev/null

function runner_kill
    set selected (ps -eo pid,command | zat --start 2 | string trim --left | rofi_multi_select 2> /dev/null)
    for line in $selected
        kill (string match -gr '^(\\d+)' $line)
    end
end
funcsave runner_kill >/dev/null

function runner_math
    set input (rofi -dmenu -input ~/bs/qalc_history 2>/dev/null)
    test $status -ne 0 && return 1
    test -n "$input" || return 1
    set result "$(qalc $input)"
    notify-send -t 0 $result
    qalc -t $input | tee ~/.local/share/magazine/o | copy
    indeed -n ~/bs/qalc_history $input
    tail -n 1 ~/bs/qalc_history | sponge ~/bs/qalc_history
    _magazine_commit ~/.local/share/magazine/o math
end
funcsave runner_math >/dev/null

function runner_symbol
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    if test -z "$result"
        return 1
    end
    set output ''
    for code in (string split ' ' $result)
        set output $output"\U$code"
    end
    printf $output 2>/dev/null | copy
    xdotool key ctrl+v
end
funcsave runner_symbol >/dev/null

function runner_symbol_name
    set result (rofi -input ~/.local/share/magazine/E -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    if test -z "$result"
        return 1
    end
    printf '\U'(string pad --char 0 --width 8 (string split ' ' $result)[1]) 2>/dev/null | xclip -r -selection clipboard
end
funcsave runner_symbol_name >/dev/null

function runner_link
    set file ~/.local/share/magazine/l
    set result (cat $file | sd ' — .+$' '' | rofi -format 'i' -dmenu 2> /dev/null)
    test $status -ne 0 && return 1
    set line (math $result + 1)
    set link (awk "NR==$line { print \$NF }" $file)
    if test "$argv[1]"
        $BROWSER $link
        ensure_browser
    else
        echo $link | copy
        notify-send -t 2000 "copied link: $link"
    end
end
funcsave runner_link >/dev/null

function runner_notification
    set -f do_it_again true
    while $do_it_again
        set do_it_again false
        set result (rofi -dmenu 2>/dev/null ; echo $status)
        if test $result[-1] -eq 10
            set do_it_again true
        else if $result[-1] -ne 0
            return 1
        end
        set -e result[-1]
        notify-send -t 0 -- "$result"
        echo "$result" >~/.local/share/magazine/o
        _magazine_commit ~/.local/share/magazine/o notif
    end
end
funcsave runner_notification >/dev/null

function runner_interactive_unicode
    set result (rofi -input ~/.local/share/magazine/e -dmenu 2>/dev/null ; echo $status)
    if not contains $result[2] 0 10 11 12
        return 1
    end
    echo (string split ' ' $result[1])[1] | copy
end
funcsave runner_interactive_unicode >/dev/null
