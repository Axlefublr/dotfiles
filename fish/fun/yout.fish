#!/usr/bin/env fish

function yteet_clipboard
    set -l links (wl-paste -n | sttr extract-url)
    if not test "$links"
        notify-send -t 2000 'no copied links'
        return 1
    end
    for link in $links
        pueue add -g network -- "yteet $link"
        notify-send "start $link"
    end
end
funcsave yteet_clipboard >/dev/null

function yteet
    not test "$argv" && return 1
    yt ~/iwm/voe/youtube $argv
end
funcsave yteet >/dev/null

function yt
    yt-dlp \
        --proxy http://127.0.0.1:8118 \
        -o "$argv[1]/%(channel)s — %(title)s — ;%(id)s;.%(ext)s" \
        $argv[2..]
end
funcsave yt >/dev/null
