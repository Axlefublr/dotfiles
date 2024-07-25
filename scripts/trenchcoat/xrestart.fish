#!/usr/bin/env fish

if pidof xremap &>/dev/null
    killall xremap
end
xremap --mouse ~/prog/dotfiles/xremap.yml &>/tmp/log/user.txt & disown
notify-send -t 2000 'restarted xremap'
sleep 2
xset r rate 170 35 &>/tmp/log/xset.txt
setxkbmap -layout us,ru -option 'compose:sclk' &>/tmp/log/user.txt
notify-send -t 2000 'applied xset'
