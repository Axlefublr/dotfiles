#!/usr/bin/env fish

set -gx COLUMNS 130
set -l manpage "$argv[..-3]($argv[-2])"
set -l path /tmp/mine/$manpage.man
if $argv[-1]
    man $argv[..-3] 2>/dev/null >$path
else
    command man $argv[..-3] 2>/dev/null >$path
end
flour -T "man $manpage" --disown --man $path:14
