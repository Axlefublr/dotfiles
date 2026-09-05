#!/usr/bin/env -S nu -n --no-std-lib

const WANTED_AUDIO_LANGS = [jpn japanese jp]
const WANTED_SUBTITLE_LANGS = [en eng english]

def main [...files: path] {
	let directory = input --reedline 'directory:'
	mkdir ~/iwm/voe/($directory)
	if ($directory | is-empty) { return }
	for file in $files {
		let basename = $file | path basename
		print $basename
		let target = $'~/iwm/voe/($directory)/($basename)' | path expand
		let data = ffprobe_data $file
		let changes = $data | collect_changes
		if ($changes | is-not-empty) {
			ffmpeg -y -hide_banner -stats -loglevel error -i $file -map 0 -c copy ...$changes $target
		} else {
			ln -sf $file $target
		}
	}
}

def 'main inspect' [file: path] {
	ffprobe_data $file
	| select index codec_name codec_type disposition.default tags.language? tags.title?
	| update cells -c [disposition.default] { |the| if ($the == 1) { true } else { false } }
	| rename index codec_name codec_type disposition language title
}

def collect_changes [] {
	let IN = $in
	let audio_streams_disablers    = $IN | try { unwanted_audio_streams    | disable_streams } | default []
	let subtitle_streams_disablers = $IN | try { unwanted_subtitle_streams | disable_streams } | default []
	let audio_stream_enablers      = $IN | try { wanted_audio_stream       | enable_stream }  | default []
	let subtitle_stream_enablers   = $IN | try { wanted_subtitle_stream    | enable_stream }  | default []
	$audio_streams_disablers
	| append $subtitle_streams_disablers
	| append $audio_stream_enablers
	| append $subtitle_stream_enablers
}

def unwanted_audio_streams [] {
	where codec_type == audio
	| where tags.language not-in $WANTED_AUDIO_LANGS
	| where disposition.default == 1
	| get index
}

def unwanted_subtitle_streams [] {
	where codec_type == subtitle
	| where tags.language not-in $WANTED_SUBTITLE_LANGS
	| where disposition.default == 1
	| get index
}

def wanted_audio_stream [] {
	where codec_type == audio
	| where tags.language in $WANTED_AUDIO_LANGS
	| where disposition.default == 0
	| get index
	| first
}

def wanted_subtitle_stream [] {
	where codec_type == subtitle
	| where tags.language in $WANTED_SUBTITLE_LANGS
	| where disposition.default == 0
	| get index
	| first
}

def disable_streams []: list<int> -> list<string> {
	each { |it|
		[$'-disposition:($it)', '0']
	}
	| flatten
}

def enable_stream []: int -> list<string> {
	[$'-disposition:($in)', 'default']
}

def ffprobe_data [file: path] {
	ffprobe -v quiet -of json -show_streams $file
	| from json
	| get streams
}

def test [expected, actual, message: string] {
	if ($expected != $actual) {
		print $message
		print $actual
	}
}

def 'main test' [] {
	[
		{
			index: 0
			codec_type: audio
			disposition: {
				default: 1
			}
			tags: {
				language: unrecognized-language
			}
		}
	]
	| unwanted_audio_streams
	| let actual
	test [ 0 ] $actual 'unwanted_audio_streams unrecognized-language'

	[
		{
			index: 0
			codec_type: audio
			disposition: {
				default: 1
			}
			tags: {
				language: eng
			}
		}
	]
	| unwanted_audio_streams
	| let actual
	test [ 0 ] $actual 'unwanted_audio_streams eng'

	[
		{
			index: 0
			codec_type: subtitle
			disposition: {
				default: 1
			}
			tags: {
				language: spanish
			}
		}
	]
	| unwanted_subtitle_streams
	| let actual
	test [ 0 ] $actual 'unwanted_subtitle_streams spanish'

	[
		{
			index: 0
			codec_type: audio
			disposition: {
				default: 1
			}
			tags: {
				language: eng
			}
		}
		{
			index: 1
			codec_type: audio
			disposition: {
				default: 0
			}
			tags: {
				language: jpn
			}
		}
	]
	| wanted_audio_stream
	| let actual
	test 1 $actual wanted_audio_stream

	[
		{
			index: 0
			codec_type: subtitle
			disposition: {
				default: 1
			}
			tags: {
				language: spanish
			}
		}
		{
			index: 1
			codec_type: subtitle
			disposition: {
				default: 0
			}
			tags: {
				language: eng
			}
		}
	]
	| wanted_subtitle_stream
	| let actual
	test 1 $actual wanted_subtitle_stream

	[
		{
			index: 0
			codec_type: audio
			disposition: {
				default: 1
			}
			tags: {
				language: spanish
			}
		}
		{
			index: 1
			codec_type: audio
			disposition: {
				default: 1
			}
			tags: {
				language: eng
			}
		}
	]
	| unwanted_audio_streams
	| disable_streams
	| let actual
	test [ '-disposition:0', '0', '-disposition:1', '0' ] $actual 'unwanted_audio_streams disabled'

	[
		{
			index: 0
			codec_type: subtitle
			disposition: {
				default: 1
			}
			tags: {
				language: spanish
			}
		}
		{
			index: 1
			codec_type: subtitle
			disposition: {
				default: 1
			}
			tags: {
				language: russian
			}
		}
	]
	| unwanted_subtitle_streams
	| disable_streams
	| let actual
	test [ '-disposition:0', '0', '-disposition:1', '0' ] $actual 'unwanted_subtitle_streams disabled'
}
