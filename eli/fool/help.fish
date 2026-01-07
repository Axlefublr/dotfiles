#!/usr/bin/env fish

set -gx COLUMNS 130
set -l pathie "/tmp/mine/$argv.help"
$argv --help &>$pathie
flour --disown --man $pathie:16
