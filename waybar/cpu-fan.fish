#!/usr/bin/env fish

set -l the (math "round($(sensors -j | jq -- '."it8620-isa-0a30"."fan1"."fan1_input"') / 100) * 100")
test "$the" = 0 && echo || echo $the
