#!/usr/bin/env fish

function open -a file package
    firefox --new-window $file &>/dev/null
    set -l id (wm_wait_if_or_until_exists 'app_id == firefox' "title == '$package - Rust — Mozilla Firefox'")
    niri msg action focus-window --id $id
    niri msg action move-column-to-workspace help
    niri msg action move-column-to-last
end

set -l package (cargo.nu default-package)
set -l file ./target/doc/$package/index.html
test -f $file
set -l did_file_exist $status
if test $did_file_exist -eq 0
    open $file $package
end
# I'm making myself encode the specific cargo doc parameters so that I don't have to maintain it in two places
$argv
if test $did_file_exist -ne 0 -a -f $file
    open $file $package
else if not test -f $file
    # we probably figured out the target file wrong, shouldn't happen but last resort
    $argv --open
end
