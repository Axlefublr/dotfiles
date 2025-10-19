#!/usr/bin/env fish

math "round($(sensors -j | jq -- '."it8620-isa-0a30"."fan2"."fan2_input"') / 50) * 50"
