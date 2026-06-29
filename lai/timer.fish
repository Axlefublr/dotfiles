#!/usr/bin/env fish

test "$argv[2]" && niri msg action focus-window --id $argv[2]
set -l name $argv[3]
if not test "$argv[4..]"
    set -l title "stopwatch $name"
    tit $title
    termdown -BW
    niri msg action focus-window-previous
    return
end
while true
    for time in $argv[4..]
        set -l genre (resolve_time_counter_genre "$time")
        set -l title "$genre $name $time"
        while true
            tit $title
            notify-send "💣️ $title"
            set -l passed_time (
                if not string match -qe ':' -- $time
                    echo $time
                else
                    set -l current_hour (date +%H)
                    set -l current_minute (date +%M)
                    set -l the (string split ':' -- $time)
                    set -l passed_hour $the[1]
                    set -l passed_minute $the[2]
                    if test $current_hour -gt $passed_hour -o \( $current_hour -eq $passed_hour -a $current_minute -ge $passed_minute \)
                        echo "$(date -d 'today + 1 day' '+%Y-%m-%d') $time"
                    else
                        echo $time
                    end
                end
            )
            termdown -BW $passed_time
            # not using the foot-configured bell here because I *usually* don't want infinitely staying notifications on bell, but *can* afford them here thanks to custom fancy logic
            tit "⏰ $title"
            na -c "niri msg -j windows | from json | where app_id starts-with foot | where title == '⏰ $title' | get id | each { niri msg action set-window-urgent --id \$in } | ignore"
            notify-send -t 0 -- "⏰ $title"
            clear
            confirm.rs $title 'pro[j]eed' '[w]rite' '[r]estart' '[q]uit' | read -l input
            for notification_id in (fnottctl list | rg ": ⏰ $title" | string split ': ' | rg -v '^⏰')
                fnottctl dismiss $notification_id
            end
            niri msg action focus-window-previous &
            wait
            if test "$input" = q
                exit
            else if test "$input" = r
                continue
            else if test "$input" = w
                task $name
            end
            break
        end
    end
    if not $argv[1]
        break
    end
end
