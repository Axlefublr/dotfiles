#!/usr/bin/env fish

argparse -i from-current -- $argv
set -gx COLUMNS 130
set -l help_page "$argv"
set -l dir ~/fes/zufi/men
mkdir -p $dir
set -l path $dir/$help_page.help
indeed.rs -u -- ~/.local/share/magazine/a-comma "$help_page"
$argv --help &>$path
wm_focus_if_exists "app_id starts-with foot" "title == 'help $help_page'"
or flour --disown -T "help $help_page" --disown --man $path:14
if not set -q _flag_from_current
    set -l id (wm_wait_if_or_until_exists "app_id starts-with foot" "title == 'help $help_page'")
    niri msg action focus-window --id $id
    niri msg action move-column-to-last
end
