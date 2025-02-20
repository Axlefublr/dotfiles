#!/usr/bin/env fish

function pick-sts-boss
    set input (
        begin
            echo NoAwakenedOne
            echo NoDonuDeca
            echo NoTimeEater
            echo YesAwakenedOne
            echo YesDonuDeca
            echo YesTimeEater
        end | fuzzel -d 2>/dev/null
    )
    if test $status -ne 0
        return 1
    end
    cp -f ~/r/binaries/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
end
funcsave pick-sts-boss >/dev/null

function multiple_dot
    echo z (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
funcsave multiple_dot >/dev/null

function github-read-notifs
    # -H 'X-GitHub-Api-Version: 2022-11-28' \
    gh api \
        --method PUT \
        -H 'Accept: application/vnd.github+json' \
        /notifications \
        -F 'read=true'
end
funcsave github-read-notifs >/dev/null

function special_anki_edit_action
    ypoc | string lower | sponge | copy
end
funcsave special_anki_edit_action >/dev/null

function randomize-file-names
    for file in $argv
        mv $file (uclanr 3 -j '-')(path extension $file)
    end
end
funcsave randomize-file-names >/dev/null

function calculate-eof-position -a file
    set -l last_line (wc -l $file | string split ' ')[1]
    echo -n :$last_line:
    set -l last_column (zat -s $last_line -e $last_line $file | wc -c | string split ' ')[1]
    echo -n $last_column
end
funcsave calculate-eof-position >/dev/null

function toggle-screen-record
    if matches 'Title: "screen-record";App ID: "kitty"' &>/dev/null
        kitten @ --to unix:/home/axlefublr/.cache/mine/screen-recording-kitty-socket signal-child SIGINT
        copyl ~/i/s/compressed.mp4
    else
        kitty -T screen-record --listen-on unix:/home/axlefublr/.cache/mine/screen-recording-kitty-socket screen-record.fish
    end
end
funcsave toggle-screen-record >/dev/null

function ntf-pick-dismiss
    set -l result (fnottctl list | rg '^\\d' | fuzzel -d 2>/dev/null)
    test $status -ne 0 && return 1
    fnottctl dismiss (echo $result | string match -gr '^(\\d+)')
end
funcsave ntf-pick-dismiss >/dev/null

function clipboard-pick
    set -l result (cliphist list | tee ~/.cache/mine/cliphist | cut -f 2- | fuzzel -d --index)
    test $status -ne 0 && return 1
    sed -n (math $result + 1)'p' ~/.cache/mine/cliphist | cliphist decode | copy
end
funcsave clipboard-pick >/dev/null

function clipboard-index -a index
    notify-send -t 2000 "$(cliphist list | sed -n $index'p' | cliphist decode | pee 'wl-copy -n' 'head -c 100')"
end
funcsave clipboard-index >/dev/null

function write-window-info
    niri msg windows >~/.local/share/magazine/o
    _magazine_commit ~/.local/share/magazine/o clients
end
funcsave write-window-info >/dev/null

function pick-and-copy-color
    set -l picked_color (xcolor)
    notify-send -t 3000 "$picked_color"
    echo $picked_color | copy
end
funcsave pick-and-copy-color >/dev/null

function piped_in_overlay
    set -l file /tmp/cami-helix-overlay
    read -z >$file
    footclient -T overlay -N helix -c ~/r/dot/helix/wrap-off.toml $file
end
funcsave piped_in_overlay >/dev/null
