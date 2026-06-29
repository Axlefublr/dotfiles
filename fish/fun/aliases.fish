#!/usr/bin/env fish

function annotate_screen
    grim -t ppm - | satty --send-to-daemon -f -
end
funcsave annotate_screen >/dev/null

function ansi_move_cursor_up -a lines
    not test "$lines" && set -f lines 1
    echo -e '\e['$lines'A'
end
funcsave ansi_move_cursor_up >/dev/null

function ansi_hide_cursor
    echo -e '\x1b[?25l'
end
funcsave ansi_hide_cursor >/dev/null

alias --save capslock_state 'cat /sys/class/leds/input*::capslock/brightness | head -n 1' >/dev/null

function clipboard_index -a index
    notify-send -t 2000 "$(cliphist list | zat.rs - $index | cliphist decode | pee 'wl-copy -n' 'head -c 100')"
end
funcsave clipboard_index >/dev/null

function clipboard_pick
    set -l result (cliphist list | tee ~/fes/zufi/cliphist | cut -f 2- | fuzzel -d --index)
    test $status -ne 0 && return 1
    zat.rs ~/fes/zufi/cliphist ",$result" | cliphist decode | wl-copy -n
end
funcsave clipboard_pick >/dev/null

alias --save clx 'clear -x' >/dev/null

function eat
    loago do eat
    notify-send -t 2000 'ate!'
end
funcsave eat >/dev/null

function edit_clipboard
    wl-paste >/tmp/mine/clipboard-edit.md
    flour /tmp/mine/clipboard-edit.md
    cat /tmp/mine/clipboard-edit.md | wl-copy -n
end
funcsave edit_clipboard >/dev/null

function edit_clipboard_blank
    truncate -s 0 /tmp/mine/clipboard-edit.md
    flour /tmp/mine/clipboard-edit.md
    cat /tmp/mine/clipboard-edit.md | wl-copy -n
end
funcsave edit_clipboard_blank >/dev/null

function edit_clipboard_image
    wl-paste -t image/png | satty --send-to-daemon -f -
    # rnote (wl-paste -t image/png | psub)
end
funcsave edit_clipboard_image >/dev/null

alias --save fc 'cat ~/fes/uviw/afen/sudo | sudo -S systemctl restart fancontrol' >/dev/null

function ffont
    fc-list | rg --color always -i $argv | column -l 2 -t -s :
end
funcsave ffont >/dev/null

function float_clipboard_image
    wl-paste -t image/png | swayimg -v --class swayfloat -e 'FLOATING = true' -
end
funcsave float_clipboard_image >/dev/null

alias --save get_media_player 'playerctl metadata --format "{{playerName}}"' >/dev/null
alias --save get_media_time 'playerctl metadata --format "{{duration(position)}}"' >/dev/null

function get_media_volume
    set volume (playerctl volume 2>/dev/null)
    if test -z "$volume"
        return 1
    end
    math "round($volume * 100)"
end
funcsave get_media_volume >/dev/null

alias --save inotifytheusual 'inotifywait -qq -e modify -e move_self' >/dev/null
alias --save keyboard_layout "na -c 'let the = niri msg -j keyboard-layouts | from json ; \$the.names | get \$the.current_idx'" >/dev/null
alias --save media_next 'playerctl next' >/dev/null
alias --save media_position 'playerctl position' >/dev/null
alias --save media_prev 'playerctl previous' >/dev/null
alias --save media_state 'playerctl status' >/dev/null

function mouse_position
    set -l pos (niri msg pointer | string join ' ')
    echo $pos | wl-copy -n
    notify-send -t 0 $pos
end
funcsave mouse_position >/dev/null

alias --save na 'nu -n --no-std-lib' >/dev/null
alias --save ntf_dismiss_all 'fnottctl dismiss all' >/dev/null
alias --save ntf_dismiss_old 'fnottctl dismiss' >/dev/null
alias --save ntf_dismiss_new "fnottctl dismiss (fnottctl list | tail -n 1 | string split ':')[1]" >/dev/null

function ntf_pick_dismiss
    set -l result (fnottctl list | rg '^\\d' | fuzzel -d 2>/dev/null)
    test $status -ne 0 && return 1
    fnottctl dismiss (echo $result | string match -gr '^(\\d+)')
end
funcsave ntf_pick_dismiss >/dev/null

alias --save o 'wl-paste -n' >/dev/null
alias --save oi 'wl-paste -t image/png' >/dev/null
alias --save on wl-paste >/dev/null

function pick_and_copy_color
    niri msg pick-color | string match -gr '(#[[:xdigit:]]+)' | read -l hex
    notify-send $hex
    wl-copy -n $hex
end
funcsave pick_and_copy_color >/dev/null

alias --save poweroff 'allow_logout && poweroff' >/dev/null
alias --save reboot 'allow_logout && systemctl reboot' >/dev/null
alias --save s 'wl-copy -n' >/dev/null

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

alias --save set_media_volume 'playerctl volume' >/dev/null
alias --save set_mic_volume 'wpctl set-volume @DEFAULT_AUDIO_SOURCE@' >/dev/null
alias --save set_volume 'wpctl set-volume @DEFAULT_AUDIO_SINK@' >/dev/null

function show_clipboard_image
    wl-paste -t image/png | swayimg -F $argv -
end
funcsave show_clipboard_image >/dev/null

alias --save sn wl-copy >/dev/null
alias --save sreboot 'systemctl soft-reboot' >/dev/null

function strongly_kill_window
    niri msg -j focused-window | na --stdin -c 'from json | get id | kill -f $in'
end
funcsave strongly_kill_window >/dev/null

alias --save suspend 'systemctl suspend' >/dev/null

function tit
    test "$argv" && printf '\e]2;%s\a' "$argv"
    return 0
end
funcsave tit >/dev/null

function protit -d 'only update title if TIT is not set'
    not set -q TIT && status is-interactive && tit $argv
end
funcsave protit >/dev/null

alias --save toggle_media 'playerctl play-pause' >/dev/null
alias --save toggle_mic_mute 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle' >/dev/null
alias --save toggle_mute 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >/dev/null

function which_wallpaper
    swww query | string match -gr 'image: (.*)'
end
funcsave which_wallpaper >/dev/null

function wpchange
    awww img -t any --transition-fps 255 --transition-duration 3 $argv
end
funcsave wpchange >/dev/null

function write_window_info
    niri msg windows >/tmp/mine/window-info
    _magazine_commit /tmp/mine/window-info clients
    flour --disown /tmp/mine/window-info
end
funcsave write_window_info >/dev/null
