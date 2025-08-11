#!/usr/bin/env -S nu -n --no-std-lib

def --wrapped main [...rest] {
	if ($rest | length) == 0 {
		ov -X --section-delimiter ^Group --hide-other-section -M Failed,Running,Queued,Success,,,,Paused -e -- pueue status
		return
	}
	pueue ...$rest
}

def --wrapped 'main push' [--group(-g) = 'default', ...rest] {
	pueue clear o+e> /dev/null
	pueue start -g $group o+e> /dev/null
	pueue add -g $group ...$rest
}
