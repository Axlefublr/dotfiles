#!/usr/bin/env fish

function gq
    set -l repo_root (git rev-parse --show-toplevel)
    if test $status -ne 0
        echo "you're not in a repo" >&2
        return 1
    end
    if test "$PWD" != "$repo_root"
        cd $repo_root
    end
end
funcsave gq >/dev/null

function arebesties -a fileone filetwo
    test (stat -c %i $fileone) -eq (stat -c %i $filetwo)
end
funcsave arebesties >/dev/null

function mkcd
    mkdir -p $argv && z $argv && clx
end
funcsave mkcd >/dev/null

function rename
    mv $argv[1] _$argv[1]
    mv _$argv[1] $argv[2]
end
funcsave rename >/dev/null

function imgs
    wl-paste >$argv[1].png
end
funcsave imgs >/dev/null

function imgsw
    imgs $argv[1]
    magick $argv[1].png $argv[1].webp
    rm -f $argv[1].png
end
funcsave imgsw >/dev/null

function vids
    cp -f ~/z.mp4 $argv[1].mp4
end
funcsave vids >/dev/null

function ocr
    tesseract $argv - 2>/dev/null
end
funcsave ocr >/dev/null

alias --save dedup 'awk \'!seen[$0]++\'' >/dev/null

function m
    for arg in $argv
        # if the arg starts with a dot, get from section harp_dirs_$PWD and remove the `.` at the start
        if test (string sub -l 1 $arg) = '.'
            set harp (harp get harp_dirs_$PWD (string sub -s 2 $arg) --path | string replace '~' $HOME)
            if test "$harp"
                z "$harp"
            end
        else
            set harp (harp get harp_dirs $arg --path | string replace '~' $HOME)
            if test "$harp"
                z "$harp"
            end
        end
    end
end
funcsave m >/dev/null

function M
    harp update harp_dirs $argv --path (string replace $HOME '~' $PWD)
    and echo "bookmark $argv set"
end
funcsave M >/dev/null

function yazi-cd
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        z $cwd
    end
    commandline -f repaint
    rm -f -- "$tmp"
end
funcsave yazi-cd >/dev/null

function neoline
    scratchpad --wintitle=line -- helix -c ~/r/dot/helix/quit.toml $argv
end
funcsave neoline >/dev/null

function neoline-hold
    neoline $argv
    win_wait 'Title: "line";App ID: "kitty"' 0.05 >/dev/null
    win_wait_closed 'Title: "line";App ID: "kitty"' 0.05 >/dev/null
end
funcsave neoline-hold >/dev/null

function neomax
    scratchpad --wintitle=max -- helix -c ~/r/dot/helix/quit.toml $argv
end
funcsave neomax >/dev/null

function neomax-hold
    neomax $argv
    win_wait 'Title: "max";App ID: "kitty"' 0.05 >/dev/null
    win_wait_closed 'Title: "max";App ID: "kitty"' 0.05 >/dev/null
end
funcsave neomax-hold >/dev/null

function clx
    if test "$TERM" != xterm-kitty
        clear -x
    else
        printf '\e[H\e[22J'
    end
end
funcsave clx >/dev/null

function eat
    loago do eat
    notify-send -t 2000 'ate!'
end
funcsave eat >/dev/null

function task
    set mag 3
    argparse 'm/mag=' -- $argv
    and test "$_flag_mag"
    and set mag $_flag_mag
    indeed -u ~/.local/share/magazine/$mag -- $argv
    _magazine_commit ~/.local/share/magazine/$mag task
end
funcsave task >/dev/null

function win
    argparse -i cwd= -- $argv || return 1
    test "$_flag_cwd" && set -l cwd $_flag_cwd || set -l cwd current
    kitten @ launch --type window --cwd $cwd $argv &>/dev/null
end
funcsave win >/dev/null

function over
    argparse -i cwd= -- $argv || return 1
    test "$_flag_cwd" && set -l cwd $_flag_cwd || set -l cwd current
    kitten @ launch --type overlay-main --cwd $cwd $argv &>/dev/null
end
funcsave over >/dev/null

function os
    argparse -i cwd= -- $argv || return 1
    test "$_flag_cwd" && set -l cwd $_flag_cwd || set -l cwd current
    kitten @ launch --type os-window --cwd $cwd $argv &>/dev/null
end
funcsave os >/dev/null

function tab
    argparse -i cwd= -- $argv || return 1
    test "$_flag_cwd" && set -l cwd $_flag_cwd || set -l cwd current
    kitten @ launch --type tab --cwd $cwd $argv &>/dev/null
end
funcsave tab >/dev/null

function scratchpad
    argparse -i cwd= wintitle= -- $argv || return 1
    test "$_flag_cwd" && set -l cwd $_flag_cwd || set -l cwd current
    test "$_flag_wintitle" && set -l wintitle --os-window-title $_flag_wintitle || set -l wintitle --os-window-title scratchpad
    kitten @ --to unix:(fd kitty_instance /tmp | head -n 1) launch --cwd $cwd --type os-window $wintitle --no-response $argv &>/dev/null
end
funcsave scratchpad >/dev/null
alias --save int scratchpad >/dev/null

function scratchkitty
    pgrep kitty &>/dev/null && scratchpad --hold --cwd ~ || kitty
end
funcsave scratchkitty >/dev/null

function get-input
    set -l input (fuzzel -dl 0 2>/dev/null)
    test $status -eq 1 && return 1
    if test (string sub -s -2 -- $input) = '%%'
        string sub -e -2 -- $input >~/.cache/mine/get-input
        neomax-hold "~/.cache/mine/get-input$(calculate-eof-position ~/.cache/mine/get-input)"
        set input "$(cat ~/.cache/mine/get-input)"
    end
    echo $input
end
funcsave get-input >/dev/null

function f
    if set -q argv
        fg %(velvidek.rs $argv)
    else
        fg
    end
end
funcsave f >/dev/null

function b
    if set -q argv
        bg %(velvidek.rs $argv)
    else
        bg
    end
end
funcsave b >/dev/null

function cwd
    echo $PWD | copy
end
funcsave cwd >/dev/null
