#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace main
foot -T nugleterm -o environment.TIT=nugleterm nu & disown
wm_wait_if_or_until_exists 'app_id starts-with foot' 'title == nugleterm'
foot -T toggleterm -o environment.TIT=toggleterm & disown
wm_wait_if_or_until_exists 'app_id starts-with foot' 'title == toggleterm'
niri msg action consume-or-expel-window-left
foot -T dotfiles -o environment.TIT=dotfiles -D ~/fes/dot helix & disown
ntf_dismiss_all
gtk-launch firefox
foot -T finances -o environment.TIT=finances ov --status-line=false --follow-name ~/.local/share/magazine/J & disown
wm_wait_if_or_until_exists 'app_id starts-with foot' 'title == finances'
foot -T earnings -o environment.TIT=earnings earnings.fish & disown
wm_wait_if_or_until_exists 'app_id starts-with foot' 'title == earnings'
foot -T loago-tracker -o environment.TIT=loago-tracker fish -c loago_tracker & disown
foot -T receiver -o environment.TIT=receiver receiver.fish & disown
foot -T voe -o environment.TIT=voe -D ~/iwm/voe yazi & disown
niri msg action spawn -- Todoist.AppImage
wm_wait_if_or_until_exists 'app_id == todoist'
gtk-launch anki
wm_wait_if_or_until_exists 'app_id == anki' 'title starts-with User'
make-em-shut-up.nu
playerctld daemon
