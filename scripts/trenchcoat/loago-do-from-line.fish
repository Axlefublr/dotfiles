#!/usr/bin/env fish

set -l task (string split ' ' (read -z))[1]
loago do $task
