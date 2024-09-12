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
