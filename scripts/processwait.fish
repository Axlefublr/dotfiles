#!/usr/bin/env fish

while test (pgrep -x 'niri' | count) -lt 1
    sleep 1
end
