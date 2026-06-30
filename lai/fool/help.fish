#!/usr/bin/env fish

set -gx COLUMNS 130
set -l help_page "$argv"
set -l dir ~/fes/zufi/men
mkdir -p $dir
set -l path $dir/$help_page.help
$argv --help &>$path
focus-if-exists.fish "app_id starts-with foot" "title == 'help $help_page'"
or flour -T "help $help_page" --disown --man $path:14
