#!/usr/bin/env fish

if test -d /tmp/log
    return 1
else
    mkdir -p /tmp/log
end

picom 2>>/tmp/log/user.txt & disown
redshift -O 5700 2>>/tmp/log/user.txt
xset s off -dpms 2>>/tmp/log/user.txt
xrestart.fish

kitty -T editor -d ~/prog/dotfiles --hold helix 2>>/tmp/log/user.txt & disown
kitty -T men 2>>/tmp/log/user.txt & disown
kitty -T oil-content -d ~/vid/content --hold fish -c yazi 2>>/tmp/log/user.txt & disown

for script in ~/prog/dotfiles/scripts/widget_update/*.fish
    $script 2>>/tmp/log/user.txt & disown
end

vivaldi-stable --force-dark-mode 2>>/tmp/log/user.txt & disown
anki 2>>/tmp/log/user.txt & disown
set vivaldis (win_wait 'Vivaldi-stable' 0.1 5 200)
move_all 2 $vivaldis
set discord (win_wait 'Vivaldi-stable — .*(Discord|Mastodon|Messenger)' 0.1 0 50)
move_all 5 $discord
set youtube (win_wait 'Vivaldi-stable — .*YouTube' 0.1 0 50)
move_all 7 $youtube
set spotify (win_wait 'Vivaldi-stable — .*Spotify' 0.1 0 50)
move_all 7 $spotify
set ankis (win_wait 'anki\.Anki' 0.1 0 50)
move_all 8 $ankis

ydotoold 2>>/tmp/log/user.txt & disown
# ollama serve 2>>/tmp/log/user.txt & disown
gromit.fish 2>>/tmp/log/user.txt & disown
copyq 2>>/tmp/log/user.txt & disown
playerctld daemon
RUST_LOG=debug axleizer &>/tmp/log/axleizer.txt & disown

# notify-send -t 2000 spotify
# loopuntil is_internet 0.5 0 60
# spotify-launcher -v 2>>/tmp/log/user.txt & disown

notify-send -t 0 'logged in'
ignore_urgencies
