#!/usr/bin/env fish

clorange megafon increment

trash-empty -f 7

yeared_parse
yearless_parse
daily_parse

indeed ~/.local/share/magazine/6 'take medication'

if test (math (clorange megafon show) % 30) -eq 0
    indeed ~/.local/share/magazine/6 'megafon (504) tomorrow'
end

if test (date '+%d') -eq 17
    indeed ~/.local/share/magazine/6 'dom.ru (760) tomorrow'
end

if test (date '+%d') -eq 27
    indeed ~/.local/share/magazine/6 'tinkoff premium (200) tomorrow'
end

update_magazine 6