#!/usr/bin/env ruby
# frozen_string_literal: true

class String
	def into_path
		File::expand_path self
	end
end

def cry how, about_what
	warn "error: #{how} `#{about_what}`"
	exit false
end

def cry about_what
	warn "error: #{about_what}"
	exit false
end

EXISTING_DECKS = %w[Once Freq].freeze
EXISTING_NOTE_TYPES = %w[b d f fb h].freeze

lines = File::open('~/bs/anki-card.html'.into_path).each_line.map(&:strip).to_enum

deck = lines.next
cry 'invalid deck', deck unless EXISTING_DECKS.include?(deck)
note_type = lines.next
cry 'invalid note type', note_type unless EXISTING_NOTE_TYPES.include?(note_type)
