#!/usr/bin/env fish

argparse D= -- $argv

begin
    if set -q _flag_D
        echo -n $_flag_D
        echo -ne '\0'
    else
        echo -n $PWD
        echo -ne '\0'
    end

    echo -n "$argv"
    echo -ne '\0'
end >~/.local/share/mine/task-scheduler
