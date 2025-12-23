#!/usr/bin/env fish

set -gx COLUMNS 130
set -l pathie /tmp/mine/"$argv[..-3]($argv[-2])".man
if $argv[-1]
    man $argv[..-3] 2>/dev/null >$pathie
else
    command man $argv[..-3] 2>/dev/null >$pathie
end
flour --disown --man $pathie
