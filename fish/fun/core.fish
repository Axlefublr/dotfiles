#!/usr/bin/env fish

function arebesties -a fileone filetwo
    test (stat -c %i $fileone) -eq (stat -c %i $filetwo)
end
funcsave arebesties >/dev/null

alias --save bell 'printf \a' >/dev/null

function blammo
    cat ~/.cache/mine/blammo 2>/dev/null
end
funcsave blammo >/dev/null

function catait
    inotifywait -e close_write -e close_nowrite $argv &>/dev/null
    cat $argv
end
funcsave catait >/dev/null

alias --save dedup 'awk \'!seen[$0]++\'' >/dev/null

function dof
    diff -u $argv | diff-so-fancy
end
funcsave dof >/dev/null

function dot
    echo dot >~/.local/share/mine/waybar-red-dot
end
funcsave dot >/dev/null

function ensure_browser
    na -c '
        niri msg -j windows
        | from json
        | where app_id == firefox
        | where is_focused == false
        | where workspace_id == 1
        | get id
        | try { first }
        | each { |$it|
        	niri msg action focus-window --id $it
        } | ignore
    '
end
funcsave ensure_browser >/dev/null

function flour
    argparse half pager disown sleek man -- $argv
    or return 121

    set -l title flour
    test "$_flag_half"
    and set title "$title-50%"

    test "$_flag_disown"
    and set flag_disown -N

    if test "$_flag_pager"
        set -f selected_config -c ~/fes/dot/helix/pager.toml
    else if test "$_flag_man"
        set -f selected_config -c ~/fes/dot/helix/man.toml
    else if test "$_flag_sleek"
        set -f selected_config -c ~/fes/dot/helix/sleek.toml
    end

    footclient -T $title $flag_disown -- helix $selected_config $execute_flag $argv
end
funcsave flour >/dev/null

function get_input
    set -l input (fuzzel -dl 0 2>/dev/null)
    test $status -ne 0 && return 1
    if test (string sub -s -2 -- $input) = '%%'
        string sub -e -2 -- $input >/tmp/mine/get-input.md
        flour --sleek /tmp/mine/get-input.md
        set input "$(cat /tmp/mine/get-input.md)"
    end
    echo $input
end
funcsave get_input >/dev/null

function get_input_max
    truncate -s 0 /tmp/mine/get-input.md
    flour --sleek /tmp/mine/get-input.md
    if test -s /tmp/mine/get-input.md
        cat /tmp/mine/get-input.md
    else
        return 1
    end
end
funcsave get_input_max >/dev/null

function gq
    set -l repo_root (git rev-parse --show-toplevel)
    if test $status -ne 0
        echo "you're not in a repo" >&2
        return 1
    end
    if test "$PWD" != "$repo_root"
        z $repo_root
    end
end
funcsave gq >/dev/null

function imgs
    wl-paste >$argv[1].png
end
funcsave imgs >/dev/null

function imgsw
    imgs $argv[1]
    magick $argv[1].png -define webp:lossless=true $argv[1].webp
    rm -f $argv[1].png
end
funcsave imgsw >/dev/null

function lnkj
    argparse c/confirm -- $argv
    or return 121
    set -l fileone $argv[1]
    set -l filetwo $argv[2]
    if not set -q fileone
        or not set -q filetwo
        echo 'missing arguments' >&2
        return 1
    end
    if not test -f $filetwo
        ln $fileone $filetwo
    else if not arebesties $fileone $filetwo
        confirm.rs "$filetwo is not a hardlink. make it be one?" '[j]es' '[k]o' '[c]opy over' | read -l response
        if test "$response" = j
            ln -f $fileone $filetwo
        else if test "$response" = c
            rm -f $filetwo
            cp -f $fileone $filetwo
        end
    else if not test "$_flag_confirm"
        confirm.rs "$fileone and $filetwo are besties." 'alrigh[j] then' '[c]opy over' | read -l response
        if test "$response" = c
            rm -f $filetwo
            cp -f $fileone $filetwo
        end
    end
end
funcsave lnkj >/dev/null

function mkcd
    mkdir -p $argv && z $argv
end
funcsave mkcd >/dev/null

function ocr
    tesseract $argv - 2>/dev/null
end
funcsave ocr >/dev/null

function path_expand
    string replace -r "^~" $HOME $argv
end
funcsave path_expand >/dev/null

function path_shrink
    string replace -r "^$HOME" '~' $argv
end
funcsave path_shrink >/dev/null

alias --save prli 'printf %s\n' >/dev/null
alias --save pwdb 'path basename (pwds)' >/dev/null
alias --save pwds 'path_shrink $PWD' >/dev/null

function rainbow
    set -l colors ea6962 e49641 d3ad5c a9b665 78bf84 7daea3 b58cc6 e491b2
    set -l index 1
    while read -l line
        set_color $colors[$index]
        echo $line
        set index (math $index + 1)
        if test $index -gt (count $colors)
            set index 1
        end
    end
    set_color normal
end
funcsave rainbow >/dev/null

function rename
    mv $argv[1] _$argv[1]
    mv _$argv[1] $argv[2]
end
funcsave rename >/dev/null

function sj
    for path in $argv
        path resolve $path
    end | wl-copy -n
end
funcsave sj >/dev/null

function task
    set mag 3
    argparse 'm/mag=' -- $argv
    and test "$_flag_mag"
    and set mag $_flag_mag
    indeed.rs -u ~/.local/share/magazine/$mag -- $argv
    _magazine_commit ~/.local/share/magazine/$mag task
end
funcsave task >/dev/null

function toggle_value
    argparse 'n/namespace=' -- $argv
    and test "$_flag_namespace"
    and set namespace $_flag_namespace
    or return 1
    set -l current (clorange $namespace increment)
    set -l index (math $current % (count $argv) + 1)
    echo $argv[$index]
end
funcsave toggle_value >/dev/null

function trail
    set -f modified_basename
    if set -q argv[3]
        set modified_basename (string replace -a '█' ($argv[3..] (path basename -E $argv[1])) $argv[2])
    else
        set modified_basename (string replace -a '█' (path basename -E $argv[1]) $argv[2])
    end
    echo (path dirname $argv[1])/$modified_basename(path extension $argv[1])
end
funcsave trail >/dev/null

function vids
    rsync ~/iwm/sco/original.mp4 $argv[1].mp4
end
funcsave vids >/dev/null

function vidsc
    rsync ~/iwm/sco/compressed.mp4 $argv[1].mp4
end
funcsave vidsc >/dev/null

function warn
    echo $argv >&2
end
funcsave warn >/dev/null

function webify
    for file in $argv
        not test -f $file && continue
        set -l webp_file (path change-extension '..webp' $file)
        magick -define webp:lossless=true $file $webp_file
        # not test -f $webp_file && continue
        # if test (stat -c %s $webp_file) -gt (stat -c %s $file)
        #     mv $webp_file (path change-extension '.heavier'(path extension $webp_file) $webp_file)
        # else
        #     mv $file (path change-extension '.heavier'(path extension $file) $file)
        # end
    end
end
funcsave webify >/dev/null
