#!/usr/bin/env fish

clorange days increment
clorange megafon increment

yeared_parse
yearless_parse

if test (math (clorange megafon show) % 30) -eq 0
	kitty -T task holup 'megafon (504) tomorrow'
end

wait