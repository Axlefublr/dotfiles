#!/usr/bin/env -S fish -N

set -l mimetype (wl-paste -l)[1]
set -l prev_clipboard "$(wl-paste -n)"
wl-copy -n --sensitive "$argv"
wtype -M ctrl -k v -m ctrl
wl-copy -n -t $mimetype $prev_clipboard
