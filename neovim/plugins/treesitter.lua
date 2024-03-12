local opts = {
	ensure_installed = {
		'lua',
		'rust',
		'fish',
		'rasi',
		'c',
		'vim',
		'vimdoc',
		'query',
		'c_sharp',
		'css',
		'diff',
		'gitcommit',
		'gitignore',
		'html',
		'json',
		'jsonc',
		'markdown',
		'toml',
		'xcompose',
		'yaml',
	},
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = ',ds',
			scope_incremental = ',dc',
			node_incremental = '<a-]>',
			node_decremental = '<a-[>',
		},
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
}

return {
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = 'nvim-treesitter',
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup(opts)

			vim.opt.foldmethod = 'expr'
			vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
			vim.opt.foldenable = false
			require('nvim-treesitter.install').prefer_git = true
			local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

			vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
			vim.keymap.set({ 'n', 'x', 'o' }, ':', ts_repeat_move.repeat_last_move_opposite)
			vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
			vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
			vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
			vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)

			vim.keymap.set({ 'n', 'x' }, ',lp', '<cmd>Inspect<cr>')
		end,
	},
}
