source always.nu
source zoxide.nu

# [[sort on]]
$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_INDICATOR = $'(ansi '#af87ff') 󱕅 '
$env.PROMPT_MULTILINE_INDICATOR = '▌'
$env.config.completions.algorithm = 'prefix' # "prefix"|"substring"|"fuzzy"
$env.config.cursor_shape.emacs = 'line'
$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true
$env.config.shell_integration.osc2 = false
$env.config.show_banner = false
$env.config.use_kitty_protocol = true # ^i and tab are different
# [[sort off]]

$env.config.abbreviations = {
	f: 'z'
}

$env.config.hooks.pre_prompt = [
	{
		if ($env.TIT? | is-empty) {
			tit ($env.PWD | path shrink | path basename)
		}
	}
]

$env.PROMPT_COMMAND = { ||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-dir }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let pink = $'(ansi "#ffafd7")(ansi bo)'
    let path_segment = $"($pink)($dir)(ansi reset)"

    $path_segment | str replace '~' $'(ansi "#ff8787")~($pink)'
}

$env.config.keybindings ++= [
	{
		name: copy_commandline
		modifier: control
		keycode: char_x
		mode: [emacs]
		event: {
			send: ExecuteHostCommand
			cmd: 'commandline | wl-copy -n'
		}
	}
	{
		name: paste_clipboard
		modifier: control
		keycode: char_v
		mode: [emacs]
		event: {
			send: ExecuteHostCommand
			cmd: 'wl-paste -n | commandline edit -i $in'
		}
	}
	{
		name: append_pager
		modifier: alt
		keycode: char_p
		mode: [emacs]
		event: [
			{ send: ExecuteHostCommand, cmd: "commandline edit -a ' | explore'" }
			# { edit: InsertString, value: ' | explore' }
			# { send: Enter }
		]
	}
	{
		name: edit_commandline
		modifier: alt
		keycode: char_i
		mode: [emacs]
		event: { send: OpenEditor }
	}
	{
		name: line_below
		modifier: control
		keycode: char_o
		mode: [emacs]
		event: { edit: InsertNewlineBelow }
	}
	{
		name: line_above
		modifier: control
		keycode: char_i
		mode: [emacs]
		event: { edit: InsertNewlineAbove }
	}
]
$env.config.menus ++= [
{
	name: history_menu
	only_buffer_difference: true # Search is done on the text written after activating the menu
	marker: '  '                # Indicator that appears with the menu is active
	type: {
		layout: list  # Type of menu
		page_size: 10 # Number of entries that will presented when activating the menu
	}
	style: {
		text: white              # Text style
		selected_text: { fg: white, bg: '#5f472d', attr: b } # Text style for selected option
		description_text: yellow # Text style for description
	}
}
{
	name: help_menu
	only_buffer_difference: true
	marker: '  '
	type: {
		layout: description
		columns: 5
		# col_width is an optional value. If missing, the entire screen width is used to
		# calculate the column width
		# col_width: 20
		col_padding: 1
		selection_rows: 5
		description_rows: 25
	}
	style: {
		text: white
		selected_text: { bg: '#5f472d', attr: b }
		description_text: yellow
	}
}
]
$env.config.explore = {
	command_bar_text: white
	selected_cell: { bg: '#5f472d', attr: b }
	status_bar_background: white
	status: {
		error: red
		warn: yellow
		info: cyan
		success: green
	},
}
