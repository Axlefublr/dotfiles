#!/usr/bin/env fish

clorange days increment
clorange megafon inrement

yeared-parse
yearless-parse

if test (math (clorange days show) % 2) -eq 0
	kitty -T task holup 'job search'
end

if test (math (clorange megafon show) % 30) -eq 0
	kitty -T task holup 'megafon (504) tomorrow'
end

wait