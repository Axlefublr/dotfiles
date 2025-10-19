#!/usr/bin/env fish

math "round($(sensors -j | jq -- '."it8620-isa-0a30"."fan1"."fan1_input"') / 50) * 50"
