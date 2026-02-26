#!/usr/bin/env fish

set -gx COLUMNS 130
set -l help_page "$argv"
set -l path "/tmp/mine/$help_page.help"
$argv --help &>$path
flour -T "help $help_page" --disown --man $path:14
