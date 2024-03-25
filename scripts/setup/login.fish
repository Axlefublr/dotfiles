#!/usr/bin/env fish

if test -d /tmp/log
	return 1
else
	mkdir -p /tmp/log
end

for script in ~/prog/dotfiles/scripts/widget_update/*.fish
	$script 2>>/dev/shm/user_log.txt & disown
end

xremap --mouse ~/prog/dotfiles/xremap.yml 2>>/dev/shm/user_log.txt & disown
ydotoold 2>>/dev/shm/user_log.txt & disown
ollama serve 2>>/dev/shm/user_log.txt & disown
picom 2>>/dev/shm/user_log.txt & disown
gromit.fish 2>>/dev/shm/user_log.txt & disown
clipster --daemon 2>>/dev/shm/user_log.txt & disown
xset s off -dpms 2>>/dev/shm/user_log.txt
redshift -O 5700 2>>/dev/shm/user_log.txt
playerctld daemon 2>>/dev/shm/user_log.txt

alacritty -T meow 2>>/dev/shm/user_log.txt & disown
alacritty -T timer 2>>/dev/shm/user_log.txt & disown
oil.fish ~/Videos/content 2>>/dev/shm/user_log.txt & disown

alacritty -T editor --working-directory ~/prog/dotfiles -e nvim 2>>/dev/shm/user_log.txt & disown
# win_wait 'neovide — Neovide' 0.5 0 200
alacritty -T terminal --working-directory ~/prog/dotfiles 2>>/dev/shm/user_log.txt & disown

vivaldi-stable --force-dark-mode 2>>/dev/shm/user_log.txt & disown
set vivaldis (win_wait 'Vivaldi-stable' 0.1 5 200)
move_all 2 $vivaldis
set discord (win_wait 'Vivaldi-stable — .*(Discord|Mastodon|Messenger)' 0.1 0 50)
move_all 5 $discord
set youtube (win_wait 'Vivaldi-stable — .*YouTube' 0.1 0 50)
move_all 7 $youtube

anki 2>>/dev/shm/user_log.txt & disown
set ankis (win_wait 'anki\.Anki' 0.1 0 50)
move_all 8 $ankis

notify-send -t 2000 'spotify'
loopuntil is_internet 0.5 0 60
spotify-launcher -v 2>>/dev/shm/user_log.txt & disown

notify-sent -t 2000 'xwaaa'
sleep 10
xwaaa

notify-send -t 2000 'logged in'
