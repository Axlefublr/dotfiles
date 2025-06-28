# This file is loaded after env.nu and before login.nu
# [[sort on]]
$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_INDICATOR = ' 󱕅 '
$env.PROMPT_MULTILINE_INDICATOR = '▌'
$env.config.color_config.bool = { fg: '#b58cc6' }
$env.config.color_config.header = { fg: '#e49641', attr: b }
$env.config.color_config.hints = { fg: '#928374' }
$env.config.color_config.row_index = { fg: '#e491b2' }
$env.config.color_config.shape_bool = { fg: '#b58cc6' }
$env.config.color_config.shape_external = { fg: '#ea6962' }
$env.config.color_config.shape_external_resolved = { fg: '#e491b2' }
$env.config.color_config.shape_float = { fg: '#e491b2' }
$env.config.color_config.shape_garbage = { fg: '#ea6962' }
$env.config.color_config.shape_int = { fg: '#e491b2' }
$env.config.color_config.shape_internalcall = { fg: '#a9b665' }
$env.config.color_config.shape_nothing = { fg: '#b58cc6' }
$env.config.color_config.shape_operator = { fg: '#e49641' }
$env.config.color_config.shape_pipe = { fg: '#e49641' }
$env.config.color_config.shape_string = { fg: '#d3ad5c' }
$env.config.color_config.shape_variable = { fg: '#e49641' }
$env.config.completions.algorithm = 'prefix' # "prefix"|"substring"|"fuzzy"
$env.config.cursor_shape.emacs = 'line'
$env.config.datetime_format.normal = '%y.%m.%d %H:%M:%S %A'
$env.config.datetime_format.table = null
$env.config.display_errors.exit_code = false # print nushell error for externals, rather than the external's output
$env.config.float_precision = 3
$env.config.footer_mode = 'auto'
$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true
$env.config.rm.always_trash = true
$env.config.show_banner = false
$env.config.table.footer_inheritance = true
$env.config.table.missing_value_symbol = '󰟢'
$env.config.table.mode = 'single'
$env.config.table.padding.left = 0
$env.config.table.padding.right = 0
$env.config.table.show_empty = true # “no values” when list or table is empty
$env.config.table.trim.wrapping_try_keep_words = false
$env.config.use_kitty_protocol = true # ^i and tab are different
const NU_LIB_DIRS = [ '~/fes/dot/nu/blue' '~/.config/nushell/scripts' '~/.local/share/nushell/completions' ]
# [[sort off]]
$env.config.menus ++= [{
	name: history_menu
	only_buffer_difference: true # Search is done on the text written after activating the menu
	marker: '  '                # Indicator that appears with the menu is active
	type: {
		layout: list  # Type of menu
		page_size: 10 # Number of entries that will presented when activating the menu
	}
	style: {
		text: green                  # Text style
		selected_text: green_reverse # Text style for selected option
		description_text: yellow     # Text style for description
	}
}]
