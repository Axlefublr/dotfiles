#!/usr/bin/env fish

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

function clipboard_image_save
    set -l now (date +%Y.%m.%d-%H:%M:%S)
    set -l path_trunk ~/iwm/sco/$now
    notify-send -t 0 processing
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
    ntf_dismiss_old
end
funcsave clipboard_image_save >/dev/null

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

function fn_clear
    set list (cat ~/fes/dot/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
    for file in ~/.config/fish/functions/*.fish
        set function_name (basename $file '.fish')
        if not contains $function_name $list
            # and not string match -qr '^_?fifc' $function_name
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn_clear >/dev/null

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
        notify-send '❌ x11'
    else
        notify-send '✅ wayland'
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

function monpepype
    while true
        clx
        shuf ~/ake/pords.txt | head -n 10 | string join ' '
        read -P '' -l the || break
    end
end
funcsave monpepype >/dev/null

function multiple_dot
    echo (string repeat -n (math (string length -- $argv[1]) - 1) ../ | string trim -r -c /)
end
funcsave multiple_dot >/dev/null

function niri_toggle_tab_correctly
    niri msg action toggle-column-tabbed-display
    niri msg action reset-window-height
end
funcsave niri_toggle_tab_correctly >/dev/null

function path_clear_suffix
    for path in $argv
        echo (path dirname $path)/(path basename -E $path | string match -gr '(.*?)!' | string trim -rc +=)(path extension $path)
    end
end
funcsave path_clear_suffix >/dev/null

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
        set -l calcure_lacks (niri msg -j windows | na --stdin -c 'from json | where app_id like ^foot | where title like calcure | is-empty')
        if $calcure_lacks
            footclient -NT daily-calcure calcure
        end
        set -l loago_tracker_lacks (niri msg -j windows | na --stdin -c 'from json | where app_id like ^foot | where title like loago-tracker | is-empty')
        if $loago_tracker_lacks
            footclient -NT daily-loago-tracker fish -c loago_tracker
        end
        set -l review_lacks (niri msg -j windows | na --stdin -c 'from json | where app_id like ^foot | where title like review | is-empty')
        if $review_lacks
            footclient -NT daily-review helix -w ~/.local/share/magazine ~/.local/share/magazine/semicolon.md
        end
    end 2>/dev/null
end
funcsave things >/dev/null
