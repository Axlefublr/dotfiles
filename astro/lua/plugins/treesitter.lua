---@type LazySpec
return {
	'nvim-treesitter/nvim-treesitter',
	opts = function(_, opts)
		opts.textobjects = nil
		return require('astrocore').extend_tbl(opts, {
			highlight = {
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = { enable = false },
			textobjects = {
				select = { enable = false },
				swap = { enable = false },
				move = { enable = false },
			},
		})
	end,
}
