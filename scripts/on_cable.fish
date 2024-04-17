#!/usr/bin/env fish

ollama serve >&2 2>>/dev/shm/user_log.txt & disown
gromit.fish >&2 2>>/dev/shm/user_log.txt & disown
