#!/usr/bin/env fish

wf-recorder -Dyf ~/i/s/original.mp4
ffmpeg_compress ~/i/s/original.mp4 ~/i/s/compressed.mp4 -preset slow -crf 21 -b:v 2M -maxrate 3M -bufsize 4M -b:a 96k
