return {
	'VoxelPrismatic/rabbit.nvim',
	event = 'BufEnter',
	keys = 'g;',
	cmd = 'Rabbit',
	opts = {
		colors = {
			title = {
				fg = Colors.shell_yellow, -- Grabs from :hi Normal
				bold = true,
			},
			index = {
				fg = Colors.blush, -- Grabs from :hi Comment
				italic = false,
			},
			dir = Colors.grey, -- Folders; Grabs from :hi NonText

			-- term = { -- Addons, eg :term or :Oil
			-- 	fg = '#000000', -- Grabs from :hi Constant
			-- 	italic = true,
			-- },
			-- noname = { -- No buffer name set
			-- 	fg = '#000000', -- Grabs from :hi Function
			-- 	italic = true,
			-- },
			-- message = {
			-- 	fg = '#000000', -- Grabs from :hi Identifier
			-- 	italic = true,
			-- },
		},

		window = {
			box = {
				top_left = '',
				top_right = '',
				bottom_left = '',
				bottom_right = '',
				vertical = '',
				horizontal = '',
				emphasis = '',
			},

			width = 30,
			height = 15,

			-- * "bottom" means in the bottom left corner, but not displayed in full screen
			-- * "title" means next to rabbit, eg `──══ Rabbit History ══──`
			-- * "hide" means to not display it at all
			plugin_name_position = 'hide',

			-- title = 'Rabbit',

			emphasis_width = 0, -- Eg: `──────══ Rabbit ══──────` or `──══════ Rabbit ══════──`

			-- float = 'center',
			float = {
				left = 4,
				top = 0,
			},

			overflow = '', -- String to display when folders overflow
			path_len = 0, -- How many characters to display in folder name before cutting off
		},

		default_keys = {
			close = { -- Default bindings to close Rabbit
				'<Esc>',
			},

			select = { -- Default bindings to select a buffer
				'<CR>',
			},

			open = { -- Default bindings to open Rabbit
				'g;',
			},
		},

		enable = {
			'history',
		},
	},
}
