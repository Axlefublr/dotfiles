#!/usr/bin/env ruby
# frozen_string_literal: true

def amount_used max_ml, max_height_cm, current_height_cm
	height_to_ml = max_ml / max_height_cm
	(max_height_cm - current_height_cm) * height_to_ml
end

def per_day used, days
	used / days
end

def days_per_amount per_day_ml, amount
	amount / per_day_ml
end

LIQUID_COST = 580
MONTH = 30.5

amount_used_ml = amount_used 58, 9.4, 4
per_day_ml = per_day amount_used_ml, 3
days_per_100 = days_per_amount per_day_ml, 100
liquids_per_month = MONTH / days_per_100
total_per_month = liquids_per_month * LIQUID_COST

puts "used up:  #{amount_used_ml}"
puts "per day:  #{per_day_ml}"
puts "days per: #{days_per_100}"
puts "liquids:  #{liquids_per_month}"
puts "total:    #{total_per_month}"
