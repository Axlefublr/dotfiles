---@type LazySpec
return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
	opts = function(_, opts)
		return require('astrocore').extend_tbl(opts, {
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = false,
					keymaps = {
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['is'] = '@assignment.inner',
						['as'] = '@assignment.outer',
						['ig'] = '@block.inner',
						['ag'] = '@block.outer',
						['ia'] = '@parameter.inner',
						['aa'] = '@parameter.outer',
						['ic'] = '@call.inner',
						['ac'] = '@call.outer',
						['i/'] = '@comment.inner',
						['a/'] = '@comment.outer',
						['ir'] = '@conditional.inner',
						['ar'] = '@conditional.outer',
						['io'] = '@loop.inner',
						['ao'] = '@loop.outer',
						['it'] = '@return.inner',
						['at'] = '@return.outer',
						['ix'] = '@class.inner',
						['ax'] = '@class.outer',
					},
					selection_modes = {
						-- ['@function.outer'] = '<c-v>'
					},
				},
				swap = {
					enable = true,
					swap_next = {
						[']]f'] = '@function.inner',
						[']]F'] = '@function.outer',
						[']]s'] = '@assignment.inner',
						[']]S'] = '@assignment.outer',
						[']]g'] = '@block.inner',
						[']]G'] = '@block.outer',
						[']]A'] = '@parameter.outer',
						[']]a'] = '@parameter.inner',
						[']]c'] = '@call.inner',
						[']]C'] = '@call.outer',
						[']]/'] = '@comment.inner',
						[']]?'] = '@comment.outer',
						[']]r'] = '@conditional.inner',
						[']]R'] = '@conditional.outer',
						[']]o'] = '@loop.inner',
						[']]O'] = '@loop.outer',
						[']]t'] = '@return.inner',
						[']]T'] = '@return.outer',
						[']]x'] = '@class.inner',
						[']]X'] = '@class.outer',
					},
					swap_previous = {
						['[[f'] = '@function.inner',
						['[[F'] = '@function.outer',
						['[[s'] = '@assignment.inner',
						['[[S'] = '@assignment.outer',
						['[[g'] = '@block.inner',
						['[[G'] = '@block.outer',
						['[[a'] = '@parameter.inner',
						['[[A'] = '@parameter.outer',
						['[[c'] = '@call.inner',
						['[[C'] = '@call.outer',
						['[[/'] = '@comment.inner',
						['[[?'] = '@comment.outer',
						['[[r'] = '@conditional.inner',
						['[[R'] = '@conditional.outer',
						['[[o'] = '@loop.inner',
						['[[O'] = '@loop.outer',
						['[[t'] = '@return.inner',
						['[[T'] = '@return.outer',
						['[[x'] = '@class.inner',
						['[[X'] = '@class.outer',
					},
				},
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						[']f'] = '@function.outer',
						[']s'] = '@assignment.inner',
						[']g'] = '@block.outer',
						[']a'] = '@parameter.outer',
						[']c'] = '@call.outer',
						[']/'] = '@comment.outer',
						[']r'] = '@conditional.outer',
						[']o'] = '@loop.outer',
						[']t'] = '@return.outer',
						[']x'] = '@class.outer',
					},
					goto_next_end = {
						[']F'] = '@function.outer',
						[']S'] = '@assignment.inner',
						[']G'] = '@block.outer',
						[']A'] = '@parameter.outer',
						[']C'] = '@call.outer',
						[']?'] = '@comment.outer',
						[']R'] = '@conditional.outer',
						[']O'] = '@loop.outer',
						[']T'] = '@return.outer',
						[']X'] = '@class.outer',
					},
					goto_previous_start = {
						['[f'] = '@function.outer',
						['[s'] = '@assignment.inner',
						['[g'] = '@block.outer',
						['[a'] = '@parameter.outer',
						['[c'] = '@call.outer',
						['[/'] = '@comment.outer',
						['[r'] = '@conditional.outer',
						['[o'] = '@loop.outer',
						['[t'] = '@return.outer',
						['[x'] = '@class.outer',
					},
					goto_previous_end = {
						['[F'] = '@function.outer',
						['[S'] = '@assignment.inner',
						['[G'] = '@block.outer',
						['[A'] = '@parameter.outer',
						['[C'] = '@call.outer',
						['[?'] = '@comment.outer',
						['[R'] = '@conditional.outer',
						['[O'] = '@loop.outer',
						['[T'] = '@return.outer',
						['[X'] = '@class.outer',
					},
				},
			},
		})
	end,
}
