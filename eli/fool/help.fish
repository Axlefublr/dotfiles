#!/usr/bin/env fish

set -gx COLUMNS 129
set -l pathie "/tmp/mine/$argv.help"
$argv --help 2>/dev/null >$pathie
flour --disown --man $pathie
