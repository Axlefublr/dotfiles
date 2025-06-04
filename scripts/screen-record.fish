#!/usr/bin/env fish

wf-recorder -Dyf ~/iwm/sco/original.mp4
ffmpeg_compress ~/iwm/sco/original.mp4 ~/iwm/sco/compressed.mp4 -preset slow -crf 21 -b:v 2M -maxrate 3M -bufsize 4M -b:a 96k
