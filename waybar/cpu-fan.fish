#!/usr/bin/env fish

sensors -j | jq -- '."nct6791-isa-0290"."fan2"."fan2_input"' | math round
