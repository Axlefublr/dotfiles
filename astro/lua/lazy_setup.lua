require('lazy').setup({
	{
		'AstroNvim/AstroNvim',
		version = '^4',
		import = 'astronvim.plugins',
		opts = {
			mapleader = ',',
			maplocalleader = ',',
			icons_enabled = true,
			pin_plugins = nil,
		},
	},
	{ import = 'community' },
	{ import = 'plugins' },
} --[[@as LazySpec]], {
	install = { colorscheme = { 'sainnhe/gruvbox-material' } },
	ui = { backdrop = 100 },
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			-- disable some rtp plugins, add more to your liking
			disabled_plugins = {
				'gzip',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'zipPlugin',
			},
		},
	},
} --[[@as LazyConfig]])
