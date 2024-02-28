return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = {
					icons_enabled = true,
					theme = 'gruvbox-material',
					component_separators = '',
					section_separators = '',
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						{
							'mode',
							padding = 1,
							fmt = function (mode, _)
								return mode:sub(1, 1)
							end
						}
					},
					lualine_b = { 'diagnostics' },
					lualine_c = {
						{
							'filename',
							path = 3, -- absolute path with ~ instead of $HOME
							shorting_target = 40, -- shorten path to leave [blank] spaces for everything else
							symbols = {
								modified = '!!!',
								readonly = ' ',
								unnamed = '???',
								newfile = '!'
							}
						}
					},
					lualine_x = {
						{
							'encoding',
							padding = 0
						},
						{
							'fileformat',
							padding = { left = 1, right = 0 },
							symbols = {
								unix = 'cr',
								dos = 'crlf',
								mac = 'lf'
							}
						},
						{
							'filetype',
							padding = 1
						}
					},
					lualine_y = {
						{
							'searchcount',
							padding = { left = 1, right = 0 }
						},
						'progress'
					},
					lualine_z = {
						{
							'selectioncount',
							padding = { left = 1, right = 0 }

						},
						{
							'location',
							padding = { left = 0, right = 1 }
						}
					},
				},
			})
		end,
	},
}
