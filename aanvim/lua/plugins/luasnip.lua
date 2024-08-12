---@type LazyPluginSpec
return {
	'L3MON4D3/LuaSnip',
	lazy = true,
	build = 'make install_jsregexp',
	dependencies = {
		{
			'hrsh7th/nvim-cmp',
			opts = function(_, opts)
				if not opts.snippet then opts.snippet = {} end
				opts.snippet.expand = function(args) require('luasnip').lsp_expand(args.body) end
			end,
		},
	},
	opts = {
		history = true,
		update_events = { 'TextChanged', 'TextChangedI' },
		delete_check_events = 'TextChanged',
		region_check_events = 'CursorMoved',
	},
	config = function(_, opts)
		require('luasnip').config.setup(opts)
		require('luasnip.loaders.from_lua').load({ paths = { '~/prog/dotfiles/!nvim/snippets' } })
	end,
}
