#!/usr/bin/env fish

# -----------------classical------------------

function magazine_resolve
    not test "$argv" && return
    set -l path $argv
    set -l action (cat /tmp/mine/magazine-action)
    test $status -ne 0 && return
    test "$action" || return

    if test $action = truncate && test $path = A
        magazine_truncate_imports
        return
    end

    if test $action = append
        if test $path = e
            magazine_append_symbol
            return
        else if test $path = l
            magazine_append_link
            return
        end
    end

    if test $path = j
        set path ~/fes/dot/project.txt
    else if test $path = k
        switch $action
            case get cut truncate randomize filter copy
                set path (pick_project_path -e)
            case '*'
                set path (pick_project_path)
        end
        not test "$path" && return
    else
        set path ~/.local/share/magazine/$path
    end
    magazine_$action $path
end
funcsave magazine_resolve >/dev/null

function magazine_get
    not test "$argv" && return
    cat $argv | wl-copy -n
    _magazine_notify $argv get
end
funcsave magazine_get >/dev/null

function magazine_set
    not test "$argv" && return
    wl-paste -n >$argv
    _magazine_notify $argv set
    _magazine_commit $argv set
end
funcsave magazine_set >/dev/null

function magazine_edit
    not test "$argv" && return
    flour $argv
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
    set -l result (get_input)
    test $status -ne 0 && return
    test "$result" || return
    echo "$result" >$argv
    _magazine_notify $argv write
    _magazine_commit $argv write
end
funcsave magazine_write >/dev/null

function magazine_append
    not test "$argv" && return
    set -l result (get_input)
    test $status -ne 0 && return
    test "$result" || return
    indeed.rs $argv -- $result
    _magazine_notify $argv append
    _magazine_commit $argv append
end
funcsave magazine_append >/dev/null

function magazine_appclip
    not test "$argv" && return
    indeed.rs $argv -- "$(wl-paste -n)"
    _magazine_notify $argv appclip
    _magazine_commit $argv appclip
end
funcsave magazine_appclip >/dev/null

function magazine_filter
    not test "$argv" && return
    set result (cat $argv | fuzzel -d --index 2>/dev/null)
    test $status -ne 0 && return 1
    zat.rs $argv ,$result | wl-copy -n
    zat.rs $argv ,^$result .. | sponge $argv
    _magazine_notify $argv filter
    _magazine_commit $argv filter
end
funcsave magazine_filter >/dev/null

function magazine_copy
    not test "$argv" && return
    set input (cat $argv | fuzzel -d 2>/dev/null)
    test $status -ne 0 && return 1
    echo $input | wl-copy -n
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

function magazine_novel
    not test "$argv" && return
    set -l result (get_input_max)
    test $status -ne 0 && return
    test "$result" || return
    indeed.rs $argv -- $result
    _magazine_notify $argv novel
    _magazine_commit $argv novel
end
funcsave magazine_novel >/dev/null

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
    set -l result "$(get_input)"
    test $status -eq 1 && return
    set link (wl-paste -n)
    indeed.rs -u ~/.local/share/magazine/l -- "$result — $link"
    _magazine_commit ~/.local/share/magazine/l append
    notify-send -t 2000 "append link $link"
end
funcsave magazine_append_link >/dev/null

function magazine_append_symbol
    set symbol_name (fuzzel -dl 0 2>/dev/null)
    test $status -ne 0 && return 1
    set symbol_text (wl-paste -n)
    indeed.rs -u ~/.local/share/magazine/e -- (begin
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

function magazine_count_anki_cards
    not test "$argv" && return
    _magazine_notify $argv count "$(math $(wc -l $argv | string split ' ')[1] - 3)"
end
funcsave magazine_count_anki_cards >/dev/null

#--------------------------------------------not really magazines--------------------------------------------

function bookmark_open
    set -l bookmark (harp get bookmarks $argv[1])
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
    harp replace bookmarks $argv[1] $argv[2]
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

function _magazine_commit
    not test -f $argv[1] && return
    set -l resolved (path resolve $argv[1])
    set -l parent_path (path dirname $resolved)
    set -l head (path basename $parent_path)
    set -l base (path basename $resolved)
    set -l mag $base
    if test -s $resolved && test (tail -c 1 $resolved) != (echo)
        echo >>$resolved
    end
    if string match $resolved (cat ~/.local/share/magazine/R | string replace -r '^~' "$HOME")
        or test $base = project.txt
        sort.py -u $resolved
    else if string match $resolved (cat ~/.local/share/magazine/Q | string replace -r '^~' "$HOME")
        cat $resolved | dedup | sponge $resolved
    end
    if test $parent_path != ~/.local/share/magazine
        if test $base = project.txt
            cp -f $resolved ~/.local/share/magazine/$head
            set mag $head
        else
            cp -f $resolved ~/.local/share/magazine
        end
    end
    builtin cd ~/.local/share/magazine
    git add $mag
    and git commit -m "$argv[2..] $mag"
end
funcsave _magazine_commit >/dev/null

# -----------------projectual-----------------

alias --save talia-set 'taliaprojecxsrs ~/fes/ork ~/fes/lai' >/dev/null
alias --save talia 'talia-set -ieb | ov --section-header --status-line=false --section-delimiter ":\\$"' >/dev/null

function pick_project_path
    echo ~/fes/(talia-set $argv | fuzzel -d 2>/dev/null)/project.txt
end
funcsave pick_project_path >/dev/null
