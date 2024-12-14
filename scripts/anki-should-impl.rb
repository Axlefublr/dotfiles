#!/usr/bin/env ruby
# frozen_string_literal: true

exit false if ARGV[0].nil?
total_new_cards = Float(ARGV[0])

crunched = Math.log2 total_new_cards
inflated = crunched * 2.2
lowered = inflated - 2
capped = [lowered, 12].min.round
puts capped
