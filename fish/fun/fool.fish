#!/usr/bin/env fish

function loago
    command loago $argv
    test "$argv[1]" = --help && return
    if contains $argv[1] do remove
        git -C ~/fes/jiro add loago.json &>/dev/null
        and git -C ~/fes/jiro commit -m "loago $argv" &>/dev/null
    end
end
funcsave loago >/dev/null

function alien_temple
    if test "$argv[1]" = shark -o "$argv[1]" = s
        set -l shark (command alien_temple shark)
        printf '%s\n' $shark
        echo $shark[1] | wl-copy -n
    else if test "$argv[1]" = consent -o "$argv[1]" = c
        command alien_temple consent | tee /dev/tty | wl-copy -n
    else if test "$argv[1]" = play
        command alien_temple $argv
        loago do liked
    else
        command alien_temple $argv
    end
end
funcsave alien_temple >/dev/null

function gh
    set -l exitcode (gh.nu $argv)
    set -l new_cwd "$(consume.rs /tmp/mine/github-directory)"
    test "$new_cwd" && cd $new_cwd
    return $exitcode
end
funcsave gh >/dev/null
