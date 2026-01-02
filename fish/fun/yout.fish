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

function yt_audio
    set -l picked (begin
        echo ad
        echo bd
        echo cd
    end | fuzzel -dl 3)
    test "$picked" || return 1
    set -l links (wl-paste -n | sttr extract-url)
    if not test "$links"
        notify-send -t 2000 'no copied links'
        return 1
    end
    for link in $links
        pueue add -g network -- "ytroxy -o ~/iwm/lwkc/$picked/$(uclanr -j - 3).'%(ext)s' $link"
        notify-send "start $link"
    end
end
funcsave yt_audio >/dev/null

function yteet
    not test "$argv" && return 1
    yt ~/iwm/voe/youtube $argv
end
funcsave yteet >/dev/null

function yt
    ytroxy \
        -o "$argv[1]/%(channel)s — %(title)s — ;%(id)s;.%(ext)s" \
        $argv[2..]
end
funcsave yt >/dev/null

alias --save ytroxy 'yt-dlp --proxy http://127.0.0.1:8118' >/dev/null
