#!/usr/bin/env fish

function magazine_resolve_path
    if test "$(count $argv)" -ge 2
        path resolve $argv[-1]
        return
    end
    if test "$argv" = pjs
        set path (pick_project_path)
        if not test "$path"
            exit # this function is always used from the context of hotkeys, that do `fish -c`
        end
        echo $path
        return
    end
    echo ~/.local/share/magazine/$argv[-1]
end
funcsave magazine_resolve_path >/dev/null

function _magazine_notify
    if test "$argv[1]" = literal
        if test "$argv[2]" = ~/prog/dotfiles/project.txt # TODO: check if basename is project.txt
            notify-send -t 1000 "$argv[3..] pjs dotfiles"
        else
            notify-send -t 1000 "$argv[3..] $argv[2]"
        end
    else
        notify-send -t 1000 "$argv[2..] $argv[1]"
    end
end
funcsave _magazine_notify >/dev/null

function magazine_get
    set -f path (magazine_resolve_path $argv)
    magazine_view literal $path
    cat $path | xclip -selection clipboard -r
    _magazine_notify $argv get
end
funcsave magazine_get >/dev/null

function magazine_set
    set -f path (magazine_resolve_path $argv)
    cat $path >/tmp/magazine_$argv[1]
    xclip -selection clipboard -o >$path
    _magazine_notify $argv set
    update_magazine $argv
end
funcsave magazine_set >/dev/null

function magazine_edit
    set -f path (magazine_resolve_path $argv)
    cat $path >/tmp/magazine_$argv[1]
    neoline_hold $path
    update_magazine $argv
end
funcsave magazine_edit >/dev/null

function magazine_view
    set -f path (magazine_resolve_path $argv)
    set text "$(cat $path)"
    if not test "$text"
        _magazine_notify $argv empty
    else
        notify-send -t 3000 -- $text
    end
    update_magazine $argv
end
funcsave magazine_view >/dev/null

function magazine_truncate
    set -f path (magazine_resolve_path $argv)
    magazine_view literal $path
    cat $path >/tmp/magazine_$argv[1]
    truncate -s 0 $path
    _magazine_notify $argv truncate
    update_magazine $argv
end
funcsave magazine_truncate >/dev/null

function magazine_cut
    set -f path (magazine_resolve_path $argv)
    magazine_get literal $path
    magazine_truncate literal $path
end
funcsave magazine_cut >/dev/null

function magazine_write
    set -f path (magazine_resolve_path $argv)
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    cat $path >/tmp/magazine_$argv[1]
    printf "$result" >$path
    _magazine_notify $argv write
    update_magazine $argv
end
funcsave magazine_write >/dev/null

function magazine_append
    set -f path (magazine_resolve_path $argv)
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    set result "$result"
    indeed $path -- $result
    _magazine_notify $argv append
    update_magazine $argv
end
funcsave magazine_append >/dev/null

function magazine_appclip
    set -f path (magazine_resolve_path $argv)
    indeed $path "$(xclip -selection clipboard -o)"
    _magazine_notify $argv appclip
    update_magazine $argv
end
funcsave magazine_appclip >/dev/null

function magazine_filter
    set -f path (magazine_resolve_path $argv)
    set result (rofi_multi_select -input $path 2>/dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    for line in (cat $path)
        if contains "$line" $result
            continue
        end
        set collected $collected $line
    end
    cp -f $path /tmp/magazine_$argv[1]
    set multiline (printf '%s\n' $collected | string collect)
    echo -n $multiline >$path
    _magazine_notify $argv filter
    update_magazine $argv
end
funcsave magazine_filter >/dev/null

function magazine_restore
    if not set -q argv[1]
        echo please specify the register name >&2
        return 1
    end
    cp -f /tmp/magazine_$argv[1] ~/.local/share/magazine/$argv[1]
    if status is-interactive
        echo "restore $argv[1]"
    else
        _magazine_notify $argv restore
    end
    update_magazine $argv[1]
end
funcsave magazine_restore >/dev/null

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
    if test $argv[-1] -ge 0 -a $argv[-1] -le 9
        awesome-client 'Registers_wu()'
    end
end
funcsave update_magazine >/dev/null

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

function project_paths
    echo dotfiles
    for path in (ls -A ~/prog/proj)
        echo proj/$path
    end
    for path in (ls -A ~/prog/forks)
        echo forks/$path
    end
    for path in (ls -A ~/prog/stored)
        echo stored/$path
    end
end
funcsave project_paths >/dev/null

function pick_project_path
    echo ~/prog/(project_paths | rofi -dmenu 2>/dev/null)/project.txt
end
funcsave pick_project_path >/dev/null

function pjs
    begin
        set empties
        for file in (project_paths)
            set -l project_file_path ~/prog/$file/project.txt
            touch $project_file_path
            if test -s $project_file_path
                set_color '#e491b2'
                echo $file
                set_color normal
                echo "$(cat $project_file_path)"
                echo
            else
                set empties $empties $file
            end
        end
        for file in $empties
            set_color '#e491b2'
            printf '%s\n' $file
        end
    end | less
end
funcsave pjs >/dev/null
