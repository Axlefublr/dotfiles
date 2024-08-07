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
    if test $input[-1] -ne 0
        return 1
    end
    set -e input[-1]
    set input (string collect $input)
    if test -n $input
        set result (math "$input" | string collect)
        notify-send -t 2000 $result
        echo $result >~/.local/share/magazine/o
    end
end
funcsave runner_math >/dev/null

function runner_clipboard
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    string collect $result | xclip -selection clipboard -r
end
funcsave runner_clipboard >/dev/null

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
        set output $output'\U'(string pad --char 0 --width 8 $code)
    end
    printf $output 2>/dev/null | xclip -r -selection clipboard
end
funcsave runner_symbol >/dev/null

function runner_symbol_name
    set result (rofi -input ~/prog/backup/unicodes.txt -sync -dmenu 2> /dev/null ; echo $status)
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

function magazine_get
    magazine_view $argv[1] 2000
    cat ~/.local/share/magazine/$argv[1] | xclip -selection clipboard -r
    notify-send -t 1000 "get $argv[1]"
end
funcsave magazine_get >/dev/null

function magazine_set
    cat ~/.local/share/magazine/$argv[1] >/tmp/magazine_$argv[1]
    xclip -selection clipboard -o >~/.local/share/magazine/$argv[1]
    notify-send -t 1000 "set $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_set >/dev/null

function magazine_edit
    cat ~/.local/share/magazine/$argv[1] >/tmp/magazine_$argv[1]
    neoline ~/.local/share/magazine/$argv[1]
    update_magazine $argv[1]
end
funcsave magazine_edit >/dev/null

function magazine_view
    set text (cat ~/.local/share/magazine/$argv[1] | string collect)
    if test -z $text
        notify-send -t 1000 "register $argv[1] is empty"
    else
        notify-send -t (test "$argv[2]" && printf "$argv[2]" || printf 0) -- $text
    end
    update_magazine $argv[1]
end
funcsave magazine_view >/dev/null

function magazine_truncate
    magazine_view $argv[1] 3000
    cat ~/.local/share/magazine/$argv[1] >/tmp/magazine_$argv[1]
    truncate -s 0 ~/.local/share/magazine/$argv[1]
    notify-send -t 1000 "truncate $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_truncate >/dev/null

function magazine_cut
    magazine_get $argv[1]
    magazine_truncate $argv[1]
end
funcsave magazine_cut >/dev/null

function magazine_write
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    cat ~/.local/share/magazine/$argv[1] >/tmp/magazine_$argv[1]
    printf "$result" >~/.local/share/magazine/$argv[1]
    notify-send -t 1000 "write $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_write >/dev/null

function magazine_append
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    set result "$result"
    indeed ~/.local/share/magazine/$argv[1] -- $result
    notify-send -t 1000 "append $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_append >/dev/null

function magazine_append_link
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    set result "$result"
    set link (xclip -selection clipboard -o)
    indeed -u ~/.local/share/magazine/l "$result — $link"\n
    silly_sort.py ~/.local/share/magazine/l
    notify-send -t 2000 "append l with $link"
end
funcsave magazine_append_link >/dev/null

function magazine_appset
    indeed ~/.local/share/magazine/$argv[1] "$(xclip -selection clipboard -o)"
    notify-send -t 1000 "append clip $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_appset >/dev/null

function magazine_filled
    set registers ''
    for file in ~/.local/share/magazine/*
        if test -s $file
            set registers $registers(basename $file)
        end
    end
    notify-send -t 0 $registers
end
funcsave magazine_filled >/dev/null

function magazine_restore
    if not set -q argv[1]
        echo please specify the register name >&2
        return 1
    end
    cp -f /tmp/magazine_$argv[1] ~/.local/share/magazine/$argv[1]
    if status is-interactive
        echo "restore $argv[1]"
    else
        notify-send -t 1000 "restore $argv[1]"
    end
    update_magazine $argv[1]
end
funcsave magazine_restore >/dev/null

function magazine_filter
    set result (rofi_multi_select -input ~/.local/share/magazine/$argv[1] 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    set file_path ~/.local/share/magazine/$argv[1]
    for line in (cat $file_path)
        if contains "$line" $result
            continue
        end
        set collected $collected $line
    end
    cp -f $file_path /tmp/magazine_$argv[1]
    set multiline (printf '%s\n' $collected | string collect)
    echo -n $multiline >$file_path
    notify-send -t 1000 "filter $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_filter >/dev/null

function update_magazine
    if test $argv[1] -ge 0 -a $argv[1] -le 9
        awesome-client 'Registers_wu()'
    end
end
funcsave update_magazine >/dev/null

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
    if test $result[-1] -ne 0
        return 1
    end
    if test "$argv"
        wmctrl -s $argv
    end
    set -e result[-1]
    set result "$result"
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
    if test $result[-1] -ne 0
        return 1
    end
    wmctrl -s $argv[1]
    set -e result[-1]
    set line (math $result + 1)
    set link (awk "NR==$line { print \$NF }" $file)
    if test "$argv[2]"
        $BROWSER $link
    else
        echo $link | xclip -r -selection clipboard
        notify-send -t 2000 "copied link: $link"
    end
end
funcsave runner_link >/dev/null

function pjs
    begin
        set empties
        for file in (fd -utf project.txt ~/prog)
            set pretty_file (string replace "$HOME" '~' $file)
            if test -s $file
                echo $pretty_file
                cat $file
                echo
            else
                set empties $empties $pretty_file
            end
        end
        printf '%s\n' $empties
    end >/tmp/pjs
end
funcsave pjs >/dev/null

function runner_notification
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    notify-send -t 0 "$result"
end
funcsave runner_notification >/dev/null
