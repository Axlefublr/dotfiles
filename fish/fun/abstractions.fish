#!/usr/bin/env fish

alias --save logout "killall xremap ; awesome-client 'awesome.quit()'" >/dev/null
alias --save ukboot 'alacritty -T uboot -e fish -c uboot' >/dev/null
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
funcsave get_media_title > /dev/null

function ml
    media_position "$argv-"
end
funcsave ml >/dev/null

function mm
    media_position "$argv+"
end
funcsave ml >/dev/null

alias --save get_volume 'pactl get-sink-volume @DEFAULT_SINK@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' >/dev/null
alias --save toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle $argv ; awesome-client "Muteness_wu()"' >/dev/null
alias --save get_mute 'pactl get-sink-mute @DEFAULT_SINK@ | string match -gr "Mute: (no|yes)"' >/dev/null

alias --save get_mic_volume 'pactl get-source-volume @DEFAULT_SOURCE@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' >/dev/null
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
    if test $is_on = no
        echo ''
        return 0
    end
    set connection (get_bluetooth_connected 2> /dev/null)
    if test -z $connection
        echo disconnected
    else
        echo connected
    end
end
funcsave update_bluetooth >/dev/null

function toggle_compositor
    if pidof picom
        if pidof gromit-mpx
            killall gromit-mpx
        end
        killall picom
        widget_update update_compositor Compositor
    else
        picom &>/tmp/log/picom.txt & disown
        widget_update update_compositor Compositor
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

function emoji_picker_clipboard
    kitty -T emoji-picker --start-as maximized sh -c "kitty +kitten unicode_input --tab $argv[1] > /dev/shm/unicode_input"
    if test -s /dev/shm/unicode_input
        cat /dev/shm/unicode_input | xclip -r -selection clipboard
    end
end
funcsave emoji_picker_clipboard >/dev/null

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
    set oldest (loago list | rg -v 'eat' | awk '$3 > 4')
    for task in $oldest
        set -l match (string match -gr '^(\\S+)\\s+— (\\d+)$' $task)
        set -l name $match[1]
        set -l days $match[2]
        if test \( $name = filter -a $days -gt 45 \) \
                -o \( $name = towels -a $days -ge 7 \) \
                -o \( $name = lamp -a $days -ge 7 \) \
                -o \( $name = nose -a $days -ge 7 \) \
                -o \( $name = cazor -a $days -ge 7 \) \
                -o \( $name = cloths -a $days -ge 10 \) \
                -o \( $name = fscrub -a $days -ge 10 \) \
                -o \( $name = bscrub -a $days -ge 10 \) \
                -o \( $name = nails -a $days -ge 15 \) \
                -o \( $name = wilter -a $days -ge 15 \) \
                -o \( $name = bottle -a $days -ge 15 \) \
                -o \( $name = razor -a $days -ge 20 \) \
                -o \( $name = tails -a $days -ge 30 \)
            echo $task
        end
    end
end
funcsave filter_mature_tasks >/dev/null

function get_oldest_task
    clorange task-count increment
    set tasks (filter_mature_tasks)
    set available (count $tasks)
    if test $available -eq 0
        printf 'done!'
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
    set output ($argv[1])
    set previous (cat /dev/shm/$argv[2]_f 2> /dev/null || echo 'ඞ') # yes, I'm using the amogus character as a sentinel value. what about it?
    if test "$output" != "$previous"
        printf $output >/dev/shm/$argv[2]_f
        awesome-client $argv[2]'_wu()'
    end
    sleep 0.2
end
funcsave widget_update >/dev/null

function update_anki
    set due (curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "is:due" } }' 2> /dev/null | jq .result.[] 2> /dev/null | count)
    if test -z $due
        echo ''
        return 0
    else
        echo $due
    end
end
funcsave update_anki >/dev/null
