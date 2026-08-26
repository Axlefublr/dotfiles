#!/usr/bin/env fish

if not contains -- $argv[1] (ewwii active-windows | string match -gr -- '(.*): ')
    ewwii open $argv
end
