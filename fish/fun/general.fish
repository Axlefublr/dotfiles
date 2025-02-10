#!/usr/bin/env fish

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

function autocommit
    if not git status --porcelain
        return
    end
    set -l new_files
    set -l deleted_files
    set -l modified_files
    set -l renamed_from
    set -l renamed_to
    git add .
    for change in (git status --porcelain)
        set -l bits (string split -n ' ' $change)
        set type $bits[1]
        set path "$(echo $bits[2..])"
        if test $type = A
            set new_files $new_files (string trim -c '"' $path)
        else if test $type = D
            set deleted_files $deleted_files (string trim -c '"' $path)
        else if test $type = M
            set modified_files $modified_files (string trim -c '"' $path)
        else if test $type = R
            set two_paths (string split ' -> ' -- $path)
            set renamed_from $renamed_from (string trim -c '"' $two_paths[1])
            set renamed_to $renamed_to (string trim -c '"' $two_paths[2])
        end
    end
    git restore --staged .
    for deletion in $deleted_files
        git add $deletion
        and git commit -m "remove $deletion"
    end
    for addition in $new_files
        git add $addition
        and git commit -m "add $addition"
    end
    for modification in $modified_files
        git add $modification
        and git commit -m "change $modification"
    end
    for index in (seq (count $renamed_from))
        git add $renamed_from[$index] $renamed_to[$index]
        and git commit -m "move $renamed_from[$index] -> $renamed_to[$index]"
    end
end
funcsave autocommit >/dev/null

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
    curl $raw_link >~/bs/lhg$extension
    helix ~/bs/lhg$extension
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
