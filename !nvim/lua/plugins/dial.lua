local function remaps()
	env.map('n', '<A-d>', function() require('dial.map').manipulate('increment', 'normal') end)
	env.map('n', '<A-s>', function() require('dial.map').manipulate('decrement', 'normal') end)
	env.map('n', 'g<A-d>', function() require('dial.map').manipulate('increment', 'gnormal') end)
	env.map('n', 'g<A-s>', function() require('dial.map').manipulate('decrement', 'gnormal') end)

	env.map('v', '<A-d>', require('dial.map').inc_visual('visual'))
	env.map('v', '<A-s>', require('dial.map').dec_visual('visual'))
	env.map('x', 'g<A-d>', require('dial.map').inc_gvisual('visual'))
	env.map('x', 'g<A-s>', require('dial.map').dec_visual('visual'))

	env.map('n', '<Leader>d;', require('dial.map').inc_normal('toggles'))
	env.map('x', '<Leader>d;', require('dial.map').inc_visual('toggles'))
end

---@type LazyPluginSpec
return {
	'monaqa/dial.nvim',
	keys = {
		{
			mode = { 's', 'x', 'n' },
			'<A-d>',
		},
		{
			mode = { 's', 'x', 'n' },
			'<A-s>',
		},
		{
			mode = { 'x', 'n' },
			'g<A-d>',
		},
		{
			mode = { 'x', 'n' },
			'g<A-s>',
		},
		{
			mode = { 'x', 'n' },
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
}
