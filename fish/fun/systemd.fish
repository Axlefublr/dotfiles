#!/usr/bin/env fish

function systemd_minute
    set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
    if test "$notifications"
        printf %s\n $notifications >~/.local/share/magazine/4
    else
        truncate -s 0 ~/.local/share/magazine/4
    end
    _magazine_commit ~/.local/share/magazine/4 'gh notifs'
end
funcsave systemd_minute >/dev/null

function systemd_ten_minutes
end
funcsave systemd_ten_minutes >/dev/null
