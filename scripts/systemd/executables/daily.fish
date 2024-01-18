#!/usr/bin/env fish

clorange days increment

yeared-parse
yearless-parse

if test (math (clorange days show) % 2) -eq 0
	kitty -T task holup 'job search'
end

wait