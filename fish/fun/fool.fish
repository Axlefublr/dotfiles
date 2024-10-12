#!/usr/bin/env fish

function loago
    command loago $argv
    test $argv[1] = --help && return
    if contains $argv[1] do remove
        set prevdir $PWD
        cd ~/prog/autocommit
        cp -f ~/.local/share/loago/loago.json .
        git add loago.json &>/dev/null
        and git commit -m "loago $argv" &>/dev/null
        cd $prevdir
    end
end
funcsave loago >/dev/null

function gh
    if test "$argv[1..2]" = 'repo clone'
        command gh repo clone $argv[3..] -- --depth 1
        z (path basename $argv[3])
        clx
    else if test "$argv[1..2]" = 'repo fork'
        command gh repo fork $argv[3..] --clone --default-branch-only -- --depth 1
        z (path basename $argv[3])
        clx
    else
        command gh $argv
    end
end
funcsave gh >/dev/null

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
