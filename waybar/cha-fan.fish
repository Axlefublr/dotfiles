#!/usr/bin/env fish

set -l the (math "round($(sensors -j | jq -- '."it8620-isa-0a30"."fan2"."fan2_input"') / 50) * 50")
test "$the" = 0 && echo || echo $the
