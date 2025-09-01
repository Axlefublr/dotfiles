#!/usr/bin/env fish

touch /tmp/mine/recordilock
echo recording >~/.local/share/mine/waybar-screen-record
wf-recorder -Dyf ~/iwm/sco/original.mp4
echo compressing >~/.local/share/mine/waybar-screen-record
ffmpeg -y -i ~/iwm/sco/original.mp4 \
    -an \
    -c:v libx264 -preset medium -crf 21 \
    -movflags +faststart \
    -b:v 3M -maxrate 4.5M -bufsize 6M \
    ~/iwm/sco/compressed.mp4
rm -f /tmp/mine/recordilock
echo copying >~/.local/share/mine/waybar-screen-record
sl.fish ~/iwm/sco/compressed.mp4
echo >~/.local/share/mine/waybar-screen-record
