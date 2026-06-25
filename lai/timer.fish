#!/usr/bin/env fish

set -l name $argv[1]
if not test "$argv[2..]"
    set -l title "stopwatch $name"
    tit $title
    termdown -BW
    return
end
for time in $argv[2..]
    set -l genre (runner_timer_resolve_genre "$time")
    set -l title "$genre $name $time"
    while true
        tit $title
        notify-send "💣️ $title"
        termdown -BW $time
        # not using the foot-configured bell here because I *usually* don't want infinitely staying notifications on bell, but *can* afford them here thanks to custom fancy logic
        tit "⏰ $title"
        na -c "niri msg -j windows | from json | where app_id starts-with foot | where title == '⏰ $title' | get id | each { niri msg action set-window-urgent --id \$in } | ignore"
        notify-send -t 0 -- "⏰ $title"
        clear
        confirm.rs $title 'pro[j]eed' '[w]rite' '[r]estart' '[q]uit' | read -l input
        for notification_id in (fnottctl list | rg ": ⏰ $title" | string split ': ' | rg -v '^⏰')
            fnottctl dismiss $notification_id
        end
        niri msg action focus-window-previous
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
