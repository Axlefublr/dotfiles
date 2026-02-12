#!/usr/bin/env fish

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

alias --save dust 'dust -r' >/dev/null
alias --save eza 'eza --icons=auto --group-directories-first -x --time-style "+%y.%m.%d %H:%M" --smart-group --git --git-repos' >/dev/null
alias --save fd 'fd --no-require-git' >/dev/null
alias --save ffmpeg 'ffmpeg -y -hide_banner -stats -loglevel error' >/dev/null
alias --save ffprobe 'ffprobe -hide_banner' >/dev/null

function gh
    gh.nu $argv
    set -l exitcode $status
    set -l new_cwd "$(consume.rs /tmp/mine/github-directory 2>/dev/null)"
    test "$new_cwd" && z $new_cwd
    return $exitcode
end
funcsave gh >/dev/null

alias --save jpeg2png 'jpeg2png -i 100 -w 1.0 -f' >/dev/null
alias --save less 'less --use-color -R' >/dev/null

function loago
    command loago $argv
    test "$argv[1]" = --help && return
    if contains $argv[1] do remove
        git -C ~/fes/jiro add loago.json &>/dev/null
        and git -C ~/fes/jiro commit -m "loago $argv" &>/dev/null
    end
end
funcsave loago >/dev/null

alias --save pipes 'pipes -p 3 -c 1 -c 2 -c 3 -c 4 -c 5 -R' >/dev/null
alias --save pv 'pv -g' >/dev/null
alias --save rg 'rg --engine auto' >/dev/null
alias --save rofimoji 'rofimoji --selector fuzzel --action copy --skin-tone neutral --prompt ""' >/dev/null
alias --save rsync 'rsync --mkpath -P' >/dev/null
alias --save termdown 'termdown -W -f roman' >/dev/null
alias --save termframe 'termframe -o ~/iwm/sco/(date +%Y.%m.%d-%H:%M:%S).svg' >/dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' >/dev/null
alias --save tuisky 'tuisky -c ~/fes/dot/tuisky.toml' >/dev/null
alias --save unimatrix 'unimatrix -s 95 -abf' >/dev/null
