#!/usr/bin/env fish

for file in $argv
    wl-copy -t image/png <$file
end
