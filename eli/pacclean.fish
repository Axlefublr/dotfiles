#!/usr/bin/env fish
# based on https://gist.github.com/ericmurphyxyz/37baa4c9da9d3b057a522f20a9ad6eba (cool youtuber btw)

set aur_cache_dir "$HOME/.cache/paru/clone"
function aur_cache_dirs_fmt
    fd . $HOME/.cache/paru/clone -d 1 -t d | awk '{ print "-c" $1 }'
end
set uninstalled_target (aur_cache_dirs_fmt)
echo $uninstalled_target[1]
paccache -ruvk0 $uninstalled_target
set installed_target (aur_cache_dirs_fmt) # we do this twice because uninstalled package directories got removed
paccache -qruk0
paccache -qrk0 -c /var/cache/pacman/pkg $installed_target
