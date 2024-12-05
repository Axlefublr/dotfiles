#!/usr/bin/env fish

if not test "$argv[1..2]"
    return 1
end

set -l extra $argv[1]
set -l link $argv[2]

set -l file (mktemp /dev/shm/install_yt_video.XXXXXX)
set -l clipboard (xclip -selection clipboard -o)
kitty -T link-download yt-dlp.fish \
    /mnt/usb/$extra \
    --print-to-file "%(channel)s — %(title)s" $file \
    $link
notify-send -t 3000 "downloaded: $(cat $file)"
rm -fr $file
not_matches 'kitty — link-download' && notify-send -t 5000 'downloads finished'
