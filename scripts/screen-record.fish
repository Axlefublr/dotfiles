#!/usr/bin/env fish

touch /tmp/mine/recordilock
echo recording >~/.local/share/mine/waybar-screen-record
wf-recorder -Dyf ~/iwm/sco/original.mp4
echo compressing >~/.local/share/mine/waybar-screen-record
ffmpeg_compress ~/iwm/sco/original.mp4 ~/iwm/sco/compressed.mp4 -preset slow -crf 21 -b:v 2M -maxrate 3M -bufsize 4M -b:a 96k
rm -f /tmp/mine/recordilock
echo copying >~/.local/share/mine/waybar-screen-record
copyl ~/iwm/sco/compressed.mp4
echo >~/.local/share/mine/waybar-screen-record
