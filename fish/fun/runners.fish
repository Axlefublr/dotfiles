#!/usr/bin/env fish

function runner
    set preset ~/.local/share/magazine/L
    set histori ~/.local/share/magazine/H
    truncate -s 0 /dev/shm/runner_input
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
    end | rofi -dmenu 2>/dev/null >/dev/shm/runner_input
    indeed $histori (cat /dev/shm/runner_input)
    if set -q argv[1]
        set output "$(source /dev/shm/runner_input &| tee ~/.local/share/magazine/o)"
        notify-send -t 2000 "$output"
    else
        source /dev/shm/runner_input
    end
    if rg '^at play' /dev/shm/runner_input
        loago do liked
        widget_update mature_tasks_line Loago
    end
    if rg '^loago do' /dev/shm/runner_input
        widget_update mature_tasks_line Loago
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
    set input (rofi -dmenu 2> /dev/null ; echo $status)
    test $input[-1] -ne 0 && return 1 || set -e input[-1]
    test $input || return 1
    set result (math $input)
    notify-send -t 0 $result
    echo $result >~/.local/share/magazine/o
    echo $result | copy
    _magazine_commit ~/.local/share/magazine/o math
end
funcsave runner_math >/dev/null

function runner_symbol
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    if test -z $result
        return 1
    end
    set output ''
    for code in (string split ' ' $result)
        set output $output"\U$code"
    end
    printf $output 2>/dev/null | xclip -r -selection clipboard
    xdotool key ctrl+v
end
funcsave runner_symbol >/dev/null

function runner_symbol_name
    set result (rofi -input ~/.local/share/magazine/E -sync -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    if test -z $result
        return 1
    end
    printf '\U'(string pad --char 0 --width 8 (string split ' ' $result)[1]) 2>/dev/null | xclip -r -selection clipboard
end
funcsave runner_symbol_name >/dev/null

function runner_doc
    function named_html
        for entry in (fd -e html . ~/docs/$argv[1] | path basename | path change-extension '')
            echo $argv[2..] $entry
        end
    end
    function named_directory
        for entry in (fd -e html . ~/docs/$argv[1] | path dirname | path basename)
            echo $argv[2..] $entry
        end
    end
    set result (begin
        ls ~/docs
        named_html 'fish/cmds' fish
        named_html 'awm/awesomewm.org/doc/api/classes' awm class
        named_html 'awm/awesomewm.org/doc/api/libraries' awm lib
        named_directory 'kitty/sw.kovidgoyal.net/kitty' kitty
    end | rofi -dmenu 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return 1 || set -e result[-1]
    ensure_browser main
    set last_element (string split ' ' $result)[-1]
    switch $result
        case 'awm lib *'
            $BROWSER ~/docs/awm/awesomewm.org/doc/api/libraries/$last_element.html
        case 'awm class *'
            $BROWSER ~/docs/awm/awesomewm.org/doc/api/classes/$last_element.html
        case 'fish *'
            $BROWSER ~/docs/fish/cmds/$last_element.html
        case 'kitty *'
            $BROWSER ~/docs/kitty/sw.kovidgoyal.net/kitty/$last_element/index.html
        case '*.pdf'
            zathura "~/docs/$result" & disown
        case '*'
            $BROWSER "~/docs/$result/index.html"
    end
end
funcsave runner_doc >/dev/null

function runner_link
    set file ~/.local/share/magazine/l
    set result (cat $file | sd ' — .+$' '' | rofi -format 'i' -dmenu 2> /dev/null ; echo $status)
    test $result[-1] -eq 1 && return 1
    if test $result[-1] -eq 0
        ensure_browser main
    else if test $result[-1] -eq 10
        ensure_browser content
    end
    set -e result[-1]
    set line (math $result + 1)
    set link (awk "NR==$line { print \$NF }" $file)
    if test "$argv[1]"
        $BROWSER $link
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
        notify-send -t 0 "$result"
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
