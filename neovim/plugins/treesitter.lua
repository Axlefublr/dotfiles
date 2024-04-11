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
}

return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
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
