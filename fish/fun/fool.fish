#!/usr/bin/env fish

function loago
    command loago $argv
    test "$argv[1]" = --help && return
    if contains $argv[1] do remove
        set prevdir $PWD
        cd ~/auto
        cp -f ~/.local/share/loago/loago.json .
        git add loago.json &>/dev/null
        and git commit -m "loago $argv" &>/dev/null
        cd $prevdir
    end
end
funcsave loago >/dev/null

function alien_temple
    if test "$argv[1]" = shark -o "$argv[1]" = s
        set -l shark (command alien_temple shark)
        printf '%s\n' $shark
        echo $shark[1] | copy
    else if test "$argv[1]" = consent -o "$argv[1]" = c
        command alien_temple consent | tee /dev/tty | copy
    else if test "$argv[1]" = play
        command alien_temple $argv
        loago do liked
    else
        command alien_temple $argv
    end
end
funcsave alien_temple >/dev/null
