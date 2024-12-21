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

kitty -T editor -d ~/prog/dotfiles --hold 'fish -ic helix' 2>>/tmp/log/user.txt & disown
# kitty -T men 2>>/tmp/log/user.txt & disown
kitty -T oil-content -d ~/vid --hold 'fish -ic yazi-cd' 2>>/tmp/log/user.txt & disown

for script in ~/prog/dotfiles/scripts/services/*.fish
    $script 2>>/tmp/log/user.txt & disown
end

firefox 2>>/tmp/log/user.txt & disown
anki 2>>/tmp/log/user.txt & disown
set ankis (win_wait 'anki\.Anki' 0.1 0 50)
move_all 8 $ankis

ydotoold 2>>/tmp/log/user.txt & disown
# ollama serve 2>>/tmp/log/user.txt & disown
gromit.fish 2>>/tmp/log/user.txt & disown
copyq 2>>/tmp/log/user.txt & disown
playerctld daemon
axleizer &>/tmp/log/axleizer.txt & disown

# notify-send -t 2000 spotify
# loopuntil is_internet 0.5 0 60
# spotify-launcher -v 2>>/tmp/log/user.txt & disown

notify-send -t 0 'logged in'
ignore_urgencies
