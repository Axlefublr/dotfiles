#!/usr/bin/env -S fish -N

set -l mimetype (wl-paste -l)[1]
set -l prev_clipboard "$(wl-paste -n)"
wl-copy -nt text/plain --sensitive "$argv"
wtype -M ctrl -k v -m ctrl
sleep 0.01
wl-copy -n -t $mimetype --sensitive $prev_clipboard
