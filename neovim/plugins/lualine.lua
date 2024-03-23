return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		opts = {
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
						fmt = function(mode, _) return mode:sub(1, 1) end,
					},
				},
				lualine_b = { 'diff', 'diagnostics' },
				lualine_c = {
					{
						'filename',
						path = 3, -- absolute path with ~ instead of $HOME
						shorting_target = 35, -- shorten path to leave [blank] spaces for everything else
						symbols = {
							modified = '!!!',
							readonly = ' ',
							unnamed = '???',
							newfile = '!',
						},
					},
				},
				lualine_x = {
					{
						'filetype',
						padding = 1,
					},
					{
						'encoding',
						padding = 0,
					},
					{
						'fileformat',
						padding = 1,
						symbols = {
							unix = 'cr',
							dos = 'cl',
							mac = 'lf',
						},
					},
				},
				lualine_y = {
					{
						'tabs',
						cond = function() return #vim.api.nvim_list_tabpages() > 1 end,
					},
					'progress',
				},
				lualine_z = {
					{
						'selectioncount',
						padding = { left = 1, right = 0 },
					},
					{
						'location',
						padding = { left = 1, right = 1 },
					},
				},
			},
		},
	},
}
