#!/usr/bin/env fish

ffmpeg -framerate 30 -f x11grab -i :0.0 \
    -video_size 1920x1080 \
    -pix_fmt +yuv420p -vf scale='-2:1080' \
    -movflags +faststart \
    -preset slower -y ~/vid/rec.mp4
