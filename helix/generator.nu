#!/usr/bin/env -S nu -n --no-std-lib

let editor = {
	# [[sort on]]
	auto-completion: true
	auto-format: true
	auto-info: true
	auto-save: { focus-lost: false }
	buffer-picker: { start-position: previous }
	bufferline: always
	color-modes: true
	completion-timeout: 5
	completion-trigger-len: 2
	continue-comments: false
	cursor-shape: { insert: bar }
	default-line-ending: lf
	default-yank-register: '+'
	file-picker: { hidden: false }
	gutters: { line-numbers: { min-width: 2 } }
	insert-final-newline: true
	jump-label-alphabet: jfkdlsaeiwoxcmghruvnzbqpty
	line-number: relative
	preview-completion-insert: true
	scrolloff: 99
	search: { wrap-around: true }
	shell: [ 'nu', '--no-std-lib', '--stdin', '--config', '~/fes/dot/nu/lvoc/crooked.nu', '-c' ]
	text-width: 110
	trim-final-newlines: true
	trim-trailing-whitespace: true
	# [[sort off]]
	lsp: {
		auto-signature-help: false
		display-inlay-hints: false
		display-messages: true
		display-signature-help-docs: true
		goto-reference-include-declaration: false
		snippets: true
	}
	statusline: {
		separator: ''
		mode: {
			normal: normal
			insert: insert
			select: select
		}
		left: [
			primary-selection-length
			spacer
			selections
			# file-modification-indicator
		]
		center: [
			read-only-indicator
		]
		right: [
			# spinner
			register
			diagnostics
			position
			total-line-numbers
			spacer
			position-percentage
			file-encoding
		]
	}
	soft-wrap: {
		enable: true
		max-wrap: 0
		wrap-indicator: ''
	}
	whitespace: {
		characters: {
			newline: '↪'
			space: '·'
			nbsp: '⍽'
			nnbsp: '␣'
			tab: '➜'
			tabpad: ' '
		}
	}
	auto-pairs: {
		'<': '>'
		'(': ')'
		'{': '}'
		'[': ']'
		'"': '"'
		"'": "'"
		'`': '`'
		'«': '»'
		'‘': '’'
		'“': '”'
	}
	inline-diagnostics: {
		cursor-line: info
		other-lines: info
		max-wrap: 0
	}
	word-completion: {
		enable: true
		trigger-length: 4
	}
	smart-tab: {
		enable: false
		supersede-menu: true
	}
}

let all_mappings = {
	g: simulation
}

let normal_mappings = {
	g: camping
}

let insert_mappings = {
	a: flights
}

let editor_fork = {
	# [[sort on]]
	auto-reload: { poll: { interval: 1000 } }
	enable-diagnostics: true
	picker: { scrolloff: 99 }
	search: { max-matches: none }
	whichkey: false
	# [[sort off]]
	harp: {
		command: filetype
		search: buffer
		register: filetype
		mark: buffer
		file: directory
		hotkeys: {
			global: ';'
			directory: k
			filetype: l
			buffer: j
			switch: "'"
			delete: '<del>'
			delete-all: '<S-del>'
			alt: /
		}
	}
	statusline: {
		left: [
			primary-selection-length
			spacer
			selections
			spacer
			smart-path
		]
		right: [
			register
			diagnostics
			search-position
			position
			total-line-numbers
			spacer
			position-percentage
			file-encoding
		]
	}
}

let all_mappings_fork = {
	r: reconstruction
}

let normal_mappings_fork = {
	r: hazardous
}

let insert_mappings_fork = {
	v: mount
}

def rusify_key [] {
	let IN = $in
	const russian_mapping = {
		a: ф, b: и, c: с, d: в, e: у, f: а, g: п, h: р, i: ш, j: о, k: л, l: д, m: ь, n: т, o: щ, p: з, q: й, r: к, s: ы, t: е, u: г, v: м, w: ц, x: ч, y: н, z: я,
		A: Ф, B: И, C: С, D: В, E: У, F: А, G: П, H: Р, I: Ш, J: О, K: Л, L: Д, M: Ь, N: Т, O: Щ, P: З, Q: Й, R: К, S: Ы, T: Е, U: Г, V: М, W: Ц, X: Ч, Y: Н, Z: Я,
		'[': х, ']': ъ, '{': Х, '}': Ъ, '`': ё, ~: Ё, ',': б, '<': Б, .: ю, '>': Ю, ';': ж, ':': Ж, "'": э, '"': Э, №: '#'
	}
	$IN | if ($in | str length | $in == 1) {
		$russian_mapping | get -o $IN | default $IN
	} else {
		try {
			parse '{prefix}-{chr}' | into record | let obj
			$'($obj.prefix)-($russian_mapping | get $obj.chr)'
		} catch { $IN }
	}
}

def rusify [] {
	items { |key, value|
		let new_key = $key | rusify_key
		let new_value = $value | if ($in | describe | $in starts-with record) { rusify } else {}
		{ key: $new_key, value: $new_value }
	}
	| transpose -dr
}

let mappings = {
	normal: ($all_mappings | merge deep $normal_mappings | let the ; $the | merge deep ($the | rusify))
	insert: ($all_mappings | merge deep $insert_mappings | let the ; $the | merge deep ($the | rusify))
}

let entire_config = {
    theme: gruvbox_material
    editor: $editor
    keys: $mappings
}

$entire_config | to toml | save -f ~/fes/dot/helix/pure.toml

let mappings_fork = {
	normal: ($all_mappings_fork | merge deep $normal_mappings_fork | let the ; $the | merge deep ($the | rusify))
	insert: ($all_mappings_fork | merge deep $insert_mappings_fork | let the ; $the | merge deep ($the | rusify))
}
let entire_config_fork = $entire_config | merge deep { editor: $editor_fork, keys: $mappings_fork }

$entire_config_fork | to toml | save -f ~/fes/dot/helix/testing.toml

# ! %(full_path) ; open helix/config.toml | sort | save -f /tmp/mine/old-config.toml ; open helix/testing.toml | sort | save -f /tmp/mine/new-config.toml ; sand fish -c 'dof /tmp/mine/old-config.toml /tmp/mine/new-config.toml'
