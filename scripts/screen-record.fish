#!/usr/bin/env fish

wf-recorder -Dyf ~/.cache/mine/screen-recording-original.mkv
ffmpeg -y -i ~/.cache/mine/screen-recording-original.mkv -c:v libx264 -preset slow -crf 21 -b:v 2M -maxrate 3M -bufsize 4M -c:a aac -b:a 96k -movflags +faststart ~/.cache/mine/screen-recording-compressed.mp4
ln -sf ~/.cache/mine/screen-recording-compressed.mp4 ~/z.mp4
