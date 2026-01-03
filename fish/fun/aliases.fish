#!/usr/bin/env fish

# [[sort on]]
alias --save at alien_temple >/dev/null
alias --save bell 'printf \a' >/dev/null
alias --save capslock_state 'cat /sys/class/leds/input*::capslock/brightness | head -n 1' >/dev/null
alias --save clx 'clear -x' >/dev/null
alias --save fc 'cat ~/fes/uviw/afen/sudo | sudo -S systemctl restart fancontrol' >/dev/null
alias --save ffmpeg 'ffmpeg -y -hide_banner -stats -loglevel error' >/dev/null
alias --save get_media_player 'playerctl metadata --format "{{playerName}}"' >/dev/null
alias --save get_media_time 'playerctl metadata --format "{{duration(position)}}"' >/dev/null
alias --save gx 'glaza --git' >/dev/null
alias --save gz glaza >/dev/null
alias --save hime 'history merge' >/dev/null
alias --save inotifytheusual 'inotifywait -qq -e modify -e move_self' >/dev/null
alias --save jf 'exec fish' >/dev/null
alias --save keyboard_layout "na -c 'let the = niri msg -j keyboard-layouts | from json ; \$the.names | get \$the.current_idx'" >/dev/null
alias --save media_next 'playerctl next' >/dev/null
alias --save media_position 'playerctl position' >/dev/null
alias --save media_prev 'playerctl previous' >/dev/null
alias --save media_state 'playerctl status' >/dev/null
alias --save na 'nu -n --no-std-lib' >/dev/null
alias --save ntf_dismiss_all 'fnottctl dismiss all' >/dev/null
alias --save ntf_dismiss_old 'fnottctl dismiss' >/dev/null
alias --save o 'wl-paste -n' >/dev/null
alias --save oi 'wl-paste -t image/png' >/dev/null
alias --save on wl-paste >/dev/null
alias --save reboot 'systemctl reboot' >/dev/null
alias --save rofimoji 'rofimoji --selector fuzzel --action copy --skin-tone neutral --prompt ""' >/dev/null
alias --save s 'wl-copy -n' >/dev/null
alias --save set_media_volume 'playerctl volume' >/dev/null
alias --save set_mic_volume 'wpctl set-volume @DEFAULT_AUDIO_SOURCE@' >/dev/null
alias --save set_volume 'wpctl set-volume @DEFAULT_AUDIO_SINK@' >/dev/null
alias --save sn wl-copy >/dev/null
alias --save sreboot 'systemctl soft-reboot' >/dev/null
alias --save suspend 'systemctl suspend' >/dev/null
alias --save toggle_media 'playerctl play-pause' >/dev/null
alias --save toggle_mic_mute 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle' >/dev/null
alias --save toggle_mute 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >/dev/null
alias --save ubootf 'footclient -T nofocus uboot.fish' >/dev/null
# [[sort off]]

function dof
    diff -u $argv | diff-so-fancy
end
funcsave dof >/dev/null

function eat
    loago do eat
    notify-send -t 2000 'ate!'
end
funcsave eat >/dev/null

function get_media_volume
    set volume (playerctl volume 2>/dev/null)
    if test -z "$volume"
        return 1
    end
    math "round($volume * 100)"
end
funcsave get_media_volume >/dev/null
