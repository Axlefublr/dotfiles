#!/usr/bin/env fish

while test (pgrep -x 'kitty' | count) -lt 1
	sleep 1
end