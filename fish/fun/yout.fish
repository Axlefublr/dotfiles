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
            set -f where_links ~/.local/share/magazine/k
            set -f group k
        case longform
            set -f where_links ~/.local/share/magazine/K
            set -f group K
        case asmr
            set -f where_links ~/.local/share/magazine/i
            set -f group i
    end
    if not test -s $where_links
        notify-send -t 2000 'no stored links'
        return 1
    end
    if test $extra = youtube -o $extra = asmr
        set -f how_many 30
    else
        set -f how_many 1
    end
    set -l stored_links (count (cat $where_links))
    set -l links_to_install (shift.rs $where_links $how_many)
    set -l left (math "max($stored_links - $how_many, 0)")
    notify-send -t 3000 "$left links left"
    for link in $links_to_install
        pueue add -g $group -- "install-yt-video $extra $link"
    end
    _magazine_commit $where_links install
end
funcsave batch-link-downloader >/dev/null

function install-yt-video
    if not test "$argv[1..2]"
        return 1
    end

    set -l extra $argv[1]
    set -l link $argv[2]
    # set -l file (mktemp /dev/shm/install-yt-video.XXXXXX)

    yt ~/vid/$extra \
        # --print-to-file "%(channel)s — %(title)s" $file \
        $link
    # notify-send -t 3000 "downloaded: $(cat $file)"
    # rm -fr $file
end
funcsave install-yt-video >/dev/null

function yt
    yt-dlp \
        --proxy (cat ~/.local/share/magazine/p)[1] \
        -o "$argv[1]/%(channel)s — %(title)s — ;%(id)s;.%(ext)s" \
        $argv[2..]
end
funcsave yt >/dev/null
