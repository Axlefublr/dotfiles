#!/usr/bin/env fish

for file in $argv
    echo file://(path resolve $file)
end | wl-copy -t text/uri-list
