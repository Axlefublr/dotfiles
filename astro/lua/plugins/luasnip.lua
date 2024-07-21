return {
	{
		'L3MON4D3/LuaSnip',
		config = function(_, opts)
			require("luasnip").config.setup(opts)
			require("luasnip.loaders.from_lua").load({ paths = '~/.config/nvim/snippets' })
		end
	},
}
