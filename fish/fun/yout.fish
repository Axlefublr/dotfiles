#!/usr/bin/env fish

function batch-link-downloader
    set -l extra (begin
        echo youtube
        echo longform
        echo asmr
    end | rofi -dmenu -no-custom 2>/dev/null)
    test $status -ne 0 && return 1
    switch $extra
        case youtube
            set -f group k
        case longform
            set -f group K
        case asmr
            set -f group i
    end
    set -l links (ypoc | sttr extract-url)
    if not test "$links"
        notify-send -t 2000 'no copied links'
        return 1
    end
    for link in $links
        pueue add -g $group -- "install-yt-video $extra $link"
    end
end
funcsave batch-link-downloader >/dev/null

function install-yt-video
    if not test "$argv[1..2]"
        return 1
    end

    set -l extra $argv[1]
    set -l link $argv[2]

    yt ~/vid/$extra $link
end
funcsave install-yt-video >/dev/null

function yt
    yt-dlp \
        --proxy (cat ~/.local/share/magazine/p)[1] \
        -o "$argv[1]/%(channel)s — %(title)s — ;%(id)s;.%(ext)s" \
        $argv[2..]
end
funcsave yt >/dev/null
