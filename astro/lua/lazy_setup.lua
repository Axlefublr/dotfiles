require('lazy').setup({
	{ import = 'autism' },
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
	install = { colorscheme = { 'gruvbox-material' } },
	ui = { backdrop = 100 },
	change_detection = {
		notify = false,
	},
	checker = {
		enabled = false,
		frequency = 60 * 60 * 24,
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
				'tutor',
			},
		},
	},
	dev = {
		path = "~/prog/proj"
	}
} --[[@as LazyConfig]])
