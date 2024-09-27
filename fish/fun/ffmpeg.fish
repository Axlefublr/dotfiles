#!/usr/bin/env fish

function ffcut --description='Take from START to END — INPUT OUTPUT START END'
    ffmpeg -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
    bell
end
funcsave ffcut >/dev/null

function ffcut3 --description='Take from START to END and convert into mp3 — INPUT OUTPUT (no ext) START END'
    ffmpeg -i $argv[1] -ss $argv[3] -to $argv[4] -map_metadata -1 -vn -acodec libmp3lame $argv[2].mp3
    bell
end
funcsave ffcut3 >/dev/null

function ffcutfrom --description='Take from START until EOF — INPUT OUTPUT START'
    ffmpeg -i $argv[1] -ss $argv[3] -c:a copy $argv[2]
    bell
end
funcsave ffcutfrom >/dev/null

function ffcutfrom3 --description='Take from START until EOF and convert to mp3 — INPUT OUTPUT (no ext) START'
    ffmpeg -i $argv[1] -ss $argv[3] -map_metadata -1 -vn -acodec libmp3lame $argv[2].mp3
    bell
end
funcsave ffcutfrom3 >/dev/null

function ffcutto --description='Take from SOF to END — INPUT OUTPUT END'
    ffmpeg -i $argv[1] -ss 00:00 -to $argv[3] -c:a copy $argv[2]
    bell
end
funcsave ffcutto >/dev/null

function ffcutto3 --description='Take from SOF to END and convert to mp3 — INPUT OUTPUT (no ext) END'
    ffmpeg -i $argv[1] -ss 00:00 -to $argv[3] -map_metadata -1 -vn -acodec libmp3lame $argv[2].mp3
    bell
end
funcsave ffcutto3 >/dev/null

function ffcutout --description='Cut out (remove) from START to END — INPUT OUTPUT START END'
    ffmpeg -i $argv[1] -to $argv[3] -c:a copy input1.mp4
    ffmpeg -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
    ffcombine input1.mp4 input2.mp4 $argv[2]
    rm input1.mp4 input2.mp4
    bell
end
funcsave ffcutout >/dev/null

function ffcompress --description='INPUT OUTPUT'
    ffmpeg -i $argv[1] -c:v libx264 -crf 28 -preset veryslow -c:a aac -b:a 64k -movflags +faststart $argv[2]
    bell
end
funcsave ffcompress >/dev/null

function ffcombine --description='INPUT1 INPUT2 OUTPUT'
    ffmpeg -i $argv[1] -c copy -bsf:v h264_mp4toannexb -f mpegts input1.ts
    ffmpeg -i $argv[2] -c copy -bsf:v h264_mp4toannexb -f mpegts input2.ts
    echo "file 'input1.ts'
    file 'input2.ts'" >inputs.txt
    ffmpeg -f concat -safe 0 -i inputs.txt -c copy $argv[3]
    rm inputs.txt input1.ts input2.ts
    bell
end
funcsave ffcombine >/dev/null

function ffto-mp3
    ffmpeg -i $argv[1] -map_metadata -1 -vn -acodec libmp3lame (path change-extension mp3 $argv[1])
end
funcsave ffto-mp3 >/dev/null

function mp43 --description='All mp4 here into mp3'
    for file in (ls)
        ffto-mp3 $file
        trash-put $file
    end
    bell
end
funcsave mp43 >/dev/null

function rename-all-random # MOVE: to somewhere
    for file in (ls)
        mv $file (uclanr -j - 3)(path extension $file)
    end
end
funcsave rename-all-random >/dev/null

function remove-metadata
    ffmpeg -i $argv[1] -c:a copy -c:v copy -map_metadata -1 _$argv[1]
    mv -f _$argv[1] $argv[1]
end
funcsave remove-metadata >/dev/null
