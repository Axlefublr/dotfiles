#!/usr/bin/env fish

if test -d /tmp/log
    return 1
else
    mkdir -p /tmp/log
end

redshift -O 5700
xset s off -dpms
playerctld daemon

picom &>/tmp/log/picom.txt & disown
gromit.fish &>/tmp/log/gromit.txt & disown
copyq &>/tmp/log/copyq.txt & disown

xrestart.fish

# pueue add -g s 'RUST_LOG=debug axleizer'

# for script in ~/prog/dotfiles/scripts/services/*.fish
#     pueue add -g s (path basename $script)
# end

kitty -T editor -d ~/prog/dotfiles & disown
kitty -T oil-content -d ~/vid & disown

firefox & disown
anki & disown
set ankis (win_wait 'anki\.Anki' 0.1 0 50)
move_all 8 $ankis

loopuntil is_internet 0.5 0 60
pueue restart -g s

ignore_urgencies
