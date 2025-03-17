#!/usr/bin/env fish

ln -sf (suggest.rs wallpaper ~/.local/share/magazine/T) ~/.cache/mine/background-image
niri msg action do-screen-transition
systemctl --user restart swaybg.service
