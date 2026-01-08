#!/usr/bin/env fish

if not git status --porcelain
    return
end
set -l new_files
set -l deleted_files
set -l modified_files
set -l renamed_from
set -l renamed_to
git add .
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
    else if test $type = R
        set two_paths (string split ' -> ' -- $path)
        set renamed_from $renamed_from (string trim -c '"' $two_paths[1])
        set renamed_to $renamed_to (string trim -c '"' $two_paths[2])
    end
end
git restore --staged .
for deletion in $deleted_files
    git add $deletion
    and git commit -m "remove $deletion"
end
for addition in $new_files
    git add $addition
    and git commit -m "add $addition"
end
for modification in $modified_files
    git add $modification
    and git commit -m "change $modification"
end
for index in (seq (count $renamed_from))
    git add $renamed_from[$index] $renamed_to[$index]
    and git commit -m "move $renamed_from[$index] -> $renamed_to[$index]"
end
