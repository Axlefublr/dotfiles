#!/usr/bin/env fish

set -l minutes 40

while true
    while test (clorange getup show) -lt $minutes
        sleep 1m
        clorange getup increment
    end
    awesome-client 'Getup_we()'
    while test (clorange getup show) -ge $minutes
        sleep 5
    end
end
