#!/usr/bin/env fish

function alphabet
    echo -n 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[];\',./{}:"<>?!@#$%^*()-_=+`|\\'
end
funcsave alphabet >/dev/null

function ankuery
    curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "'"$argv"'" } }' 2>/dev/null | jq .result.[] 2>/dev/null | count
end
funcsave ankuery >/dev/null

function arebesties -a fileone filetwo
    test (stat -c %i $fileone) -eq (stat -c %i $filetwo)
end
funcsave arebesties >/dev/null

function b
    if set -q argv
        bg %(velvidek.rs $argv)
    else
        bg
    end
end
funcsave b >/dev/null

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
        read -P "$(string join ' / ' $options) " -fn 1 response || return 130
    end
    for num in (seq (count $valids))
        test "$response" = $valids[$num] && return $num
    end
end
funcsave confirm >/dev/null

alias --save dedup 'awk \'!seen[$0]++\'' >/dev/null

function ensure_browser
end
funcsave ensure_browser >/dev/null

function f
    if set -q argv
        fg %(velvidek.rs $argv)
    else
        fg
    end
end
funcsave f >/dev/null

function flour
    argparse 'T/title=' -- $argv
    and test "$_flag_title"
    and set title $_flag_title
    or set title flour
    footclient -T $title -- helix -c ~/r/dot/helix/quit.toml $argv
end
funcsave flour >/dev/null

function flour_half_hold
    flour -T flour-half -- $argv
end
funcsave flour_half_hold >/dev/null

function flour_hold
    flour $argv
end
funcsave flour_hold >/dev/null

function fn_clear
    set list (cat ~/r/dot/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
    for file in ~/.config/fish/functions/*.fish
        set function_name (basename $file '.fish')
        if not contains $function_name $list
            # and not string match -qr '^_?fifc' $function_name
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn_clear >/dev/null

function get_input
    set -l input (fuzzel -dl 0 2>/dev/null)
    test $status -ne 0 && return 1
    if test (string sub -s -2 -- $input) = '%%'
        string sub -e -2 -- $input >/tmp/cami-get-input
        flour_hold (path_to_last_char /tmp/cami-get-input)
        set input "$(cat /tmp/cami-get-input)"
    end
    echo $input
end
funcsave get_input >/dev/null

function get_input_max
    truncate -s 0 /tmp/cami-get-input
    flour_hold /tmp/cami-get-input
    if test -s /tmp/cami-get-input
        cat /tmp/cami-get-input
    else
        return 1
    end
end
funcsave get_input_max >/dev/null

function get_windows
    niri msg windows | sd '\n  ' ';' | sd '\n\n' '\n'
end
funcsave get_windows >/dev/null

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
    magick $argv[1].png $argv[1].webp
    rm -f $argv[1].png
end
funcsave imgsw >/dev/null

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
    curl $raw_link >/tmp/cami-lhg$extension
    helix /tmp/cami-lhg$extension
end
funcsave lhg >/dev/null

function lnkj -a fileone filetwo
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
    else
        confirm.rs "$fileone and $filetwo are besties." 'alrigh[j] then' '[c]opy over' | read -l response
        if test "$response" = c
            rm -f $filetwo
            cp -f $fileone $filetwo
        end
    end
end
funcsave lnkj >/dev/null

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

function matches
    get_windows | rg $argv
end
funcsave matches >/dev/null

function matches_except
    get_windows | rg -v $argv[1] | rg $argv[2]
end
funcsave matches_except >/dev/null

function matches_not
    if get_windows | rg $argv
        return 1
    else
        return 0
    end
end
funcsave matches_not >/dev/null

function mkcd
    mkdir -p $argv && z $argv && clx
end
funcsave mkcd >/dev/null

function ocr
    tesseract $argv - 2>/dev/null
end
funcsave ocr >/dev/null

function rename
    mv $argv[1] _$argv[1]
    mv _$argv[1] $argv[2]
end
funcsave rename >/dev/null

function task
    set mag 3
    argparse 'm/mag=' -- $argv
    and test "$_flag_mag"
    and set mag $_flag_mag
    indeed.rs -u ~/.local/share/magazine/$mag -- $argv
    _magazine_commit ~/.local/share/magazine/$mag task
end
funcsave task >/dev/null

function ttest
    alphabet | string split '' >~/.cache/mine/alphabet-all
    set -f symbol (shuf -n 1 ~/.cache/mine/alphabet-all)
    while true
        read -P "$symbol" -n 1 output || break
        test "$output" = "$symbol" || continue
        while true
            set -l next_symbol (shuf -n 1 ~/.cache/mine/alphabet-all)
            if test "$symbol" != "$next_symbol"
                set -f symbol $next_symbol
                break
            end
        end
    end
end
funcsave ttest >/dev/null

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

function vids
    cp -f ~/i/s/original.mp4 $argv[1].mp4
end
funcsave vids >/dev/null

function webify
    for file in $argv
        not test -f $file && continue
        set -l webp_file (path change-extension 'webp' $file)
        magick -define webp:lossless=true $file $webp_file
        not test -f $webp_file && continue
        if test (stat -c %s $webp_file) -gt (stat -c %s $file)
            gomi $webp_file
        else
            gomi $file
        end
    end
end
funcsave webify >/dev/null

function win_wait
    loopuntil "matches '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait >/dev/null

function win_wait_closed
    loopuntil "matches_not '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait_closed >/dev/null

function win_wait_except
    loopuntil "matches_except '$argv[1]' '$argv[2]'" $argv[3..] | awk '{print $1}'
end
funcsave win_wait_except >/dev/null

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
