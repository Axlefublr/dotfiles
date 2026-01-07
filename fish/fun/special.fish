#!/usr/bin/env fish

function annotate_screen
    grim -t ppm - | satty --send-to-daemon -f -
end
funcsave annotate_screen >/dev/null

function append_github_line_numbers -a line_num
    set -l clipboard (wl-paste)
    string match -qe 'https://github.com' "$clipboard" || return 1
    if string match -qe '#L' "$clipboard"
        wl-copy -n "$clipboard-L$line_num"
    else
        wl-copy -n "$clipboard#L$line_num"
    end
end
funcsave append_github_line_numbers >/dev/null

function build_finish -a success
    if $success
        notify-send "✅ $(pwdb)"
    else
        notify-send "❌ $(pwdb)"
    end
end
funcsave build_finish >/dev/null

function calculate_eof_position -a file
    set -l last_line (wc -l $file | string split ' ')[1]
    echo -n :$last_line:
    set -l last_column (zat.rs $file $last_line | wc -c | string split ' ')[1]
    echo -n $last_column
end
funcsave calculate_eof_position >/dev/null

function clipboard_image_save
    set -l now (date +%Y.%m.%d-%H:%M:%S)
    set -l path_trunk ~/iwm/sco/$now
    wl-paste -t image/png >$path_trunk.png
    set -l is_large (echo $path_trunk.png | na --stdin -c 'str trim | ls $in | get size.0 | $in >= 10mb')
    if $is_large
        echo 'too large, attempting lossless' >&2
        magick -define webp:lossless=true $path_trunk.png $path_trunk.webp &
        magick $path_trunk.png $path_trunk!.webp &
        wait %1
        sl.fish $path_trunk.webp
        set -l is_large (echo $path_trunk.webp | na --stdin -c 'str trim | ls $in | get size.0 | $in >= 10mb')
        if $is_large
            echo 'lossless too large, attempting lossy' >&2
            wait %2
            sl.fish $path_trunk!.webp
        else
            kill %2
        end
    end
    dot
end
funcsave clipboard_image_save >/dev/null

function clipboard_index -a index
    notify-send -t 2000 "$(cliphist list | zat.rs - $index | cliphist decode | pee 'wl-copy -n' 'head -c 100')"
end
funcsave clipboard_index >/dev/null

function clipboard_pick
    set -l result (cliphist list | tee ~/.cache/mine/cliphist | cut -f 2- | fuzzel -d --index)
    test $status -ne 0 && return 1
    zat.rs ~/.cache/mine/cliphist ",$result" | cliphist decode | wl-copy -n
end
funcsave clipboard_pick >/dev/null

function dot
    echo dot >~/.local/share/mine/waybar-red-dot
end
funcsave dot >/dev/null

function edit_clipboard
    wl-paste >/tmp/mine/clipboard-edit.md
    flour /tmp/mine/clipboard-edit.md
    cat /tmp/mine/clipboard-edit.md | wl-copy -n
end
funcsave edit_clipboard >/dev/null

function edit_clipboard_image
    wl-paste -t image/png | satty --send-to-daemon -f -
    # rnote (wl-paste -t image/png | psub)
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
    wl-paste -t image/png | swayimg -a swayfloat -
end
funcsave float_clipboard_image >/dev/null

function fragmentize_url
    set -l selection (wl-paste --primary | string escape --style=url)
    not test "$selection"
    and begin
        notify-send 'nothing selected'
        return 1
    end
    wtype -M ctrl -k l -s 5 -k c -s 5 -m ctrl
    set -l clean_url (wl-paste -n | cut -d \# -f 1)
    not test "$clean_url"
    and begin
        notify-send 'fucked up url'
        return 1
    end
    wl-copy -n "$clean_url#:~:text=$selection"
    wtype -s 5 -M ctrl -k v -m ctrl -s 5 -k Return
end
funcsave fragmentize_url >/dev/null

function frizz_picker
    cd ~/.local/share/frizz
    set -l picked (fd -tf . | fuzzel -d --cache ~/.cache/mine/frizz-picker)
    not test "$picked" && return
    footclient -ND ~/.local/share/frizz helix $picked
end
funcsave frizz_picker >/dev/null

function github_read_notifs
    # -H 'X-GitHub-Api-Version: 2022-11-28' \
    gh api \
        --method PUT \
        -H 'Accept: application/vnd.github+json' \
        /notifications \
        -F 'read=true'
end
funcsave github_read_notifs >/dev/null

function is_focused_xwayland
    set -l pid (niri msg -j windows | na --stdin -c 'from json | where is_focused == true | get pid | first')
    set -l executable (readlink /proc/$pid/exe)
    if test (path basename $executable) = xwayland-satellite
        notify-send '✅ xwayland'
    else
        notify-send '❌ native'
    end
end
funcsave is_focused_xwayland >/dev/null

function loago_tracker
    while true
        clear
        loagoe.nu due
    end
end
funcsave loago_tracker >/dev/null

function mouse_position
    set -l pos (niri msg pointer | string join ' ')
    echo $pos | wl-copy -n
    notify-send -t 0 $pos
end
funcsave mouse_position >/dev/null

function multiple_dot
    echo (string repeat -n (math (string length -- $argv[1]) - 1) ../ | string trim -r -c /)
end
funcsave multiple_dot >/dev/null

function niri_toggle_tab_correctly
    niri msg action toggle-column-tabbed-display
    niri msg action reset-window-height
end
funcsave niri_toggle_tab_correctly >/dev/null

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
    wl-copy -n $hex
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
    cp -f ~/fes/eva/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
end
funcsave sts_boss >/dev/null

function piped_output_editor
    set -l file /tmp/mine/command-output
    read -z >$file
    flour --disown $file
end
funcsave piped_output_editor >/dev/null

function piped_screen_editor
    set -l file /tmp/mine/helix-overlay
    read -z | sd -f=m '[ \\t▐]+$' '' >$file
    flour --disown --pager $file
end
funcsave piped_screen_editor >/dev/null

function piped_scrollback_editor
    set -l file /tmp/mine/helix-overlay
    read -z | sd -f=m '[ \\t▐]+$' '' >$file
    flour --disown --pager $file
end
funcsave piped_scrollback_editor >/dev/null

function pvz_plant -a x_pos
    set -l prev_position (niri msg pointer)
    ydotool mousemove -a $x_pos 50
    ydotool click C0
    ydotool mousemove -a $prev_position[1] $prev_position[2]
    ydotool click C0
end
funcsave pvz_plant >/dev/null

function randomize_file_names
    for file in $argv
        mv $file (uclanr 3 -j '-')(path extension $file)
    end
end
funcsave randomize_file_names >/dev/null

function screenshot_select
    niri msg action screenshot -p false
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
    wl-paste -t image/png | swayimg -f $argv -
end
funcsave show_clipboard_image >/dev/null

function special_anki_edit_action
    wl-paste -n | string lower | sponge | wl-copy -n
end
funcsave special_anki_edit_action >/dev/null

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
        footclient -NT nofocus helix ~/.local/share/magazine/semicolon.md
        footclient -NT nofocus-fifth fish -c loago_tracker
        footclient -NT nofocus calcure
    end 2>/dev/null
end
funcsave things >/dev/null

function niri_resize_width -a bigness
    not test "$bigness" && return 121
    niri msg action set-column-width $bigness
    # niri msg action focus-window-previous
    # niri msg action center-visible-columns
end
funcsave niri_resize_width >/dev/null

function strongly_kill_window
    niri msg -j focused-window | na --stdin -c 'from json | get id | kill -f $in'
end
funcsave strongly_kill_window >/dev/null

function which_wallpaper
    swww query | string match -gr 'image: (.*)'
end
funcsave which_wallpaper >/dev/null

function write_window_info
    niri msg windows >/tmp/mine/window-info
    _magazine_commit /tmp/mine/window-info clients
    flour --disown /tmp/mine/window-info
end
funcsave write_window_info >/dev/null
