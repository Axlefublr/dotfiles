#!/usr/bin/env fish

clorange megafon increment

trash-empty -f 7

yeared_parse
yearless_parse
daily_parse

task 'take medication'
task 'balsam'
task 'thoughts'

if test (math (clorange megafon show) % 30) -eq 0
    task 'megafon (504) tomorrow'
end

if test (date '+%d') -eq 17
    task 'dom.ru (760) tomorrow'
end

if test (date '+%d') -eq 27
    task 'tinkoff premium (200) tomorrow'
end

if test (date '+%A') = Saturday
    task 'new music'
end

if test (date '+%A') = Sunday
    task ask
end