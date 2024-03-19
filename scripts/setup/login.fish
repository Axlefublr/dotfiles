#!/usr/bin/env fish

if test -d /tmp/log
	return 1
else
	mkdir -p /tmp/log
end

xremap --mouse ~/prog/dotfiles/xremap.yml &> /tmp/log/xremap.txt & disown
ydotoold &> /tmp/log/ydotoold.txt & disown
ollama serve &> /tmp/log/ollama.txt & disown
picom &> /tmp/log/picom.txt & disown
gromit-mpx -o 1 -k 'none' -u 'none' &> /tmp/log/gromit.txt & disown
clipster --daemon &> /tmp/log/clipster.txt & disown
xset s off -dpms &> /tmp/log/xset.txt
redshift -O 5700 &> /tmp/log/redshift.txt
playerctld daemon &> /tmp/log/playerctl.txt
for script in ~/prog/dotfiles/scripts/widget_update/*.fish
	$script & disown
end

alacritty -T meow & disown
alacritty -T timer & disown
alacritty -T content -e ranger ~/Videos/content & disown

neovide & disown
win_wait 'neovide — Neovide' 0.5 0 200
alacritty -T terminal --working-directory ~/prog/dotfiles & disown

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
