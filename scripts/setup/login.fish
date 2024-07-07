#!/usr/bin/env fish

if test -d /tmp/log
    return 1
else
    mkdir -p /tmp/log
end

for script in ~/prog/dotfiles/scripts/widget_update/*.fish
    $script 2>>/tmp/log/user.txt & disown
end

xremap --mouse ~/prog/dotfiles/xremap.yml 2>>/tmp/log/user.txt & disown
ydotoold 2>>/tmp/log/user.txt & disown
# ollama serve 2>>/tmp/log/user.txt & disown
picom 2>>/tmp/log/user.txt & disown
gromit.fish 2>>/tmp/log/user.txt & disown
copyq 2>>/tmp/log/user.txt & disown
xset s off -dpms 2>>/tmp/log/user.txt
redshift -O 5700 2>>/tmp/log/user.txt
playerctld daemon

kitty -T meow 2>>/tmp/log/user.txt & disown
oil.fish ~/vid/content 2>>/tmp/log/user.txt & disown

kitty -T editor -d ~/prog/dotfiles nvim 2>>/tmp/log/user.txt & disown
# win_wait 'neovide — Neovide' 0.5 0 200
# kitty -T terminal -d ~/prog/dotfiles 2>>/tmp/log/user.txt & disown

vivaldi-stable --force-dark-mode 2>>/tmp/log/user.txt & disown
set vivaldis (win_wait 'Vivaldi-stable' 0.1 5 200)
move_all 2 $vivaldis
set discord (win_wait 'Vivaldi-stable — .*(Discord|Mastodon|Messenger)' 0.1 0 50)
move_all 5 $discord
set youtube (win_wait 'Vivaldi-stable — .*YouTube' 0.1 0 50)
move_all 7 $youtube

anki 2>>/tmp/log/user.txt & disown
set ankis (win_wait 'anki\.Anki' 0.1 0 50)
move_all 8 $ankis

# notify-send -t 2000 'spotify'
# loopuntil is_internet 0.5 0 60
# spotify-launcher -v 2>>/tmp/log/user.txt & disown

notify-sent -t 2000 xwaaa
sleep 10
xwaaa

RUST_LOG=debug axleizer &>/tmp/log/axleizer.txt & disown

notify-send -t 0 'logged in'
