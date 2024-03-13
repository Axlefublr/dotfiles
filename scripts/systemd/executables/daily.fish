#!/usr/bin/env fish

clorange days increment
clorange megafon increment

trash-empty -f 7

yeared_parse
yearless_parse

if test (math (clorange megafon show) % 30) -eq 0
	alacritty -T task -e holup 'megafon (504) tomorrow' &
end

wait