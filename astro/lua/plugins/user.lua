---@type LazySpec
return {
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
	},
	{
		'rcarriga/nvim-notify',
		config = function(plugin, opts)
			opts.background_colour = '#292828'
			require('astronvim.plugins.configs.notify')(plugin, opts)
		end,
	},
}
