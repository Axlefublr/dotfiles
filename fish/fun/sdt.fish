#!/usr/bin/env fish

function systemd_minute
    set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
    if test "$notifications"
        printf %s\n $notifications >~/.local/share/magazine/4
    else
        truncate -s 0 ~/.local/share/magazine/4
    end
    _magazine_commit ~/.local/share/magazine/4 'gh notifs'
    return 0
end
funcsave systemd_minute >/dev/null

function systemd_ten_minutes
end
funcsave systemd_ten_minutes >/dev/null

function systemd_wake
end
funcsave systemd_wake >/dev/null

function systemd_wallpaper
    set -l last_ran (cat ~/.cache/mine/wallpaper-lockfile)
    set -l current_time (date +%s)
    if test "$last_ran" && test "$last_ran" -eq $current_time
        return
    end
    randomize-wallpaper.fish
    echo $current_time >~/.cache/mine/wallpaper-lockfile
end
funcsave systemd_wallpaper >/dev/null
