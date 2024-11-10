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
    xclip -selection clipboard -o >$argv[1].png
end
funcsave imgs >/dev/null

function vids
    cp -f ~/vid/rec.mp4 $argv[1].mp4
end
funcsave vids >/dev/null

function ocr
    tesseract $argv - 2>/dev/null
end
funcsave ocr >/dev/null

alias --save dedup 'awk \'!seen[$0]++\'' >/dev/null

function m
    set harp (harp get harp_dirs $argv --path | string replace '~' $HOME)
    if test "$harp"
        z "$harp"
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
    scratchpad --wintitle=line helix $argv
end
funcsave neoline >/dev/null

function neoline_hold
    neoline $argv
    win_wait 'kitty\\.kitty — line'
    win_wait_closed 'kitty\\.kitty — line'
end
funcsave neoline_hold >/dev/null

function neomax
    scratchpad --wintitle=max helix $argv
end
funcsave neomax >/dev/null

function neomax_hold
    neomax $argv
    win_wait 'kitty\\.kitty — max'
    win_wait_closed 'kitty\\.kitty — max'
end
funcsave neomax_hold >/dev/null

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
    test "$_flag_wintitle" && set -l wintitle --os-window-title $_flag_wintitle
    kitten @ --to unix:(fd kitty_instance /tmp | head -n 1) launch --cwd $cwd --type os-window $wintitle --no-response $argv
end
funcsave scratchpad >/dev/null

function _?
    if status is-interactive
        command $argv --help &| helix -c ~/prog/dotfiles/helix/man.toml
    else
        command $argv --help
    end
end
funcsave _? >/dev/null

function _%
    if status is-interactive
        man $argv 2>/dev/null | helix -c ~/prog/dotfiles/helix/man.toml
    else
        man $argv
    end
end
funcsave _% >/dev/null

function ?
    set -l helppage $argv
    if not test "$helppage"
        set helppage (ypoc)
    end
    if builtin -q $helppage[1]
        _% $helppage
        return
    end
    # doesn't try to fall back on manpages because some programs output a help page *and* set a non-zero statuscode
    # I don't know of a general way to check whether --help exists or not, considering that
    _? $helppage
end
funcsave ? >/dev/null

function %
    set -l manpage $argv
    if not test "$manpage"
        set manpage (ypoc)
    end
    man --where $manpage &>/dev/null
    if test $status -eq 16 # 16 means "manpage not found"
        _? $manpage
        return
    end
    _% $manpage
end
funcsave % >/dev/null
