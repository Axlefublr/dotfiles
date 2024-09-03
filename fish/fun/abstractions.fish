#!/usr/bin/env fish

alias --save logout "killall xremap ; awesome-client 'awesome.quit()'" >/dev/null
alias --save ubootf 'wmctrl -s 13 ; kitty -T uboot fish -c uboot' >/dev/null
alias --save screen_off 'xset dpms force "off"' >/dev/null

alias --save get_capslock "xset -q | string match -gr 'Caps Lock:\\s* (off|on)'" >/dev/null
alias --save toggle_layout 'xkblayout-state set +1 ; widget_update update_layout Layout' >/dev/null
alias --save get_layout 'xkblayout-state print "%n"' >/dev/null
function update_layout
    set layout (get_layout)
    set capslock (get_capslock)
    if test $layout = English
        if test $capslock = on
            echo ENG
        else
            echo eng
        end
    else if test $layout = Russian
        if test $capslock = on
            echo RUS
        else
            echo rus
        end
    else
        echo idk
    end
end
funcsave update_layout >/dev/null

alias --save get_internet 'nmcli radio wifi' >/dev/null
function update_wifi
    set is_on (get_internet)
    if test $is_on = disabled
        echo ''
        return 0
    else
        get_internet_connection
    end
end
funcsave update_wifi >/dev/null

alias --save get_internet_connection 'nmcli networking connectivity check' >/dev/null
alias --save disable_internet 'nmcli radio wifi off' >/dev/null
alias --save enable_internet 'nmcli radio wifi on' >/dev/null
alias --save restart_internet 'disable_internet ; enable_internet' >/dev/null
function toggle_internet
    if test (get_internet) = enabled
        disable_internet
        widget_update update_wifi Wifi
    else
        enable_internet
        widget_update update_wifi Wifi
    end
end
funcsave toggle_internet >/dev/null

alias --save media_state 'playerctl status' >/dev/null
function update_media_state
    set state (media_state 2>/dev/null)
    if test -z "$state"
        return 1
    end
    if test $state = Paused
        echo '󰏤'
    else if test $state = Playing
        echo '󰐊'
    else if test $state = Stopped
        echo '󰓛'
    else
        echo ''
    end
end
funcsave update_media_state >/dev/null

alias --save media_next 'playerctl next' >/dev/null
alias --save media_prev 'playerctl previous' >/dev/null
alias --save media_position 'playerctl position' >/dev/null
alias --save ms media_position >/dev/null
function get_media_volume
    set volume (playerctl volume 2>/dev/null)
    if test -z "$volume"
        return 1
    end
    math "round($volume * 100)"
end
funcsave get_media_volume >/dev/null

function set_media_volume
    playerctl volume "$argv"
    widget_update get_media_volume Media_volume
end
funcsave set_media_volume >/dev/null

function toggle_media
    playerctl play-pause
    widget_update update_media_state Media_state
end
funcsave toggle_media >/dev/null

function get_media_time
    playerctl metadata --format '{{duration(position)}}'
end
funcsave get_media_time >/dev/null

function get_media_player
    playerctl metadata --format '{{playerName}}'
end
funcsave get_media_player >/dev/null

function get_media_title
    begin
        playerctl metadata --format '{{artist}}'
        playerctl metadata --format '{{title}}'
    end | string join ' — '
end
funcsave get_media_title >/dev/null

function ml
    media_position "$argv-"
end
funcsave ml >/dev/null

function mm
    media_position "$argv+"
end
funcsave ml >/dev/null

alias --save get_volume 'pactl get-sink-volume @DEFAULT_SINK@ | string match -rg \'Volume: .*: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' >/dev/null
alias --save toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle $argv ; awesome-client "Muteness_wu()"' >/dev/null
alias --save get_mute 'pactl get-sink-mute @DEFAULT_SINK@ | string match -gr "Mute: (no|yes)"' >/dev/null

alias --save get_mic_volume 'pactl get-source-volume @DEFAULT_SOURCE@ | string match -rg \'Volume: [\\w-]+: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' >/dev/null
alias --save toggle_mic_mute 'pactl set-source-mute @DEFAULT_SOURCE@ toggle $argv ; awesome-client "Mic_muteness_wu()"' >/dev/null
alias --save get_mic_mute 'pactl get-source-mute @DEFAULT_SOURCE@ | string match -gr "Mute: (no|yes)"' >/dev/null

function set_volume
    pactl set-sink-volume @DEFAULT_SINK@ "$argv%"
    widget_update get_volume Volume
end
funcsave set_volume >/dev/null

function set_mic_volume
    pactl set-source-volume @DEFAULT_SOURCE@ "$argv%"
    widget_update get_mic_volume Mic_volume
end
funcsave set_mic_volume >/dev/null

function bl_reconnect
    if not test "$argv"
        echo 'missing bluetooth device MAC address' >&2
        return 1
    end
    bluetoothctl disconnect $argv
    bluetoothctl connect $argv
end
funcsave bl_reconnect >/dev/null

function get_bluetooth
    bluetoothctl show | string match -gr 'Powered: (no|yes)'
end
funcsave get_bluetooth >/dev/null

function get_bluetooth_connected
    for device in (bluetoothctl devices | string match -gr 'Device (\\S+) [^-]+$')
        bluetoothctl info $device | rg 'Connected: yes'
    end
end
funcsave get_bluetooth_connected >/dev/null

function get_bluetooth_connected_device
    bluetoothctl info $argv | string match -gr 'Connected: (yes|no)'
end
funcsave get_bluetooth_connected_device >/dev/null

function update_bluetooth
    set is_on (get_bluetooth)
    if test "$is_on" = no
        echo ''
        return 0
    end

    set connection (get_bluetooth_connected 2> /dev/null)
    if test -z "$connection"
        echo disconnected
        return
    end

    set battery (bl_battery $head 2>/dev/null)
    if test -z "$battery"
        echo connected
        return 0
    end

    if test "$battery" -gt 75
        echo connected full
    else if test "$battery" -gt 50
        echo connected
    else if test "$battery" -gt 25
        echo connected low
    else
        echo connected critical
    end
end
funcsave update_bluetooth >/dev/null

function toggle_compositor
    if pidof picom
        if pidof gromit-mpx
            killall gromit-mpx
        end
        killall picom
    else
        picom &>/tmp/log/picom.txt & disown
        if pidof gromit-mpx
            killall gromit-mpx
        end
        gromit &>/tmp/log/gromit.txt & disown
    end
end
funcsave toggle_compositor >/dev/null

function update_compositor
    if pidof picom &>/dev/null
        echo ''
    else
        echo no
    end
end
funcsave update_compositor >/dev/null

function is_internet
    set -l response (nmcli networking connectivity check)
    if test $response = full
        return 0
    else if test $response = none
        return 1
    else if test $response = limited
        return 1
    else
        echo "unexpected response ($response) from `nmcli networking connectivity`" &>/dev/stderr
        return 1
    end
end
funcsave is_internet >/dev/null

function get_hunger
    set times (loago list -m eat | string match -gr 'eat — \\d+d (\\d+)h (\\d+)m')
    set hours $times[1]
    set minutes $times[2]
    if test $hours -eq 0
        printf $minutes
        return
    end
    printf $hours':'$minutes
end
funcsave get_hunger >/dev/null

function filter_mature_tasks
    function if_print
        test "$argv[1]" -ge $argv[3] && echo "$argv[2] — $(math $argv[1] - $argv[3])" || printf ''
    end
    set oldest (loago list -e razor -e rilter -e eat | awk '$3 > 4')
    for task in $oldest
        set -l match (string match -gr '^(\\S+)\\s+— (\\d+)$' $task)
        set -l name $match[1]
        set -l days $match[2]
        switch $name
            case filter rilter
                if_print $days $name 60
            case vacuum floor dust
                if_print $days $name 6
            case towels lamp nose wash music
                if_print $days $name 7
            case cloths fscrub bscrub liked cazor audio brushes
                if_print $days $name 10
            case nails
                if_print $days $name 14
            case wilter bottle photos
                if_print $days $name 15
            case razor
                if_print $days $name 25
            case tails iso keyboard
                if_print $days $name 30
            case '*'
                echo "$name — $(math $days - 5)"
        end
    end | sort -g -k 3 -r | column -t -s '—' -o '—'
end
funcsave filter_mature_tasks >/dev/null

function mature_tasks_line
    filter_mature_tasks | awk '{print $1}' | string join ' '
end
funcsave mature_tasks_line >/dev/null

function get_oldest_task
    clorange task-count increment
    set tasks (filter_mature_tasks)
    set available (count $tasks)
    if test $available -eq 0
        return 0
    end
    set index (clorange task-count show)
    if test $index -gt $available
        clorange task-count set 1
        set index 1
    end
    set picked (string match -gr '^(\\S+)\\s+— (\\d+)$' $tasks[$index] | string join ' ')
    printf $picked
end
funcsave get_oldest_task >/dev/null

function widget_update
    set output ($argv[1..-2])
    set previous (cat /dev/shm/$argv[-1]_f 2> /dev/null || echo 'ඞ') # yes, I'm using the amogus character as a sentinel value. what about it?
    if test "$output" != "$previous"
        printf $output >/dev/shm/$argv[-1]_f
        awesome-client $argv[-1]'_wu()'
    end
    sleep 0.2
end
funcsave widget_update >/dev/null

function update_anki
    if test (curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "is:due" } }' 2> /dev/null | jq .result.[] 2> /dev/null | count) -gt 0
        if not test "$argv"
            clorange anki increment
        end
        if test (clorange anki show) -ge 6
            echo due
        end
    else
        clorange anki reset
    end
end
funcsave update_anki >/dev/null

function sync_anki
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave sync_anki >/dev/null

function disk_usage
    df -h /dev/nvme0n1p2 | tail -n 1 | awk '{print $5}' | string replace '%' '' | string collect
end
funcsave disk_usage >/dev/null

function bl_battery
    bluetoothctl info $argv | string match -gr 'Battery Percentage: \\S+ \\((\\d+)\\)'
end
funcsave bl_battery >/dev/null

function git_search_file
    if not test "$argv[1]"
        echo 'the first argument should be the filepath where you want to search for a string' >&2
    end
    if not test "$argv[2]"
        echo 'the second argument and beyond are expected argument(s) to `rg`' >&2
        return 1
    end
    set commits (git log --format=format:"%h" -- $argv[1])
    for commit in $commits
        truncate -s 0 /dev/shm/git_search
        git show $commit:$argv[1] 2>/dev/null | rg --color=always $argv[2..] >>/dev/shm/git_search
        and git show --color=always --oneline $commit -- $argv[1] >>/dev/shm/git_search
        if test -s /dev/shm/git_search
            cat /dev/shm/git_search | diff-so-fancy | less
            read -P 'press any key to continue, `q` to quit: ' -ln 1 continue
            if test "$continue" = q
                break
            end
        end
    end
end
funcsave git_search_file >/dev/null

function git_search
    if not test "$argv[1]"
        echo 'missing arguments for `rg`' >&2
        return 1
    end
    set commits (git log --format=format:"%h")
    for commit in $commits
        truncate -s 0 /dev/shm/git_search
        set files (git show --format=format:'' --name-only $commit)
        set -l matched_files
        for file in $files
            git show $commit:$file 2>/dev/null | rg --color=always $argv >>/dev/shm/git_search
            and set matched_files $matched_files $file
            and echo (set_color '#e491b2')$file(set_color normal) >>/dev/shm/git_search
        end
        if test "$matched_files"
            git show --color=always --oneline $commit -- $matched_files >>/dev/shm/git_search
        end
        if test -s /dev/shm/git_search
            cat /dev/shm/git_search | diff-so-fancy | less
            read -P 'press any key to continue, `q` to quit: ' -ln 1 continue
            if test "$continue" = q
                break
            end
        end
    end
end
funcsave git_search >/dev/null

function igrai
    if not test "$argv[1]"
        echo "no sound effect path provided" >&2
        return 1
    end
    set path $argv[1]
    if test "$argv[2]"
        set volume $argv[2]
    else
        set volume 100
    end
    if test "$volume" -gt 100
        set volume 100
    else if test "$volume" -lt 0
        set volume 0
    end
    set volume (math "floor($volume * 655.36)")
    paplay $path --volume $volume
end
funcsave igrai >/dev/null

function toggle_screen_record
    if matches 'kitty — screen_record' &>/dev/null
        kitten @ --to unix:/tmp/screen_record_kitty_socket signal-child SIGINT
    else
        kitty -T screen_record --listen-on unix:/tmp/screen_record_kitty_socket screen_record.fish
    end
end
funcsave toggle_screen_record >/dev/null
