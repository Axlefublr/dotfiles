#!/usr/bin/env dash

title="$1"
shift
footclient -T "$title" -o environment.TIT="$title" "$@"
