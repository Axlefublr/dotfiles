#!/usr/bin/env fish

if test -d /tmp/log
    return 1
else
    mkdir -p /tmp/log
end

for script in ~/prog/dotfiles/scripts/widget_update/*.fish
    $script 2>>/tmp/log/user.txt & disown
end

ydotoold 2>>/tmp/log/user.txt & disown
# ollama serve 2>>/tmp/log/user.txt & disown
picom 2>>/tmp/log/user.txt & disown
gromit.fish 2>>/tmp/log/user.txt & disown
copyq 2>>/tmp/log/user.txt & disown
xset s off -dpms 2>>/tmp/log/user.txt
redshift -O 5700 2>>/tmp/log/user.txt
playerctld daemon

xrestart.fish

kitty -T editor -d ~/prog/dotfiles --hold helix . 2>>/tmp/log/user.txt & disown
kitty -T men 2>>/tmp/log/user.txt & disown
kitty -T oil-content -d ~/vid/content --hold fish -c l 2>>/tmp/log/user.txt & disown

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

RUST_LOG=debug axleizer &>/tmp/log/axleizer.txt & disown

notify-send -t 2000 spotify
loopuntil is_internet 0.5 0 60
# spotify-launcher -v 2>>/tmp/log/user.txt & disown

notify-send -t 0 'logged in'
ignore_urgencies
