#!/usr/bin/env fish

#--------------------------------------------------classical--------------------------------------------------

function magazine_get
    not test "$argv" && return
    cat $argv | copy
    _magazine_notify $argv get
end
funcsave magazine_get >/dev/null

function magazine_set
    not test "$argv" && return
    ypoc >$argv
    _magazine_notify $argv set
    _magazine_commit $argv set
end
funcsave magazine_set >/dev/null

function magazine_edit
    not test "$argv" && return
    neomax_hold $argv
    _magazine_commit $argv edit
end
funcsave magazine_edit >/dev/null

function magazine_truncate
    not test "$argv" && return
    truncate -s 0 $argv
    _magazine_notify $argv truncate
    _magazine_commit $argv truncate
end
funcsave magazine_truncate >/dev/null

function magazine_write
    not test "$argv" && return
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return || set -e result[-1]
    echo "$result" >$argv
    _magazine_notify $argv write
    _magazine_commit $argv write
end
funcsave magazine_write >/dev/null

function magazine_append
    not test "$argv" && return
    set -l result "$(get-input)"
    test $status -eq 1 && return
    indeed -n $argv -- $result
    _magazine_notify $argv append
    _magazine_commit $argv append
end
funcsave magazine_append >/dev/null

function magazine_appclip
    not test "$argv" && return
    indeed -n $argv -- "$(ypoc)"
    _magazine_notify $argv appclip
    _magazine_commit $argv appclip
end
funcsave magazine_appclip >/dev/null

function magazine_filter
    not test "$argv" && return
    set result (rofi_multi_select -input $argv 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return || set -e result[-1]
    echo $result | copy
    for line in (cat $argv)
        if contains "$line" $result
            continue
        end
        set collected $collected $line
    end
    set multiline (printf '%s\n' $collected | string collect)
    echo $multiline >$argv
    _magazine_notify $argv filter
    _magazine_commit $argv filter
end
funcsave magazine_filter >/dev/null

function magazine_copy
    not test "$argv" && return
    set result (rofi_multi_select -input $argv 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return || set -e result[-1]
    echo $result | copy
end
funcsave magazine_copy >/dev/null

function magazine_randomize
    not test "$argv" && return
    shuf $argv | sponge $argv
    _magazine_notify $argv random
    _magazine_commit $argv random
end
funcsave magazine_randomize >/dev/null

function magazine_reverse
    not test "$argv" && return
    tac $argv | sponge $argv
    _magazine_notify $argv reverse
    _magazine_commit $argv reverse
end
funcsave magazine_reverse >/dev/null

#-------------------------------------------------combinatory-------------------------------------------------

function magazine_cut
    magazine_get $argv
    magazine_truncate $argv
end
funcsave magazine_cut >/dev/null

function magazine_commit
    _magazine_notify $argv commit
    _magazine_commit $argv commit
end
funcsave magazine_commit >/dev/null

#---------------------------------------------------special---------------------------------------------------

function magazine_append_link
    set -l result "$(get-input)"
    test $status -eq 1 && return
    set link (ypoc)
    indeed -nu ~/.local/share/magazine/l -- "$result — $link"
    _magazine_commit ~/.local/share/magazine/l append
    notify-send -t 2000 "append link $link"
end
funcsave magazine_append_link >/dev/null

function magazine_append_symbol
    set symbol_name (rofi -dmenu 2>/dev/null)
    test $status -ne 0 && return 1
    set symbol_text (ypoc)
    indeed -nu ~/.local/share/magazine/e -- (begin
        echo -n $symbol_text' '
        for thingy in (string split '' $symbol_text)
            printf '%x ' \'$thingy
        end
        echo -n $symbol_name
    end)
    _magazine_commit ~/.local/share/magazine/e append
    notify-send -t 2000 "append symbol $symbol_text"
end
funcsave magazine_append_symbol >/dev/null

function magazine_truncate_imports
    set -l file_path ~/.local/share/magazine/A
    set -l cards (tail -n +4 ~/.local/share/magazine/A | wc -l)
    notify-send -t 3000 $cards
    head -n 3 $file_path | sponge $file_path
    _magazine_notify $file_path import
    _magazine_commit $file_path import
end
funcsave magazine_truncate_imports >/dev/null

function magazine_client_info
    awesome-client 'WriteClientInfo()'
    _magazine_commit ~/.local/share/magazine/o clients
end
funcsave magazine_client_info >/dev/null

#--------------------------------------------not really magazines--------------------------------------------

function bookmark_open
    set -l bookmark (harp get bookmarks $argv[1] --path)
    not test "$bookmark"
    and begin
        notify-send -t 2000 "bookmark $argv[1] doesn't exist"
        return 1
    end
    $BROWSER $bookmark
    ensure_browser
end
funcsave bookmark_open >/dev/null

function bookmark_set
    harp update bookmarks $argv[1] --path $argv[2]
    notify-send -t 2000 "set bookmark $argv[1] to $argv[2]"
end
funcsave bookmark_set >/dev/null

function clipboard_harp_get -a register
    set output (harp get clipboard $register --extra)
    if not test $status -eq 0
        notify-send -t 2000 "clipboard harp $register is unset"
        return 1
    end
    echo "$output[1]" | copy
    xdotool key ctrl+v
end
funcsave clipboard_harp_get >/dev/null

function clipboard_harp_set -a register
    harp update clipboard $register --extra "$(ypoc)"
    notify-send -t 2000 "set clipboard harp $register"
end
funcsave clipboard_harp_set >/dev/null

#--------------------------------------------------internal--------------------------------------------------

function _magazine_notify
    set display (path basename $argv[1])
    if test $display = project.txt
        set display (path dirname $argv[1] | path basename)
    end
    notify-send -t 2000 "$argv[2..] $display"
end
funcsave _magazine_notify >/dev/null

function _magazine_commit
    not test -f $argv[1] && return
    set -l parent_path (path dirname $argv[1])
    set -l head (path basename $parent_path)
    set -l base (path basename $argv[1])
    set -l mag $base
    if string match $argv[1] (cat ~/.local/share/magazine/O | string replace -r '^~' "$HOME")
        or test $base = project.txt
        sort.py -u $argv[1]
    else if string match $argv[1] (cat ~/.local/share/magazine/P | string replace -r '^~' "$HOME")
        cat $argv[1] | dedup | sponge $argv[1]
    end
    if test $parent_path != ~/.local/share/magazine
        if test $base = project.txt
            cp -f $argv[1] ~/.local/share/magazine/$head
            set mag $head
        else
            cp -f $argv[1] ~/.local/share/magazine
        end
    end
    cd ~/.local/share/magazine
    git add $mag
    and git commit -m "$argv[2..] $mag"
end
funcsave _magazine_commit >/dev/null

#-------------------------------------------------projectual-------------------------------------------------

function project_paths
    for path in (ls -A ~/prog/proj)
        echo proj/$path
    end
    for path in (ls -A ~/prog/forks)
        echo forks/$path
    end
    # for path in (ls -A ~/prog/stored)
    #     echo stored/$path
    # end
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
            not test -f $project_file_path && touch $project_file_path
            if test -s $project_file_path
                # set_color '#e491b2'
                echo '~/prog/'$file
                # set_color normal
                echo "$(cat $project_file_path)"
                echo
            else
                set empties $empties $file
            end
        end
        for file in $empties
            # set_color '#e491b2'
            printf '%s\n' $file
        end
    end >~/bs/pjs
end
funcsave pjs >/dev/null
