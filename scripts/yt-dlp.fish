#!/usr/bin/env fish

yt-dlp \
    --proxy (cat ~/.local/share/magazine/p)[1] \
    -o "$argv[1]/%(channel)s — %(title)s — ;%(id)s;.%(ext)s" \
    $argv[2..]
