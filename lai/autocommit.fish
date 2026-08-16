#!/usr/bin/env fish

# TODO: this doesn't actually return err on nothing to do, but should
# if not git status --porcelain
#     return
# end
set -l new_files
set -l deleted_files
set -l modified_files
set -l renamed_from
set -l renamed_to
set -l typechanged
git add .
# FIXME: -z flag makes git status nul delimit stuff and not wrap shit in quotes
for change in (git status --porcelain)
    set -l bits (string split -n ' ' $change)
    set type $bits[1]
    set path "$(echo $bits[2..])"
    if test $type = A
        set new_files $new_files (string trim -c '"' $path)
    else if test $type = D
        set deleted_files $deleted_files (string trim -c '"' $path)
    else if test $type = M
        set modified_files $modified_files (string trim -c '"' $path)
    else if test $type = T
        set typechanged $typechanged (string trim -c '"' $path)
    else if test $type = R
        set -l two_paths (string split ' -> ' -- $path)
        set renamed_from $renamed_from (string trim -c '"' $two_paths[1])
        set renamed_to $renamed_to (string trim -c '"' $two_paths[2])
    end
end
git restore --staged .

set -l autosorted (path_resolve_batch (cat ~/.local/share/magazine/R 2>/dev/null))
set -l autouniqued (path_resolve_batch (cat ~/.local/share/magazine/Q 2>/dev/null))

function _hook -a file -V autosorted -V autouniqued
    # we shouldn't cross directory boundaries and autohook for some other directory: it's its job, not *this* autocommit's
    # so if the current file we're looking at is a symlink, it will necessarily never appear in the “please hook me” lists,
    # because they are *resolved* paths exclusively, and `realpath -s` doesn't resolve symlinks, only fullpathes them
    # the hooks will only happen if an origin file from the “please hook me” lists is the one we're looking at
    set -l full_path_maybe_symlink (builtin realpath -s -- $file)
    if contains -- $full_path_maybe_symlink $autosorted
        sort.py -u $full_path_maybe_symlink
    else if contains -- $full_path_maybe_symlink $autouniqued
        cat $full_path_maybe_symlink | dedup | sponge $full_path_maybe_symlink
    end
end

for deletion in $deleted_files
    git add $deletion
    and git commit -m "remove $deletion"
end
for addition in $new_files
    _hook $addition
    git add $addition
    and git commit -m "add $addition"
end
for modification in $modified_files
    _hook $modification
    git add $modification
    and git commit -m "change $modification"
end
for typing in $typechanged
    _hook $typing
    git add $typing
    and git commit -m "type $typing"
end
for index in (seq (count $renamed_from))
    _hook $renamed_to[$index]
    git add $renamed_from[$index] $renamed_to[$index]
    and git commit -m "move $renamed_from[$index] -> $renamed_to[$index]"
end
