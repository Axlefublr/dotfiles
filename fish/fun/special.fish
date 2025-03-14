#!/usr/bin/env fish

function calculate_eof_position -a file
    set -l last_line (wc -l $file | string split ' ')[1]
    echo -n :$last_line:
    set -l last_column (zat.rs $file $last_line | wc -c | string split ' ')[1]
    echo -n $last_column
end
funcsave calculate_eof_position >/dev/null

function clipboard_index -a index
    notify-send -t 2000 "$(cliphist list | zat.rs - $index | cliphist decode | pee 'wl-copy -n' 'head -c 100')"
end
funcsave clipboard_index >/dev/null

function clipboard_pick
    set -l result (cliphist list | tee ~/.cache/mine/cliphist | cut -f 2- | fuzzel -d --index)
    test $status -ne 0 && return 1
    zat.rs ~/.cache/mine/cliphist ",$result" | cliphist decode | copy
end
funcsave clipboard_pick >/dev/null

function edit_blank_clipboard
    truncate -s 0 ~/.cache/mine/clipboard-edit.md
    neomax_hold ~/.cache/mine/clipboard-edit.md
    cat ~/.cache/mine/clipboard-edit.md | copy
end
funcsave edit_blank_clipboard >/dev/null

function edit_clipboard
    ypoc >~/.cache/mine/clipboard-edit.md
    neomax_hold (path_to_last_char ~/.cache/mine/clipboard-edit.md)
    cat ~/.cache/mine/clipboard-edit.md | copy
end
funcsave edit_clipboard >/dev/null

function edit_clipboard_image
    ypoci | satty -f -
end
funcsave edit_clipboard_image >/dev/null

function ffh
    set -l picked_function (rg '^function ffmpeg-' ~/r/dot/fish/fun/ffmpeg.fish | string match -gr 'ffmpeg-(.*)' | string replace -a '-' ' ' | fzf)
    test $status -ne 0 && return 1
    set picked_function (string replace -a ' ' '-' $picked_function)
    ffmpeg-$picked_function
    bell
end
funcsave ffh >/dev/null

function github_read_notifs
    # -H 'X-GitHub-Api-Version: 2022-11-28' \
    gh api \
        --method PUT \
        -H 'Accept: application/vnd.github+json' \
        /notifications \
        -F 'read=true'
end
funcsave github_read_notifs >/dev/null

function multiple_dot
    echo z (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
funcsave multiple_dot >/dev/null

function ntf_pick_dismiss
    set -l result (fnottctl list | rg '^\\d' | fuzzel -d 2>/dev/null)
    test $status -ne 0 && return 1
    fnottctl dismiss (echo $result | string match -gr '^(\\d+)')
end
funcsave ntf_pick_dismiss >/dev/null

function path_to_last_char
    echo $argv"$(calculate_eof_position $argv)"
end
funcsave path_to_last_char >/dev/null

function pick_and_copy_color
    wl-color-picker clipboard
end
funcsave pick_and_copy_color >/dev/null

function sts_boss
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
    mkdir -p ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods
    cp -f ~/r/binaries/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
end
funcsave sts_boss >/dev/null

function piped_window_editor
    set -l file /tmp/cami-helix-overlay
    read -z >$file
    footclient -N helix -c ~/r/dot/helix/wrap-off.toml $file
end
funcsave piped_window_editor >/dev/null

function randomize_file_names
    for file in $argv
        mv $file (uclanr 3 -j '-')(path extension $file)
    end
end
funcsave randomize_file_names >/dev/null

function show_clipboard_image
    ypoci | swayimg -
end
funcsave show_clipboard_image >/dev/null

function special_anki_edit_action
    ypoc | string lower | sponge | copy
end
funcsave special_anki_edit_action >/dev/null

function toggle_screen_record
    if matches 'Title: "screen-record";App ID: "kitty"' &>/dev/null
        kitten @ --to unix:/home/axlefublr/.cache/mine/screen-recording-kitty-socket signal-child SIGINT
        copyl ~/i/s/compressed.mp4
    else
        kitty -T screen-record --listen-on unix:/home/axlefublr/.cache/mine/screen-recording-kitty-socket screen-record.fish
    end
end
funcsave toggle_screen_record >/dev/null

function write_window_info
    niri msg windows >~/.local/share/magazine/o
    _magazine_commit ~/.local/share/magazine/o clients
end
funcsave write_window_info >/dev/null
