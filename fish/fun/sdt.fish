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

function systemd_mandb
    while true
        cat ~/fes/uviw/afen/sudo | sudo -S mandb
        man.nu men
        inotifywait -e move_self -e delete -e create -r (manpath | string split ':')
    end
end
funcsave systemd_mandb >/dev/null

function systemd_download_drop
    rsync (recent-modified.nu ~/wlx/tabs) ~/fes/jiro/tabs.json
    mv -f (recent-modified.nu ~/wlx/sidebery-data-\*.json) ~/fes/jiro/sidebery.json
    mv -f (recent-modified.nu ~/wlx/FoxyProxy_\*.json) ~/fes/jiro/foxyproxy.json
    mv -f (recent-modified.nu ~/wlx/Historia_\*.txt) ~/fes/jiro/historia.txt
    mv -f (recent-modified.nu ~/wlx/stylus-\*.json) ~/fes/jiro/stylus.json
    mv -f (recent-modified.nu ~/wlx/my-ublock-backup_\*.txt) ~/fes/jiro/ublock.txt
    mv -f ~/wlx/auto-tab-discard-preferences.json ~/fes/jiro/auto-tab-discard.json

    rm -fr (quiet-glob.nu ~/wlx/sidebery-data-\*.json)
    rm -fr (quiet-glob.nu ~/wlx/FoxyProxy_\*.json)
    rm -fr (quiet-glob.nu ~/wlx/Historia_\*.txt)
    rm -fr (quiet-glob.nu ~/wlx/stylus-\*.json)
    rm -fr (quiet-glob.nu ~/wlx/my-ublock-backup_\*.txt)
end
funcsave systemd_download_drop >/dev/null
