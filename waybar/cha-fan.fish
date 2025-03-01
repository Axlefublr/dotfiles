#!/usr/bin/env fish

sensors -j | jq -- '."nct6791-isa-0290"."fan1"."fan1_input"' | math round
