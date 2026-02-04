#!/usr/bin/env fish

function colorize_prompt
    set_color -o normal
    echo -n dispositions:
    set_color normal
end

set -l dispositions
for file in $argv
    clear
    path basename -E $file
    set -l ffprobe_output "$(ffprobe $file 2>&1)"
    echo $ffprobe_output | rg --color=never -A 2 'Audio:|Subtitle:' |
        na --stdin -c 'use offshoot.nu parse_ffprobe ; $in | parse_ffprobe'
    read -c "$(cat ~/.cache/mine/disposition-response 2>/dev/null)" -p colorize_prompt -l response || return
    echo $response >~/.cache/mine/disposition-response
    set dispositions $dispositions $response
end

confirm.rs 'continue?' '[j]es' '[k]o' | read -l response
test $response = j || return

set -l flags
for disposition in $dispositions
    set -l flag_group
    # starts with ! → reset disposition
    # doesn't → set default disposition
    set -l individuals (string split ' ' $disposition)
    for individual in $individuals
        set -l stream (string trim -c . $individual)
        if test $status = 0
            set -a flag_group -disposition:$stream 0
        else
            set -a flag_group -disposition:$stream default
        end
    end
    set -a flags "$flag_group"
end

set -l index 0
for file in $argv
    set index (math $index + 1)
    ffmpeg -i $file -map 0 -c copy (string split ' ' -- $flags[$index]) (trail $file converted/█)
end
flourish
