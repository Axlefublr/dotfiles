#!/usr/bin/env fish

function gsa
    if not command -q octogit
        echo "you don't have octogit-git-status"
        return 1
    end
    set -l prevDir (pwd)
    set -l directories (cat ~/.local/share/magazine/R | string split '\n')

    for dir in $directories

        set dir (string replace -r "^~" "$HOME" $dir)
        cd $dir
        echo -n (basename $dir)' '
        octogit-set
        printf '\n'

    end

    cd $prevDir
end
funcsave gsa >/dev/null

function gpp
    set -l prevDir (pwd)
    set -l directories (cat ~/.local/share/magazine/R | string split '\n')

    for dir in $directories

        set dir (string replace -r "^~" "$HOME" $dir)
        cd $dir
        git push

    end

    cd $prevDir
end
funcsave gpp >/dev/null