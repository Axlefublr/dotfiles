#!/usr/bin/env fish

wf-recorder -Dyf ~/i/s/original.mkv
ffmpeg -y -i ~/i/s/original.mkv -c:v libx264 -preset slow -crf 21 -b:v 2M -maxrate 3M -bufsize 4M -c:a aac -b:a 96k -movflags +faststart ~/i/s/compressed.mp4
