return {
	'uga-rosa/ccc.nvim',
	event = 'User WayAfter',
	keys = {
		{ 'cp', '<Cmd>CccPick<CR>' },
	},
	cmd = { 'CccPick', 'CccConvert', 'CccHighlighterEnable', 'CccHighlighterDisable', 'CccHighlighterToggle' },
	opts = function()
		return {
			point_char = '',
			preserve = false,
			save_on_quit = true,
			alpha_show = 'hide',
			highlighter = {
				update_insert = false,
				auto_enable = true,
				lsp = true,
			},
			win_opts = {
				border = 'none',
			},
			inputs = {
				require('ccc').input.rgb,
				require('ccc').input.hsl,
			},
			outputs = {
				require('ccc').output.hex,
				require('ccc').output.css_hsl,
				require('ccc').output.css_rgb,
			},
			convert = {
				{ require('ccc').picker.hex, require('ccc').output.css_hsl },
				{ require('ccc').picker.css_hsl, require('ccc').output.css_rgb },
				{ require('ccc').picker.css_rgb, require('ccc').output.hex },
			},
			pickers = {
				require('ccc').picker.hex,
				require('ccc').picker.css_rgb,
				require('ccc').picker.css_hsl,
				-- require('ccc').picker.css_name,
				require('ccc').picker.ansi_escape({
					foreground = env.color.white,
					background = env.color.level,
					black = env.color.black,
					red = env.color.red,
					green = env.color.green,
					yellow = env.color.yellow,
					blue = env.color.cyan,
					magenta = env.color.blush,
					cyan = env.color.cyan,
					white = env.color.white,
					bright_black = env.color.black,
					bright_red = env.color.red,
					bright_green = env.color.green,
					bright_yellow = env.color.yellow,
					bright_blue = env.color.cyan,
					bright_magenta = env.color.magenta,
					bright_cyan = env.color.cyan,
					bright_white = env.color.white,
				}, { meaning1 = 'bold' }),
			},
			mappings = {
				H = require('ccc').mapping.decrease5,
				['<A-h>'] = require('ccc').mapping.decrease10,
				L = require('ccc').mapping.increase5,
				['<A-l>'] = require('ccc').mapping.increase10,
				['^'] = require('ccc').mapping.set0,
				['$'] = require('ccc').mapping.set100,
			},
		}
	end,
	config = function(_, opts)
		require('ccc').setup(opts)
		if vim.tbl_get(opts, 'highlighter', 'auto_enable') then vim.cmd.CccHighlighterEnable() end
	end,
}
