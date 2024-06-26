local function remaps()
	vim.keymap.set(
		'n',
		'<C-a>',
		function() require('dial.map').manipulate('increment', 'normal') end
	)
	vim.keymap.set(
		'n',
		'<C-x>',
		function() require('dial.map').manipulate('decrement', 'normal') end
	)
	vim.keymap.set(
		'n',
		'g<C-a>',
		function() require('dial.map').manipulate('increment', 'gnormal') end
	)
	vim.keymap.set(
		'n',
		'g<C-x>',
		function() require('dial.map').manipulate('decrement', 'gnormal') end
	)

	vim.keymap.set('x', '<C-a>', require('dial.map').inc_visual('visual'))
	vim.keymap.set('x', '<C-x>', require('dial.map').dec_visual('visual'))
	vim.keymap.set('x', 'g<C-a>', require('dial.map').inc_gvisual('visual'))
	vim.keymap.set('x', 'g<C-x>', require('dial.map').dec_visual('visual'))

	vim.keymap.set('n', '<Leader>d;', require('dial.map').inc_normal('toggles'))
	vim.keymap.set('x', '<Leader>d;', require('dial.map').inc_visual('toggles'))
end

return {
	{
		'monaqa/dial.nvim',
		keys = {
			'<C-a>',
			'<C-x>',
			'g<C-a>',
			'g<C-x>',
			'<Leader>d;',
			{
				mode = 'x',
				'<C-a>',
			},
			{
				mode = 'x',
				'<C-x>',
			},
			{
				mode = 'x',
				'g<C-a>',
			},
			{
				mode = 'x',
				'g<C-x>',
			},
			{
				mode = 'x',
				'<Leader>d;',
			},
		},
		config = function()
			local augend = require('dial.augend')
			require('dial.config').augends:register_group({
				default = {
					augend.integer.alias.decimal_int,
					augend.hexcolor.new({
						case = 'upper',
					}),
					augend.semver.alias.semver,
					augend.date.new({
						pattern = '%y.%m.%d',
						default_kind = 'day',
						only_valid = true,
					}),
					augend.date.alias['%H:%M'],
					augend.date.new({
						pattern = '%B', -- titlecased month names
						default_kind = 'day',
					}),
					augend.constant.new({
						elements = {
							'january',
							'february',
							'march',
							'april',
							'may',
							'june',
							'july',
							'august',
							'september',
							'october',
							'november',
							'december',
						},
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = {
							'Monday',
							'Tuesday',
							'Wednesday',
							'Thursday',
							'Friday',
							'Saturday',
							'Sunday',
						},
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = {
							'monday',
							'tuesday',
							'wednesday',
							'thursday',
							'friday',
							'saturday',
							'sunday',
						},
						word = true,
						cyclic = true,
					}),
				},
				toggles = {
					augend.constant.alias.bool,
					augend.constant.new({
						elements = { 'and', 'or' },
						word = true, -- if false, 'sand' is incremented into 'sor', 'doctor' into 'doctand', etc.
						cyclic = true,
					}),
					augend.constant.new({
						elements = { 'AND', 'OR' },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { '&&', '||' },
						word = false,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { 'yes', 'no' },
						word = true,
						cyclic = true,
					}),
				},
				visual = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				},
			})
			remaps()
		end,
	},
}
