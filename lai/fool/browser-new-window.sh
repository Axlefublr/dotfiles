#!/usr/bin/env dash

# I'd love to blammo `$BROWSER` here but we probably got to this script by overriding `$BROWSER` already, so this would lead into an infinite loop
firefox --new-window "$@"
