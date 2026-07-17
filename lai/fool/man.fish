#!/usr/bin/env fish

set -gx COLUMNS 130
set -l manpage "$argv[..-3]($argv[-2])"
set -l dir ~/fes/zufi/men
mkdir -p $dir
set -l path $dir/$manpage.man
if $argv[-1]
    man $argv[..-3] 2>/dev/null >$path
else
    command man $argv[..-3] 2>/dev/null >$path
end
wm_focus_if_exists "app_id starts-with foot" "title == 'man $manpage'"
or flour -T "man $manpage" --disown --man $path:14
