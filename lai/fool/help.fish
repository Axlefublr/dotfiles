#!/usr/bin/env fish

set -gx COLUMNS 130
set -l help_page "$argv"
set -l dir ~/fes/zufi/men
mkdir -p $dir
set -l path $dir/$help_page.help
indeed.rs -u ~/.local/share/magazine/a-comma $input
$argv --help &>$path
wm_focus_if_exists "app_id starts-with foot" "title == 'help $help_page'"
or flour --disown -T "help $help_page" --disown --man $path:14
