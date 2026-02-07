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
	gutters: { layout: [], line-numbers: { min-width: 2 } }
	insert-final-newline: true
	jump-label-alphabet: jfkdlsaeiwoxcmghruvnzbqpty
	line-number: relative
	preview-completion-insert: false
	scrolloff: 99
	search: { wrap-around: true }
	shell: ['nu', '--no-std-lib', '--stdin', '--config', '~/fes/dot/nu/lvoc/crooked.nu', '-c']
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
	C-s: signature_help
	C-i: [commit_undo_checkpoint open_above]
	C-o: [commit_undo_checkpoint open_below]
	A-left: goto_prev_tabstop
	A-right: goto_next_tabstop
	# -------------------------keyful--------------------------
	A-tab: ':open %sh(wl-paste -n)'
	C-tab: add_newline_above
	F12: add_newline_below
	down: move_line_down
	up: move_line_up
	C-up: copy_selection_on_prev_line
	C-down: copy_selection_on_next_line
	C-left: goto_previous_buffer
	C-right: goto_next_buffer
	S-left: unindent
	S-right: indent
	C-home: goto_file_start
	C-end: [extend_to_file_end collapse_selection]
	S-pageup: ('@<C-i>[[sort' + ' on]]<esc>@')
	S-pagedown: ('@<C-o>[[sort' + ' off]]<esc>@')
	# -------------------------saving--------------------------
	ins: ':write-buffer-close'
	A-w: ':write-buffer-close'
	S-ins: ':buffer-close!'
	C-A-w: ':buffer-close!'
	A-space: ':write-quit-all'
	A-ins: ':quit!'
	C-space: ':write-all'
	C-ins: ':write!'
	C-t: ':reload'
	S-A-F6: ':write --no-format'
	S-A-F11: ':write! --no-format'
	# ------------------------function-------------------------
	F2: [
		":noop %sh('%(full_path)' | path expand | save -f ~/.cache/mine/blammo)"
		':sh footclient -ND %(working_directory) o+e>| ignore'
	]
	F3: [
		":noop %sh('%(full_path)' | path expand | save -f ~/.cache/mine/blammo)"
		':sh footclient -ND %(working_directory) -T floating o+e>| ignore'
	]
	F4: [
		':sh rm -f /tmp/mine/yazi-chooser-file'
		':noop %sh(footclient yazi %{full_path} --chooser-file=/tmp/mine/yazi-chooser-file)'
		':open %sh{cat /tmp/mine/yazi-chooser-file}'
	]
	F6: [
		':sh rm -f /tmp/mine/yazi-chooser-file'
		':noop %sh(footclient yazi --chooser-file=/tmp/mine/yazi-chooser-file)'
		':open %sh{cat /tmp/mine/yazi-chooser-file}'
	]
	F1: [
		':noop %sh{git show "HEAD:%(relative_path)" | save -f "/tmp/mine/HEAD!%(buffer_name)"}'
		':open "/tmp/mine/HEAD!%(buffer_name):%(cursor_line):%(cursor_column)"'
	]
 }

let normal_mappings = {
	P: null
	Y: null
	y: null
	# -------------------------normal--------------------------
	a: [save_selection select_textobject_inner]
	"'": [save_selection select_textobject_around]
	'/': search
	'?': rsearch
	b: [add_newline_below move_line_down paste_before]
	B: [add_newline_above move_line_up paste_before]
	A-a: decrement
	A-f: increment
	# [[sort on]]
	',': trim_selections
	':': split_selection_on_newline
	';': [collapse_selection normal_mode]
	'C-;': ':pipe ~/fes/dot/lai/fool/qalc.fish -t $in'
	A-i: select_references_to_symbol_under_cursor
	C-c: change_selection_noyank
	C-d: delete_selection_noyank
	C-h: select_prev_sibling
	C-j: shrink_selection
	C-k: [expand_selection ensure_selections_forward flip_selections]
	C-l: select_next_sibling
	C-m: select_all_siblings
	C-n: extend_search_next
	C-q: ':cd ..'
	C-v: replace
	C-x: join_selections
	C: '@c<ret><esc>'
	I: insert_at_line_start
	M: merge_selections
	N: search_prev
	O: paste_before
	Q: split_selection
	R: ensure_selections_forward
	S-A-F3: extend_search_prev
	S-A-F4: merge_consecutive_selections
	T: redo
	U: insert_at_line_end
	V: [collapse_selection replace]
	X: join_selections_space
	c: change_selection
	d: delete_selection
	h: move_char_left
	i: insert_mode
	j: move_visual_line_down
	k: move_visual_line_up
	l: move_char_right
	n: search_next
	o: paste_after
	q: select_regex
	r: flip_selections
	s: yank
	t: undo
	x: replace_with_yanked
	# [[sort off]]
	# ---------------------------x↓----------------------------
	'÷': '@<space>w<ret>'
	'*': [search_selection_detect_word_boundaries normal_mode]
	'#': null
	'√': null
	'$': null
	'+': rotate_selections_forward
	'-': rotate_selections_backward
	'=': remove_primary_selection
	'×': null
	'%': [save_selection select_all]
	'!': ':pipe str trim'
	'…': null
	'\': shell_pipe_to
	# ---------------------------c↓----------------------------
	'₽': null
	'^': '@ma<A-O>*<ins>'
	'@': toggle_comments
	'™': null
	'€': ":pipe $in | if ($in | str substring 0..0) == '-' { str trim -c '-' } else { fill -w 57 -a center -c '-' }"
	'`': [collapse_selection switch_case]
	'_': switch_to_lowercase
	'—': null #
	'¢': null
	'~': '@%q<ret>'
	'&': '@q<ret>'
	'°': align_selections
	'|': shell_pipe
	# ---------------------------xc↓---------------------------
	'⊻': ':tree-sitter-subtree'
	'⊼': ':tree-sitter-highlight-name'
	'≤': rotate_selection_contents_forward
	'≥': rotate_selection_contents_backward
	'≈': reverse_selection_contents
	'≺': rotate_selections_first
	'≻': rotate_selections_last
	'␈': null #
	'␡': null
	'⤒': null #
	'⤓': ':sort'
	# ---------------------------i↓----------------------------
	# [[sort on]]
	'(': goto_prev_change
	')': goto_next_change
	'[': goto_prev_diag
	']': goto_next_diag
	'{': jump_backward
	'}': repeat_last_motion
	'²': goto_last_change
	'³': goto_first_change
	'‘': [':echo selected!' save_selection]
	'’': jump_forward
	'⁸': goto_last_diag
	'⁹': goto_first_diag
	'󰟢': shrink_to_line_bounds
	# [[sort off]]
	'”': {
		t  : goto_next_test
		'}': goto_next_entry
		e  : goto_next_entry
		'»': goto_next_comment
		v  : goto_next_comment
		'”': goto_next_function
		f  : goto_next_function
		'“': goto_next_parameter
		a  : goto_next_parameter
		']': goto_next_class
		c  : goto_next_class
	}
	'“': {
		t  : goto_prev_test
		'}': goto_prev_entry
		e  : goto_prev_entry
		'»': goto_prev_comment
		v  : goto_prev_comment
		'”': goto_prev_function
		f  : goto_prev_function
		'“': goto_prev_parameter
		a  : goto_prev_parameter
		']': goto_prev_class
		c  : goto_prev_class
	}
	# ---------------------------v↓----------------------------
	'∞': shell_append_output
	'✨': shell_insert_output
	# [[sort on]]
	'←': shell_keep_pipe
	'↑': keep_selections
	'↓': remove_selections
	'█': '@q█<ret>c'
	'✅': null #
	'❌': null #
	'❓': null
	'❗': null
	'💡': null
	# [[sort off]]
	# ----------------------word motions-----------------------
	C-1: [ensure_selections_forward extend_prev_word_end trim_selections]
	C-5: [ensure_selections_forward flip_selections extend_next_word_start trim_selections]
	C-e: [ensure_selections_forward flip_selections extend_prev_word_start trim_selections]
	C-f: [ensure_selections_forward extend_next_word_end trim_selections]
	E: [move_prev_long_word_start trim_selections]
	F: [move_next_long_word_end trim_selections]
	S-A-F10: [ensure_selections_forward flip_selections extend_next_long_word_start trim_selections]
	S-A-F7: [ensure_selections_forward extend_next_long_word_end trim_selections]
	S-A-F8: [ensure_selections_forward flip_selections extend_prev_long_word_start trim_selections]
	S-A-F9: [ensure_selections_forward extend_prev_long_word_end trim_selections]
	e: [move_prev_word_start trim_selections]
	f: [move_next_word_end trim_selections]
	# -------------------------lining--------------------------
	C-A-x: [ensure_selections_forward extend_to_file_end]
	C-A-z: [ensure_selections_forward flip_selections extend_to_file_start]
	S-end: [ensure_selections_forward extend_to_line_end_newline]
	S-home: [ensure_selections_forward flip_selections extend_to_line_start]
	end: [ensure_selections_forward extend_to_line_end]
	home: [ensure_selections_forward flip_selections extend_to_first_nonwhitespace]
	# -------------------------keyful--------------------------
	A-home: [goto_file_start search_next]
	A-end: [goto_file_end search_prev]
	# [[sort on]]
	A-ret: ':e %(selection)'
	S-tab: "@<space>'<up><ret>"
	backspace: [save_selection select_all yank_to_clipboard jump_backward]
	del: { S-del: [':sh rm %(full_path)' ':buffer-close!'] }
	esc: [save_selection keep_primary_selection normal_mode]
	ret: command_mode
	tab: "@<space>'<down><ret>"
	# [[sort off]]
	# -------------------------paging--------------------------
	pagedown: page_cursor_half_down
	pageup: page_cursor_half_up
	C-pagedown: [select_mode page_cursor_half_down normal_mode]
	C-pageup: [select_mode page_cursor_half_up normal_mode]
	L: goto_next_paragraph
	H: goto_prev_paragraph
	A-h: [select_mode goto_prev_paragraph normal_mode]
	A-l: [select_mode goto_next_paragraph normal_mode]
	# : [collapse_selection select_mode goto_next_paragraph normal_mode trim_selections]
	# -------------------------lining--------------------------
	A-J: [extend_to_line_bounds ensure_selections_forward select_line_above]
	A-K: [extend_to_line_bounds ensure_selections_forward flip_selections select_line_below]
	J  : [extend_to_line_bounds extend_line_below]
	K  : [extend_to_line_bounds extend_line_above]
	# ----------------------characterwise----------------------
	left : extend_char_left
	right: extend_char_right
	A-j  : extend_visual_line_down
	A-k  : extend_visual_line_up
	# ---------------------------lsp---------------------------
	'└': goto_declaration
	'│': code_action
	'┴': goto_type_definition
	'─': goto_definition
	'┬': goto_reference
	'┤': goto_implementation
	'┐': rename_symbol
	'├': hover
	m: {
		# [[sort on]]
		';': ':toggle soft-wrap.enable'
		M: ':sh chmod +x %(full_path)'
		a: ':new'
		d: surround_delete
		f: surround_replace
		i: ':sh fish -c "append_github_line_numbers %(cursor_line)"'
		k: ':toggle enable-diagnostics'
		l: ':toggle lsp.display-inlay-hints'
		o: ':fmt'
		s: surround_add
		# [[sort off]]
		t: {
			k: ':pipe \"<kbd>" + $in + "</kbd>"'
			b: ':pipe \"<b>" + $in + "</b>"'
			h: ':pipe \"<h>" + $in + "</h>"'
			d: ':pipe \"<div>" + $in + "</div>"'
			c: ':pipe \"<cd>" + $in + "</cd>"'
			o: ':pipe \"<o>" + $in + "</o>"'
			i: ':pipe \"<i>" + $in + "</i>"'
		}
		'w': {
			'(': ':pipe strip-wrapper-type.rs b'
			'{': ':pipe strip-wrapper-type.rs B'
			'[': ':pipe strip-wrapper-type.rs s'
			'<': ':pipe strip-wrapper-type.rs t'
			'|': ':pipe strip-wrapper-type.rs p'
		}
		'e': {
			'(': ':pipe wrap-in-block.rs b'
			'{': ':pipe wrap-in-block.rs B'
			'[': ':pipe wrap-in-block.rs s'
			'<': ':pipe wrap-in-block.rs t'
			'|': ':pipe wrap-in-block.rs p'
			'`': ':pipe wrap-in-block.rs "`"'
			'"': ':pipe wrap-in-block.rs `"`'
			j: ':pipe wrap-in-block.rs "`"'
			e: ':pipe wrap-in-block.rs begin'
		}
	}
	space: {
		A-c: null
		G: null
		Y: null
		# [[sort on]]
		'`': switch_case
		D: diagnostics_picker
		J: command_palette
		K: syntax_workspace_symbol_picker
		L: workspace_symbol_picker
		d: (open ~/fes/dot/helix/magazine.nu | from nuon)
		e: buffer_picker
		f: file_picker_in_current_directory
		j: file_picker_in_current_buffer_directory
		k: syntax_symbol_picker
		l: symbol_picker
		space: [':noop %sh{~/fes/dot/helix/generator.nu}', ':config-reload']
		w: global_search
		# [[sort off]]
		g: ':open %sh("plans.md" | if ($in | path exists) {} else { "%{working_directory}" | path basename | "~/fes/talia/" + $in + "/plans.md" })'
		h: ':open %sh("thoughts.md" | if ($in | path exists) {} else { "%{working_directory}" | path basename | "~/fes/talia/" + $in + "/thoughts.md" })'
		b: ':open %sh("system.md" | if ($in | path exists) {} else { "%{working_directory}" | path basename | "~/fes/talia/" + $in + "/system.md" })'
	}
	g: {
		D: null
		c: null
		d: null
		# [[sort on]]
		I: ':buffer-close-all!'
		O: ':buffer-close-others!'
		Q: ':cd %(buffer_parent)'
		g: ':reset-diff-change'
		i: ':buffer-close-all'
		o: ':buffer-close-others'
		q: ':cd %sh(git -C `%(buffer_parent)` rev-parse --show-toplevel)'
		r: ':lsp-restart'
		# [[sort off]]
	}
}

let insert_mappings = {
	# [[sort on]]
	C-h: commit_undo_checkpoint
	C-j: '@<esc>jski<C-v>'
	C-k: '@<esc>ksji<C-v>'
	C-l: '@<C-h> \<ret>'
	C-u: kill_to_line_start
	C-v: [collapse_selection paste_before]
	C-ц: [normal_mode move_prev_word_start change_selection]
	down: completion
	end: [commit_undo_checkpoint insert_at_line_end]
	home: [commit_undo_checkpoint insert_at_line_start]
	left: [commit_undo_checkpoint move_char_left]
	right: [commit_undo_checkpoint move_char_right]
	up: completion
	# [[sort off]]
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
    S-down: move_lines_down
    S-up: move_lines_up
}

let normal_mappings_fork = {
	'D': mark_apply
	'S': mark_replace
	'W': mark_add
	'❌': "@vk'~"
	✅: '@vk~'
	# [[sort on]]
	'.': extend_to_line_bounds
	'0': ':buffer-nth -r 1'
	'1': ':buffer-nth 1'
	'2': ':buffer-nth 2'
	'3': ':buffer-nth 3'
	'4': ':buffer-nth 4'
	'5': ':buffer-nth 5'
	'6': ':buffer-nth 6'
	'7': ':buffer-nth 7'
	'8': ':buffer-nth 8'
	'9': ':buffer-nth 9'
	'—': select_character
	'→': retain_column
	'␈': ':random'
	'⤒': ':uniq'
	A-B: [add_newline_above move_line_up paste_before_all]
	A-O: paste_before_all
	A-b: [add_newline_below move_line_down paste_before_all]
	A-o: paste_after_all
	C-/: select_first_and_last_chars
	P: copy_register_to_yank
	S-A-F1: [extend_prev_sibling ensure_selections_forward flip_selections]
	S-A-F2: [extend_next_sibling ensure_selections_forward]
	p: copy_yank_to_register
	u: append_mode_same_line
	# [[sort off]]
	# --------------------------leap---------------------------
	'<': [collapse_selection extend_flash_backward]
	'>': [collapse_selection extend_flash_forward]
	'C-,': [collapse_selection extend_flash_backward_till]
	'C-.': [collapse_selection extend_flash_forward_till]
	'A-,': [ensure_selections_forward flip_selections extend_flash_backward]
	'A-.': [ensure_selections_forward extend_flash_forward]
	'C-A-,': [ensure_selections_forward flip_selections extend_flash_backward_till]
	'C-A-.': [ensure_selections_forward extend_flash_forward_till]
	v: harp_mark
	w: harp_search
	z: harp_register
	'┌': goto_hover
	m: {
		# [[sort on]]
		C-c: ':echopy %(full_path):%(cursor_line)'
		C: ':echopy %(relative_path)'
		V: ':echopy %sh(ghl -pb HEAD %(relative_path))'
		Z: ':echopy %sh(ghl)'
		c: ':echopy %(full_path)'
		v: ':echopy %sh(ghl %(relative_path))'
		x: [yank ':new' paste_before_all]
		z: ':echopy %{working_directory}'
		# [[sort off]]
		t: { t: surround_add_tag }
	}
	space: {
		a: harp_command
		i: local_search_fuzzy
		o: local_search_section
		r: harp_relative_file
		s: harp_file
	}
	g: {
		H: ':buffer-close-previous!'
		L: ':buffer-close-next!'
		h: ':buffer-close-previous'
		l: ':buffer-close-next'
	}
}

let insert_mappings_fork = {
	C-a: [collapse_selection ':insert-output fish -c "uclanr | read"' append_mode_same_line]
	'C-;': harp_register
}

let russian_mapping = (open ~/fes/dot/helix/russian.nu | from nuon)
def rusify_key [] {
	let IN = $in
	$IN | if ($in | str length | $in == 1) {
		$russian_mapping | get -o $IN | default $IN
	} else {
		try {
			parse '{prefix}-{chr}' | into record | let obj
			$'($obj.prefix)-($russian_mapping | get $obj.chr)'
		} catch { $IN }
	}
}

def transform_value [] {
	default 'no_op'
	| if ($in | describe | $in starts-with record) {
		items { |key, value|
			{ key: $key, value: ($value | transform_value) }
		} | transpose -dr
	} else {}
}

def rusify [] {
	items { |key, value|
		let new_key = $key | rusify_key
		let value = $value | transform_value
		let new_value = $value | if ($in | describe | $in starts-with record) { rusify } else {}
		[
			{ key: $key, value: $value }
			{ key: $new_key, value: $new_value }
		]
	}
	| flatten
	| transpose -dr
}

let mappings = {
	normal: ($all_mappings | merge deep $normal_mappings | rusify)
	insert: ($all_mappings | merge deep $insert_mappings | rusify)
}

let entire_config = {
    theme: gruvbox_material
    editor: $editor
    keys: $mappings
}

let mappings_fork = {
	normal: ($all_mappings_fork | merge deep $normal_mappings_fork | rusify)
	insert: ($all_mappings_fork | merge deep $insert_mappings_fork | rusify)
}
let entire_config_fork = $entire_config | merge deep { editor: $editor_fork, keys: $mappings_fork }

$entire_config      | to toml | save -f ~/fes/dot/helix/pure.toml
$entire_config_fork | to toml | save -f ~/fes/dot/helix/config.toml

let latest = $entire_config_fork
$latest | upsert editor.bufferline 'never' | let latest ; $latest | to toml | save -f ~/fes/dot/helix/sleek.toml
$entire_config_fork | merge deep {
	keys: {
		normal: { A-space: ':quit-all!' }
		insert: { A-space: ':quit-all!' }
	}
} | let latest ; $latest | to toml | save -f ~/fes/dot/helix/man.toml
$latest | upsert editor.soft-wrap.enable false | let latest ; $latest | to toml | save -f ~/fes/dot/helix/pager.toml
