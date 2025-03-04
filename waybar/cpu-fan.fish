#!/usr/bin/env fish

math "round($(sensors -j | jq -- '."nct6791-isa-0290"."fan2"."fan2_input"') / 50) * 50"
