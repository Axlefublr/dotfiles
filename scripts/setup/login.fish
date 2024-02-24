#!/usr/bin/env fish

if test -d /tmp/log
	return 1
else
	mkdir -p /tmp/log
end

xremap --mouse ~/prog/dotfiles/xremap/xremap.yml &> /tmp/log/xremap.txt & disown
ydotoold &> /tmp/log/ydotoold.txt & disown
# ollama serve &> /tmp/log/ollama.txt & disown
picom &> /tmp/log/picom.txt & disown
gromit-mpx -o 1 -k "none" -u "none" &> /tmp/log/gromit.txt & disown
clipmenud &> /tmp/log/clipmenu.txt & disown
xset s off -dpms &> /tmp/log/xset.txt
redshift -O 5600 &> /tmp/log/redshift.txt

kitty -T meow & disown
kitty -T timer & disown
kitty -T content -d ~/Videos/content ranger & disown

# code &> /tmp/log/vscode.txt & disown
# win_wait 'code\.Code — main - vscode' 0.1 0 50
kitty --hold -d ~/prog/dotfiles nvim & disown
kitty -d ~/prog/dotfiles & disown
# set other_vscodes (win_wait_except 'main - vscode' 'code.Code' 0.1 0 50)
# move_all 9 $other_vscodes

vivaldi-stable --force-dark-mode &> /tmp/log/vivaldi.txt & disown
set vivaldis (win_wait 'Vivaldi-stable' 0.1 5 200)
move_all 2 $vivaldis
set discord (win_wait 'Vivaldi-stable — .*(Discord|Mastodon|Messenger)' 0.1 0 50)
move_all 5 $discord
set youtube (win_wait 'Vivaldi-stable — .*YouTube' 0.1 0 50)
move_all 7 $youtube

anki &> /tmp/log/anki.txt & disown
set ankis (win_wait 'anki\.Anki' 0.1 0 50)
move_all 8 $ankis

notify-send -t 2000 'spotify'
loopuntil is_internet 0.5 0 60
spotify-launcher -v &> /tmp/log/spotify.txt & disown

notify-sent -t 2000 'xwaaa'
sleep 10
xwaaa

notify-send -t 2000 'logged in'
