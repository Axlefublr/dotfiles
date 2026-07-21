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
            set -l skip_prompt false
            set -l passed_time (
                set -l intermediate_time $time
                if test (string sub -s -1 -- $time) = '!'
                    set intermediate_time (string sub -e -1 -- $time)
                    set skip_prompt true
                end
                if not string match -qe ':' -- $intermediate_time
                    echo $intermediate_time
                else
                    set -l current_hour (date +%H)
                    set -l current_minute (date +%M)
                    set -l the (string split ':' -- $intermediate_time)
                    set -l passed_hour $the[1]
                    set -l passed_minute $the[2]
                    if test $current_hour -gt $passed_hour -o \( $current_hour -eq $passed_hour -a $current_minute -ge $passed_minute \)
                        echo "$(date -d 'today + 1 day' '+%Y-%m-%d') $intermediate_time"
                    else
                        echo $intermediate_time
                    end
                end
            )
            termdown -BW $passed_time
            # not using the foot-configured bell here because I *usually* don't want infinitely staying notifications on bell, but *can* afford them here thanks to custom fancy logic
            if not $skip_prompt
                tit "⏰ $title"
                na -c "niri msg -j windows | from json | where app_id starts-with foot | where title == '⏰ $title' | get id | each { niri msg action set-window-urgent --id \$in } | ignore"
            end
            notify-send -t 0 -- "⏰ $title"
            clear
            if not $skip_prompt
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
            end
            break
        end
    end
    if not $argv[1]
        break
    end
end
