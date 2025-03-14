#!/usr/bin/env fish

while true
    set -f decided_path (shuf -n 1 ~/.local/share/magazine/T)
    set -l stored_count (count (cat ~/.local/share/magazine/T))
    test $stored_count -eq 0 && exit 1
    set -l desired_non_repeat (math "floor($stored_count / 2)")
    if not contains $decided_path (cat ~/.cache/mine/recent-wallpapers)
        echo $decided_path >>~/.cache/mine/recent-wallpapers
        tail -n $desired_non_repeat ~/.cache/mine/recent-wallpapers | sponge ~/.cache/mine/recent-wallpapers
        break
    end
end
set -l wallpaper_path (string replace -r '^~' $HOME $decided_path)
ln -sf $wallpaper_path ~/.cache/mine/background-image
systemctl --user restart swaybg.service
niri msg action do-screen-transition
