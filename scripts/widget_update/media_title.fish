#!/usr/bin/env fish

while true
    set output "$(get_media_title)"
    set previous "$(cat ~/.local/share/magazine/t || echo 'ඞ')"
    if test $output != $previous
        printf $output >~/.local/share/magazine/t
    end
    set output "$(playerctl metadata --format '{{album}}')"
    set previous "$(cat ~/.local/share/magazine/b || echo 'ඞ')"
    if test $output != $previous
        printf $output >~/.local/share/magazine/b
    end
    if test "$(cat /dev/shm/Charge_f)" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 1
    end
end &>/dev/null
