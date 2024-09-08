#!/usr/bin/env fish

if pidof xremap &>/dev/null
    killall xremap
end
xremap --mouse ~/prog/dotfiles/xremap.yml &>/tmp/log/user.txt & disown
notify-send -t 2000 'restarted xremap'
sleep 2
xset r rate 130 45 &>/tmp/log/xset.txt
setxkbmap -layout us,ru &>/tmp/log/user.txt
notify-send -t 2000 'applied xset'
