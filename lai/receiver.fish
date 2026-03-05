#!/usr/bin/env fish

while true
    cat ~/.local/share/mine/task-scheduler | while read -z first
        and read -z second
        echo "env: $first"
        echo "cmd: $second"
    end
end
