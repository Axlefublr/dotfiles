source coco.nu
# [[sort on]]
$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_INDICATOR = ' 󱕅 '
$env.PROMPT_MULTILINE_INDICATOR = '▌'
$env.config.completions.algorithm = 'prefix' # "prefix"|"substring"|"fuzzy"
$env.config.cursor_shape.emacs = 'line'
$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true
$env.config.show_banner = false
$env.config.use_kitty_protocol = true # ^i and tab are different
alias z = cd
# [[sort off]]
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
		name: edit_commandline
		modifier: alt
		keycode: char_e
		mode: [emacs]
		event: { send: OpenEditor }
	}
	{
		name: copy_color_commandline
		modifier: control_alt
		keycode: char_x
		mode: [emacs vi_insert vi_normal]
		event: {
			send: executehostcommand
			cmd: 'commandline | bahex.nu'
		}
	}
]
$env.config.menus ++= [
{
	name: history_menu
	only_buffer_difference: true # Search is done on the text written after activating the menu
	marker: '  '                # Indicator that appears with the menu is active
	type: {
		layout: list  # Type of menu
		page_size: 10 # Number of entries that will presented when activating the menu
	}
	style: {
		text: white              # Text style
		selected_text: { fg: white bg: '#5f472d' } # Text style for selected option
		description_text: yellow # Text style for description
	}
}
{
	name: help_menu
	only_buffer_difference: true
	marker: '  '
	type: {
		layout: description
		columns: 5
		# col_width is an optional value. If missing, the entire screen width is used to
		# calculate the column width
		# col_width: 20
		col_padding: 2
		selection_rows: 3
		description_rows: 20
	}
	style: {
		text: white
		selected_text: { fg: white bg: '#5f472d' }
		description_text: yellow
	}
}
]
