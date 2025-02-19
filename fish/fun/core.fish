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
    cp -f ~/i/s/original.mp4 $argv[1].mp4
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

function yazi_cd
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        z $cwd
    end
    commandline -f repaint
    rm -f -- "$tmp"
end
funcsave yazi_cd >/dev/null

function neoline
    scratchpad --wintitle=line -- helix -c ~/r/dot/helix/quit.toml $argv
end
funcsave neoline >/dev/null

function neoline_hold
    neoline $argv
    win_wait 'Title: "line";App ID: "kitty"' 0.05 >/dev/null
    win_wait_closed 'Title: "line";App ID: "kitty"' 0.05 >/dev/null
end
funcsave neoline_hold >/dev/null

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

function task
    set mag 3
    argparse 'm/mag=' -- $argv
    and test "$_flag_mag"
    and set mag $_flag_mag
    indeed.rs -u ~/.local/share/magazine/$mag -- $argv
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
    argparse -i cwd= wintitle= -- $argv || return 121
    test "$_flag_cwd" && set -l cwd $_flag_cwd || set -l cwd current
    test "$_flag_wintitle" && set -l wintitle --os-window-title $_flag_wintitle || set -l wintitle --os-window-title scratchpad
    kitten @ --to unix:(fd cami-kitty-instance /tmp | head -n 1) launch --cwd $cwd --type os-window $wintitle --no-response $argv &>/dev/null
end
funcsave scratchpad >/dev/null
alias --save int scratchpad >/dev/null

function scratchkitty
    pgrep kitty &>/dev/null && scratchpad --cwd ~ || kitty
end
funcsave scratchkitty >/dev/null

function get-input
    set -l input (fuzzel -dl 0 2>/dev/null)
    test $status -ne 0 && return 1
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

function get_windows
    niri msg windows | sd '\n  ' ';' | sd '\n\n' '\n'
end
funcsave get_windows >/dev/null

function matches
    get_windows | rg $argv
end
funcsave matches >/dev/null

function not_matches
    if get_windows | rg $argv
        return 1
    else
        return 0
    end
end
funcsave not_matches >/dev/null

function matches_except
    get_windows | rg -v $argv[1] | rg $argv[2]
end
funcsave matches_except >/dev/null

function win_wait
    loopuntil "matches '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait >/dev/null

function win_wait_closed
    loopuntil "not_matches '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait_closed >/dev/null

function win_wait_except
    loopuntil "matches_except '$argv[1]' '$argv[2]'" $argv[3..] | awk '{print $1}'
end
funcsave win_wait_except >/dev/null

function ensure_browser
end
funcsave ensure_browser >/dev/null

function loopuntil
    set -l counter 0
    while true
        set output (eval $argv[1])
        if test $status -eq 0
            if set -q argv[3] && test $argv[3] -ne 0
                sleep $argv[3]
                set argv[3] 0
                continue
            end
            break
        end
        set counter (math $counter + 1)
        if set -q argv[2]
            sleep $argv[2]
        end
        if set -q argv[4]
            if test $counter -ge $argv[4]
                return 1
            end
        end
    end
    for line in $output
        echo $line
    end
end
funcsave loopuntil >/dev/null

function lh
    read | string replace 'github.com' 'raw.githubusercontent.com' | string replace blob refs/heads
end
funcsave lh >/dev/null

function lhg
    # https://github.com/Axlefublr/dotfiles/blob/main/fish/fun/general.fish
    # into
    # https://raw.githubusercontent.com/Axlefublr/dotfiles/refs/heads/main/fish/fun/general.fish
    set -l raw_link (ypoc | string replace 'github.com' 'raw.githubusercontent.com' | string replace blob refs/heads)
    set -l extension (path extension $raw_link)
    curl $raw_link >~/.cache/mine/lhg$extension
    helix ~/.cache/mine/lhg$extension
end
funcsave lhg >/dev/null

function ankuery
    curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "'"$argv"'" } }' 2>/dev/null | jq .result.[] 2>/dev/null | count
end
funcsave ankuery >/dev/null

function confirm -a message
    not set -q message && return 121
    not set -q argv[3] && return 121
    set -l options $argv[2..]
    set -l valids
    for option in $options
        set -l key (string match -gr '\\[(.)\\]' $option)
        test $status -ne 0 && return 121
        set valids $valids $key
    end
    echo $message >&2
    while not contains "$response" $valids
        read -P "$(string join ' / ' $options) " -fn 1 response || break 130
    end
    for num in (seq (count $valids))
        test "$response" = $valids[$num] && return $num
    end
end
funcsave confirm >/dev/null

function lnkj -a fileone filetwo
    if not set -q fileone
        or not set -q filetwo
        echo 'missing arguments' >&2
        return 1
    end
    if not test -f $filetwo
        ln $fileone $filetwo
    else if not arebesties $fileone $filetwo
        confirm "$filetwo is not a hardlink. make it be one?" '[j]es' '[k]o' '[c]opy over'
        set -l exitcode $status
        if test $exitcode -eq 1
            ln -f $fileone $filetwo
        else if test $exitcode -eq 3
            rm -f $filetwo
            cp -f $fileone $filetwo
        else
            return $status
        end
    else
        confirm "$fileone and $filetwo are besties." 'alrigh[j] then' '[c]opy over'
        set -l exitcode $status
        if test $exitcode -eq 2
            rm -f $filetwo
            cp -f $fileone $filetwo
        else
            return $status
        end
    end
end
funcsave lnkj >/dev/null

function ffh
    set -l picked_function (rg '^function ffmpeg-' ~/r/dot/fish/fun/ffmpeg.fish | string match -gr 'ffmpeg-(.*)' | string replace -a '-' ' ' | fzf)
    test $status -ne 0 && return 1
    set picked_function (string replace -a ' ' '-' $picked_function)
    ffmpeg-$picked_function
    bell
end
funcsave ffh >/dev/null

function alphabet
    printf 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[];\',./{}:"<>?'
end
funcsave alphabet >/dev/null

function set_tab_title
    read -P 'title: ' new_title
    if not test "$new_title"
        kitten @ set-tab-title ""
        return
    end
    kitten @ set-tab-title " $new_title"
end
funcsave set_tab_title >/dev/null

function fn-clear
    set list (cat ~/r/dot/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
    for file in ~/.config/fish/functions/*.fish
        set function_name (basename $file '.fish')
        if not contains $function_name $list
            and not string match -qr '^_?fifc' $function_name
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn-clear >/dev/null
