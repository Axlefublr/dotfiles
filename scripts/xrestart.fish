#!/usr/bin/env fish

if pidof xremap &>/dev/null
    killall xremap
end
xremap --mouse ~/prog/dotfiles/xremap.yml &>/tmp/log/xremap.txt & disown
pueue add -d '2 seconds' -- 'xset r rate 135 40 ; setxkbmap -layout us,ru'
