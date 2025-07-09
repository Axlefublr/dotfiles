#!/usr/bin/env fish

function blammo
    consume.rs ~/.cache/mine/yazi-file-list
end
funcsave blammo >/dev/null
alias --save k blammo >/dev/null

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

function dot
    echo dot >~/.local/share/mine/waybar-red-dot
end
funcsave dot >/dev/null

function edit_blank_clipboard
    truncate -s 0 /tmp/mine/clipboard-blank.md
    flour --end /tmp/mine/clipboard-blank.md
    cat /tmp/mine/clipboard-blank.md | copy
end
funcsave edit_blank_clipboard >/dev/null

function edit_clipboard
    ypoc >/tmp/mine/clipboard-edit.md
    flour --end /tmp/mine/clipboard-edit.md
    cat /tmp/mine/clipboard-edit.md | copy
end
funcsave edit_clipboard >/dev/null

function edit_clipboard_image
    # ypoci | satty -f -
    rnote (ypoci | psub)
end
funcsave edit_clipboard_image >/dev/null

function ffh
    set -l picked_function (rg '^function ffmpeg-' ~/fes/dot/fish/fun/ffmpeg.fish | string match -gr 'ffmpeg-(.*)' | string replace -a '-' ' ' | fzf)
    test $status -ne 0 && return 1
    set picked_function (string replace -a ' ' '-' $picked_function)
    ffmpeg-$picked_function
    bell
end
funcsave ffh >/dev/null

function float_clipboard_image
    ypoci | swayimg -a swayfloat -
end
funcsave float_clipboard_image >/dev/null

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
    niri msg pick-color | string match -gr '(#[[:xdigit:]]+)' | read -l hex
    notify-send $hex
    copy $hex
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
    cp -f ~/fes/bin/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
end
funcsave sts_boss >/dev/null

function piped_screen_editor
    set -l file /tmp/mine/helix-overlay
    read -z | sd -f=m '[ \\t▐]+$' '' >$file
    footclient -N helix -c ~/fes/dot/helix/screen.toml $file
end
funcsave piped_screen_editor >/dev/null

function piped_window_editor
    set -l file /tmp/mine/helix-overlay
    read -z | sd -f=m '[ \\t▐]+$' '' >$file
    footclient -N helix -c ~/fes/dot/helix/pager.toml $file
end
funcsave piped_window_editor >/dev/null

function randomize_file_names
    for file in $argv
        mv $file (uclanr 3 -j '-')(path extension $file)
    end
end
funcsave randomize_file_names >/dev/null

function screenshot_select
    niri msg action screenshot
end
funcsave screenshot_select >/dev/null

function screenshot_window
    niri msg action screenshot-window
end
funcsave screenshot_window >/dev/null

function screenshot_screen
    niri msg action screenshot-screen
end
funcsave screenshot_screen >/dev/null

function show_clipboard_image
    ypoci | swayimg -
end
funcsave show_clipboard_image >/dev/null

function special_anki_edit_action
    ypoc | string lower | sponge | copy
end
funcsave special_anki_edit_action >/dev/null

function niri_toggle_tab_correctly
    niri msg action toggle-column-tabbed-display
    niri msg action reset-window-height
end
funcsave niri_toggle_tab_correctly >/dev/null

function toggle_screen_record
    if test -f /tmp/mine/recordilock
        echo killing >~/.local/share/mine/waybar-screen-record
        kill -s INT wf-recorder
    else
        echo starting >~/.local/share/mine/waybar-screen-record
        screen-record.fish
    end
end
funcsave toggle_screen_record >/dev/null

function things
    begin
        footclient -NT nofocus helix ~/.local/share/magazine/semicolon
        footclient -NT nofocus-third fish -c fm
        footclient -NT nofocus calcure
    end 2>/dev/null
end
funcsave things >/dev/null

function niri_resize_width -a bigness
    not test "$bigness" && return 121
    niri msg action set-column-width $bigness
    niri msg action focus-column-left-or-last
    niri msg action focus-column-right-or-first
end
funcsave niri_resize_width >/dev/null

function strongly_kill_window
    niri msg -j focused-window | nu --stdin -n --no-std-lib -c 'from json | get id | kill -f $in'
end
funcsave strongly_kill_window >/dev/null

function which_wallpaper
    swww query | string match -gr 'image: (.*)'
end
funcsave which_wallpaper >/dev/null

function write_window_info
    niri msg windows >~/.local/share/magazine/o
    _magazine_commit ~/.local/share/magazine/o clients
    flour --disown ~/.local/share/magazine/o
end
funcsave write_window_info >/dev/null
