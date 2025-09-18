#!/usr/bin/env fish

if $argv[-1]
    man $argv[..-2]
else
    command man $argv[..-2]
end
