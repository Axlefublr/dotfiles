---@type LazySpec
return {
	'nvim-treesitter/nvim-treesitter',
	opts = function(_, opts)
		opts.textobjects = nil
		return require('astrocore').extend_tbl(opts, {
			highlight = {
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = false,
					keymaps = {
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ia'] = '@parameter.inner',
						['aa'] = '@parameter.outer',
						['ic'] = '@call.inner',
						['ac'] = '@call.outer',
						['ir'] = '@conditional.inner',
						['ar'] = '@conditional.outer',
					},
				},
				swap = {
					enable = true,
					swap_next = {
						[']]f'] = '@function.inner',
						[']]F'] = '@function.outer',
						[']]A'] = '@parameter.outer',
						[']]a'] = '@parameter.inner',
						[']]c'] = '@call.inner',
						[']]C'] = '@call.outer',
						[']]r'] = '@conditional.inner',
						[']]R'] = '@conditional.outer',
					},
					swap_previous = {
						['[[f'] = '@function.inner',
						['[[F'] = '@function.outer',
						['[[a'] = '@parameter.inner',
						['[[A'] = '@parameter.outer',
						['[[c'] = '@call.inner',
						['[[C'] = '@call.outer',
						['[[r'] = '@conditional.inner',
						['[[R'] = '@conditional.outer',
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						[']f'] = '@function.outer',
						[']a'] = '@parameter.outer',
						[']c'] = '@call.outer',
						[']r'] = '@conditional.outer',
					},
					goto_next_end = {
						[']F'] = '@function.outer',
						[']A'] = '@parameter.outer',
						[']C'] = '@call.outer',
						[']R'] = '@conditional.outer',
					},
					goto_previous_start = {
						['[f'] = '@function.outer',
						['[a'] = '@parameter.outer',
						['[c'] = '@call.outer',
						['[r'] = '@conditional.outer',
					},
					goto_previous_end = {
						['[F'] = '@function.outer',
						['[A'] = '@parameter.outer',
						['[C'] = '@call.outer',
						['[R'] = '@conditional.outer',
					},
				},
			},
		})
	end,
}
