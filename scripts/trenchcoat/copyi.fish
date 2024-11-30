#!/usr/bin/env fish

test "$(path extension $argv[1])" != .png && return 1
copyi $argv[1]
