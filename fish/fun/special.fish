#!/usr/bin/env fish

function edit_repo_root_or_cwd
    helix -w (git rev-parse --show-toplevel || echo $PWD) .
end
funcsave edit_repo_root_or_cwd >/dev/null

function pick_sts_boss
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
funcsave pick_sts_boss >/dev/null
