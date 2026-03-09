#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace one
foot -T toggleterm & disown
sleep 10ms
foot -T dotfiles -D ~/fes/dot helix & disown
gtk-launch firefox
playerctld daemon
footclient -NT finances helix ~/ake/finances
footclient -NT abilities abilities.fish
footclient -NT loago-tracker fish -c loago_tracker
footclient -NT calcure calcure
footclient -NT voe -D ~/iwm/voe yazi
gtk-launch anki
