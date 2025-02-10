#!/usr/bin/env fish

while true
    set -f decided_path (shuf -n 1 ~/.local/share/magazine/T)
    if test (count (cat ~/.local/share/magazine/T)) -le 3
        break
    else if not contains $decided_path (cat ~/bs/recent-wallpapers)
        echo $decided_path >>~/bs/recent-wallpapers
        tail -n 3 ~/bs/recent-wallpapers | sponge ~/bs/recent-wallpapers
        break
    end
end
set -l wallpaper_path (string replace -r '^~' $HOME $decided_path)
ln -sf $wallpaper_path ~/bs/background-image
systemctl --user restart swaybg.service
niri msg action do-screen-transition
