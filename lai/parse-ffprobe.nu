#!/usr/bin/env -S nu -n --no-std-lib

def 'main' [] {
	parse -r 'Stream #0:(?P<id>\d+)\((?P<lng>\w+)\): (?P<type>Audio|Subtitle): .*?(?:\((?P<default>default)\))?\n(?:.*\n\s+title\s*: (?P<description>\w+))?'
	| update cells -c [default] { if $in == default { true } }
	| rename -c { id: index, default: dflt, description: descript }
}
