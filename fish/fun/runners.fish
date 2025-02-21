#!/usr/bin/env fish

function runner
    set runned ~/.local/share/magazine/L
    set -l input (tac $runned | fuzzel -d 2>/dev/null)
    test $status -ne 0 && return 1
    set input_file ~/.cache/mine/runner-command
    echo $input >$input_file
    if set -q argv[1]
        set output "$(source $input_file &| tee ~/.local/share/magazine/o)"
        notify-send "$output"
    else
        source $input_file
    end
    indeed.rs -u $runned -- $input
    tail -n 30 $runned | sponge $runned
    _magazine_commit ~/.local/share/magazine/L command history
    _magazine_commit ~/.local/share/magazine/o command output
end
funcsave runner >/dev/null

function runner_kill
    set selected (ps -eo pid,command | zat --start 2 | string trim --left | fuzzel -d 2>/dev/null)
    for line in $selected
        kill (string match -gr '^(\\d+)' $line)
    end
end
funcsave runner_kill >/dev/null

function runner_math
    set -l result (cat ~/.cache/mine/runner-math | fuzzel -dl 1 2>/dev/null)
    test $status -ne 0 && return 1
    test "$result" || return 1
    set -l result (qalc -t --set 'save mode no' --set 'syntax 4' -- $result | tee ~/.cache/mine/runner-math ~/.local/share/magazine/o)
    notify-send -t 0 $result
    echo | qalc --set 'save mode yes'
end
funcsave runner_math >/dev/null

function runner_symbol
    set input (fuzzel -dl 0 2>/dev/null)
    test $status -eq 1 && return 1
    not test "$input" && return 1
    set output ''
    for code in (string split ' ' $input)
        set output $output"\U$code"
    end
    printf $output 2>/dev/null | copy
end
funcsave runner_symbol >/dev/null

function runner_symbol_name
    set input (cat ~/.local/share/magazine/E | fuzzel -d --match-mode exact --cache ~/.cache/mine/runner-symbol-name 2>/dev/null)
    test $status -eq 1 && return 1
    not test "$input" && return 1
    printf '\U'(string pad --char 0 --width 8 (string split ' ' $input)[1]) 2>/dev/null | copy
end
funcsave runner_symbol_name >/dev/null

function runner_link
    set file ~/.local/share/magazine/l
    set result (cat $file | sd ' — .+$' '' | fuzzel -d --index --cache ~/.cache/mine/runner-link 2>/dev/null)
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
        set input (fuzzel -dl 0 2>/dev/null)
        set -l result $status
        if test $result -eq 10
            set do_it_again true
        else if test $result -ne 0
            return 1
        end
        notify-send -t 0 -- "$input"
        echo "$input" >~/.local/share/magazine/o
        _magazine_commit ~/.local/share/magazine/o notif
    end
end
funcsave runner_notification >/dev/null

function runner_interactive_unicode
    set input (cat ~/.local/share/magazine/e | fuzzel -d --cache ~/.cache/mine/runner-interactive-unicode 2>/dev/null)
    test $status -ne 0 && return 1
    echo (string split ' ' $input[1])[1] | copy
end
funcsave runner_interactive_unicode >/dev/null
