#!/usr/bin/env fish

math "round($(sensors -j | jq -- '."nct6791-isa-0290"."fan1"."fan1_input"') / 50) * 50"
