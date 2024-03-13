#!/usr/bin/env fish

while test (pgrep -x 'alacritty' | count) -lt 1
	sleep 1
end