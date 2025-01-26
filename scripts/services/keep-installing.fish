#!/usr/bin/env fish

while true
    inotifywait -q -e close_write -e move_self ~/.local/share/magazine/k
    set -l link_to_install (shift.rs ~/.local/share/magazine/k)
    if test "$link_to_install"
        pueue add -g k -- "install-yt-video youtube $link"
    end
end
