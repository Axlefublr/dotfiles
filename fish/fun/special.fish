#!/usr/bin/env fish

function edit-repo-root-or-cwd
    helix -w (git rev-parse --show-toplevel || echo $PWD) .
end
funcsave edit-repo-root-or-cwd >/dev/null

function pick-sts-boss
    set input (
        begin
            echo NoAwakenedOne
            echo NoDonuDeca
            echo NoTimeEater
            echo YesAwakenedOne
            echo YesDonuDeca
            echo YesTimeEater
        end | rofi -dmenu 2> /dev/null ; echo $status
    )
    if test $input[-1] -ne 0
        return 1
    end
    set -e input[-1]
    cp -f ~/prog/binaries/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
end
funcsave pick-sts-boss >/dev/null
