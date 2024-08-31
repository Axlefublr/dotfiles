#!/usr/bin/env fish

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

function m
    set harp (harp get cd_harps $argv --path | string replace '~' $HOME)
    if test "$harp"
        z "$harp"
    end
end
funcsave m >/dev/null

function M
    harp update cd_harps $argv --path (string replace $HOME '~' $PWD)
    and echo "bookmark $argv set"
end
funcsave M >/dev/null

function l
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        z $cwd
    end
    commandline -f repaint
    rm -f -- "$tmp"
end
funcsave l >/dev/null

function neoline
    kitten @ --to unix:(fd kitty_instance /tmp | head -n 1) launch --type os-window --os-window-title neoline --no-response helix $argv
end
funcsave neoline >/dev/null

function neoline_hold
    neoline $argv
    win_wait 'kitty\\.kitty — neoline'
    win_wait_closed 'kitty\\.kitty — neoline'
end
funcsave neoline_hold >/dev/null

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
    awesome-client 'Hunger_wu()'
end
funcsave eat >/dev/null

function task
    indeed ~/.local/share/magazine/3 $argv
    update_magazine 3
end
funcsave task >/dev/null

alias --save win 'kitten @ launch --type window --cwd current' >/dev/null
alias --save over 'kitten @ launch --type overlay-main --cwd current' >/dev/null
alias --save tab 'kitten @ launch --type tab --cwd current' >/dev/null
