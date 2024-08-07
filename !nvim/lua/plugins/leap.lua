---@type LazyPluginSpec
return {
	'ggandor/leap.nvim',
	keys = {
		{ 'q', mode = { 'n', 'x', 'o' } },
		{ 'Q', mode = { 'n', 'x', 'o' } },
		{ 'x', mode = { 'x', 'o' } },
		{ 'X', mode = { 'x', 'o' } },
	},
	opts = {
		case_sensitive = false,
		max_phase_one_targets = 0,
		-- stylua: ignore
		equivalence_classes = { ' \t\n\r', 'qй', 'wц', 'eу', 'rк', 'tе', 'yн', 'uг', 'iш', 'oщ', 'pз', '[х', ']ъ', 'aф', 'sы', 'dв', 'fа', 'gп', 'hр', 'jо', 'kл', 'lд', ';ж', "'э", 'zя', 'xч', 'cс', 'vм', 'bи', 'nт', 'mь', ',б', '.ю', },
		-- stylua: ignore
		labels = { 'f', 'j', 'd', 'k', 's', 'l', 'a', 'e', 'i', 'w', 'o', 'g', 'h', 'r', 'u', 'x', 'c', 'z', '/', 'v', 'm', 't', 'y', 'q', 'p', },
		safe_labels = {},
	},
	config = function(_, opts)
		require('leap').setup(opts)
		env.map('nxo', 'q', '<Plug>(leap-forward-to)')
		env.map('nxo', 'Q', '<Plug>(leap-backward-to)')
		env.map('xo', 'x', '<Plug>(leap-forward-till)')
		env.map('xo', 'X', '<Plug>(leap-backward-till)')

		env.acmd('User', 'LeapEnter', function()
			env.set_high('LeapLabelPrimary', { fg = env.color.black, bg = env.color.shell_pink })
			env.set_high('LeapLabelSecondary', { fg = env.color.black, bg = env.color.shell_yellow })
		end)
	end,
}
