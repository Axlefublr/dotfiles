#!/usr/bin/env fish

set -l parent_dir ~/fes/talia/(pwdb)
mkdir -p $parent_dir
if not test "$argv"
    footclient -N yazi $parent_dir
    return
end
set -l patch_name "$argv"
if not path extension $patch_name
    set patch_name $patch_name.patch
end
wl-paste -n >$parent_dir/$patch_name
