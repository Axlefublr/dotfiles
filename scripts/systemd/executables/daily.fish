#!/usr/bin/env fish

clorange days increment
clorange megafon increment

trash-empty -f 7

yeared_parse
yearless_parse

if test (math (clorange megafon show) % 30) -eq 0
    alacritty -T task -e holup 'megafon (504) tomorrow' &
end

if test (date '+%d') -eq 17
    alacritty -T task -e holup 'dom.ru (760) tomorrow' &
end

if test (date '+%d') -q 27
    alacritty -T task -e holup 'tinkoff premium (200) tomorrow' &
end

wait