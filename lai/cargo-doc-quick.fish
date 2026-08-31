#!/usr/bin/env fish

function open -a title_match
    set -l id (wm_wait_until_exists 'app_id == firefox' $title_match)
    niri msg action focus-window --id $id
    niri msg action move-column-to-workspace help
    niri msg action move-column-to-last
end

set -gx BROWSER browser-new-window.sh
set -l package (cargo.nu default-package)
set -l file ./target/doc/$package/index.html

if test -f $file
    $BROWSER $file &>/dev/null
    open "title == '$package - Rust — Mozilla Firefox'"
    $argv
else
    $argv --open # chances are, this is the first time I'm opening the docs for this project, so landing on the correct package is significant
    open "title ends-with ' - Rust — Mozilla Firefox'"
end
