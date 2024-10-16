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
    _magazine_update $argv
    _magazine_notify $argv set
    _magazine_commit $argv set
end
funcsave magazine_set >/dev/null

function magazine_edit
    not test "$argv" && return
    neoline_hold $argv
    _magazine_update $argv
    _magazine_commit $argv edit
end
funcsave magazine_edit >/dev/null

function magazine_truncate
    not test "$argv" && return
    truncate -s 0 $argv
    _magazine_update $argv
    _magazine_notify $argv truncate
    _magazine_commit $argv truncate
end
funcsave magazine_truncate >/dev/null

function magazine_write
    not test "$argv" && return
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return || set -e result[-1]
    echo "$result" >$argv
    _magazine_update $argv
    _magazine_notify $argv write
    _magazine_commit $argv write
end
funcsave magazine_write >/dev/null

function magazine_append
    not test "$argv" && return
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return || set -e result[-1]
    indeed -n $argv -- $result
    _magazine_update $argv
    _magazine_notify $argv append
    _magazine_commit $argv append
end
funcsave magazine_append >/dev/null

function magazine_appclip
    not test "$argv" && return
    indeed -n $argv -- "$(ypoc)"
    _magazine_update $argv
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
    _magazine_update $argv
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
    set result (rofi -dmenu 2>/dev/null ; echo $status)
    test $result[-1] -ne 0 && return || set -e result[-1]
    set link (ypoc)
    indeed -nu ~/.local/share/magazine/l "$result — $link"
    _magazine_commit ~/.local/share/magazine/l append
    notify-send -t 2000 "append link $link"
end
funcsave magazine_append_link >/dev/null

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
    set -f browser_window main
    if test "$(count $argv)" -ge 2
        set browser_window $argv[-1]
    end
    ensure_browser $browser_window
    $BROWSER $bookmark
end
funcsave bookmark_open >/dev/null

function bookmark_set
    harp update bookmarks $argv[1] --path $argv[2]
    notify-send -t 2000 "set bookmark $argv[1] to $argv[2]"
end
funcsave bookmark_set >/dev/null

#--------------------------------------------------internal--------------------------------------------------

function _magazine_notify
    set display (path basename $argv[1])
    if test $display = project.txt
        set display (path dirname $argv[1] | path basename)
    end
    notify-send -t 2000 "$argv[2..] $display"
end
funcsave _magazine_notify >/dev/null

function _magazine_update
    set -l mag (path basename $argv)
    if test $mag -ge 0 -a $mag -le 9
        awesome-client 'Registers_wu()'
    end
end
funcsave _magazine_update >/dev/null

function _magazine_commit
    set -l parent_path (path dirname $argv[1])
    set -l head (path basename $parent_path)
    set -l base (path basename $argv[1])
    set -l mag $base
    if string match $argv[1] (cat ~/.local/share/magazine/O | string replace -r '^~' "$HOME")
        or test $base = project.txt
        silly_sort.py $argv[1]
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
            touch $project_file_path
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
    end >/tmp/pjs
end
funcsave pjs >/dev/null
