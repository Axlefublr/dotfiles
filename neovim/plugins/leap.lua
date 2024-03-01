return {
	{
		'ggandor/leap.nvim',
		opts = {
			case_sensitive = false,
			max_phase_one_targets = 1,
			equivalence_classes = {
				' \t\n\r',
				'qй',
				'wц',
				'eу',
				'rк',
				'tе',
				'yн',
				'uг',
				'iш',
				'oщ',
				'pз',
				'[х',
				']ъ',
				'aф',
				'sы',
				'dв',
				'fа',
				'gп',
				'hр',
				'jо',
				'kл',
				'lд',
				';ж',
				"'э",
				'zя',
				'xч',
				'cс',
				'vм',
				'bи',
				'nт',
				'mь',
				',б',
				'.ю',
			},
			labels = {
				'f',
				'j',
				'd',
				'k',
				's',
				'l',
				'a',
				'e',
				'i',
				'w',
				'o',
				'g',
				'h',
				'r',
				'u',
				'x',
				'c',
				'z',
				'/',
				'v',
				'm',
				't',
				'y',
				'q',
				'p',
			},
			safe_labels = {},
		},
		init = function()
			vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-forward-to)')
			vim.keymap.set({ 'n', 'x', 'o' }, 'Q', '<Plug>(leap-backward-to)')
			vim.keymap.set({ 'n', 'x', 'o' }, ',q', '<Plug>(leap-forward-till)')
			vim.keymap.set({ 'n', 'x', 'o' }, ',Q', '<Plug>(leap-backward-till)')

			vim.api.nvim_create_autocmd('User', {
				pattern = 'LeapEnter',
				callback = function()
					vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = Colors.black, bg = Colors.shell_pink })
					vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = Colors.black, bg = Colors.shell_yellow })
				end,
			})
		end,
	},
}
