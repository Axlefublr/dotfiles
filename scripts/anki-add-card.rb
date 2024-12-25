#!/usr/bin/env ruby
# frozen_string_literal: true

class String
	def into_path
		File::expand_path self
	end
end

class Array
	def pad_to_required
		(self + [''] * 2)[0...6]
	end
end

def cry_with_value how, about_what
	warn "error: #{how} `#{about_what}`"
	exit false
end

def cry about_what
	warn "error: #{about_what}"
	exit false
end

EXISTING_DECKS = %w[Once Freq].freeze
EXISTING_NOTE_TYPES = %w[b d f fb h].freeze

lines = File::open('~/bs/anki-card.html'.into_path).each_line.map(&:strip).to_a

fields = lines.size
cry_with_value 'less than 4 fields', fields if fields < 4
cry_with_value 'more than 6 fields', fields if fields > 6

lines = lines.pad_to_required.to_enum

deck = lines.next
cry_with_value 'invalid deck', deck unless EXISTING_DECKS.include?(deck)
note_type = lines.next
cry_with_value 'invalid note type', note_type unless EXISTING_NOTE_TYPES.include?(note_type)

lines = lines.map do |line|
	line = line.gsub '"', '""'
	'"' + line + '"'
end.to_a

puts lines.join ';'
