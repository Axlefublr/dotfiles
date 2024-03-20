#!/usr/bin/env fish

function runner
    set cmd (rofi -input ~/prog/dotfiles/data/likely.txt -dmenu 2> /dev/null | string collect)
    if set -q argv[1]
        notify-send -t 0 (eval $cmd | string collect)
    else
        eval $cmd
    end
end
funcsave runner >/dev/null

function runner_kill
    set selected (ps -eo pid,command | zat --start 2 | string trim --left | rofi-multi-select 2> /dev/null)
    for line in $selected
        kill (string match -gr '^(\\d+)' $line)
    end
end
funcsave runner_kill >/dev/null

function runner_note
    set input (rofi -dmenu 2> /dev/null | string collect)
    indeed -- ~/prog/noties/notes.md $input
end
funcsave runner_note >/dev/null

function runner_math
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    set result (string collect $result)
    if test -n $result
        indeed -- ~/prog/noties/notes.md (cat ~/.local/share/notie)
        math "$result" 2>/dev/null >~/.local/share/notie
        awesome-client 'Note_wu()'
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
    cat ~/.local/share/magazine/$argv[1] | xclip -selection clipboard -r
    notify-send -t 1000 "get $argv[1]"
end
funcsave magazine_get >/dev/null

function magazine_set
    xclip -selection clipboard -o >~/.local/share/magazine/$argv[1]
    notify-send -t 1000 "set $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_set >/dev/null

function magazine_edit
    neoline ~/.local/share/magazine/$argv[1]
    update_magazine $argv[1]
end
funcsave magazine_edit >/dev/null

function magazine_view
    notify-send -t 0 (cat ~/.local/share/magazine/$argv[1] | string collect)
end
funcsave magazine_view >/dev/null

function magazine_truncate
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
    set result (string collect $result)
    truncate -s 0 ~/.local/share/magazine/$argv[1]
    if test -n $result
        indeed -- ~/.local/share/magazine/$argv[1] $result
    end
    notify-send -t 1000 "write $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_write >/dev/null

function update_magazine
    if test $argv[1] -ge 0 -a $argv[1] -le 9
        awesome-client 'Registers_wu()'
    end
end
funcsave update_magazine > /dev/null
