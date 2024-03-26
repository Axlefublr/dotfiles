#!/usr/bin/env fish

function runner
    set cmd (rofi -input ~/prog/dotfiles/data/likely.fish -dmenu 2> /dev/null | string collect)
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

function runner_math
    set input (rofi -dmenu 2> /dev/null ; echo $status)
    if test $input[-1] -ne 0
        return 1
    end
    set -e input[-1]
    set input (string collect $input)
    if test -n $input
        set result (math "$input" | string collect)
        notify-send -t 3000 $result
        echo $result | xclip -selection clipboard -r
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

function runner_clipster
    set items
    clipster -co0n 0 | while read -z item
        set items $items $item
    end
    set rofified
    set index 0
    for item in $items
        set index (math $index + 1)
        set -l has_newlines ''
        if string match -qr '\\n' $item
            set has_newlines '⏎'
        end
        set rofified $rofified $index\ (string match -gr '^[\\t ]*([^\\n]*).*' $item)$has_newlines
    end
    set picked (prli $rofified | rofi -dmenu 2> /dev/null ; echo $status)
    if test $picked[-1] -ne 0
        return 1
    end
    set -e picked[-1]
    if test -z $picked
        return 1
    end
    set index (string match -r '^\\d+' $picked)
    if test -n $index
        echo $items[$index] | xclip -selection clipboard -r
    end
end
funcsave runner_clipster >/dev/null

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
    set text (cat ~/.local/share/magazine/$argv[1] | string collect)
    if test -z $text
        notify-send -t 1000 "register $argv[1] is empty"
    else
        notify-send -t 0 -- $text
    end
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
    set lines (cat ~/.local/share/magazine/$argv[1])
    set lines $lines $result
    prli $lines >~/.local/share/magazine/$argv[1]
    notify-send -t 1000 "append $argv[1]"
    update_magazine $argv[1]
end
funcsave magazine_append >/dev/null

function magazine_appset
    set lines (cat ~/.local/share/magazine/$argv[1])
    set lines $lines "$(xclip -selection clipboard -o)"
    prli $lines >~/.local/share/magazine/$argv[1]
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

function update_magazine
    if test $argv[1] -ge 0 -a $argv[1] -le 9
        awesome-client 'Registers_wu()'
    end
end
funcsave update_magazine >/dev/null

function runner_bluetooth
    set options ''
    set power (get_bluetooth)
    if test "$power" = yes
        set options '󰐥 on'
    else if test "$power" = no
        set options '󰐥 off'
    end
    set headphones (get_bluetooth_connected_device $head)
    if test "$headphones" = yes
        set options $options ' head'
    else if test "$headphones" = no
        set options $options ' head'
    end
    set earphones (get_bluetooth_connected_device $ear)
    if test "$earphones" = yes
        set options $options ' ear'
    else if test "$earphones" = no
        set options $options ' ear'
    end
    set speaker (get_bluetooth_connected_device $speaker)
    if test "$speaker" = yes
        set options $options ' speaker'
    else if test "$speaker" = no
        set options $options ' speaker'
    end
    set result (prli $options | rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    switch $result
        case '󰐥 on'
            bluetoothctl power off 2>>/dev/shm/user_log.txt
        case '󰐥 off'
            bluetoothctl power on 2>>/dev/shm/user_log.txt
        case ' head'
            bluetoothctl disconnect $head 2>>/dev/shm/user_log.txt
        case ' head'
            bluetoothctl connect $head 2>>/dev/shm/user_log.txt
        case ' ear'
            bluetoothctl disconnect $ear 2>>/dev/shm/user_log.txt
        case ' ear'
            bluetoothctl connect $ear 2>>/dev/shm/user_log.txt
        case ' speaker'
            bluetoothctl disconnect $speaker 2>>/dev/shm/user_log.txt
        case ' speaker'
            bluetoothctl connect $speaker 2>>/dev/shm/user_log.txt
    end
    widget_update update_bluetooth Bluetooth
end
funcsave runner_bluetooth >/dev/null
