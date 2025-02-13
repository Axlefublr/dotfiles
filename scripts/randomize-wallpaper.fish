#!/usr/bin/env fish

while true
    set -f decided_path (shuf -n 1 ~/.local/share/magazine/T)
    set -l stored_count (count (cat ~/.local/share/magazine/T))
    test $stored_count -eq 0 && exit 1
    set -l desired_non_repeat (math "floor($stored_count / 3)")
    if not contains $decided_path (cat ~/bs/recent-wallpapers)
        echo $decided_path >>~/bs/recent-wallpapers
        tail -n $desired_non_repeat ~/bs/recent-wallpapers | sponge ~/bs/recent-wallpapers
        break
    end
end
set -l wallpaper_path (string replace -r '^~' $HOME $decided_path)
ln -sf $wallpaper_path ~/bs/background-image
systemctl --user restart swaybg.service
niri msg action do-screen-transition
