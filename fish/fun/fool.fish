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
    if not test "$argv"
        ? gh
        return 1
    end
    if test $argv[1] = repo
        switch $argv[2]
            case clone
                gh repo clone $argv[3..] -- --depth 1
                z (path basename $argv[3])
                clx
            case fork
                gh repo fork $argv[3..] --clone --default-branch-only -- --depth 1
                z (path basename $argv[3])
                clx
            case *
                gh $argv
        end
        return
    end
    gh $argv
end
funcsave gh >/dev/null

function alien_temple
    if test !"$argv"
        ? alien_temple
        return 1
    end
    switch $argv[1]
        case shark s
            set -l shark (alien_temple shark)
            printf '%s\n' $shark
            echo $shark[1] | copy
        case consent c
            alien_temple consent | tee /dev/tty | copy
        case *
            alien_temple $argv
    end
end
funcsave alien_temple >/dev/null
