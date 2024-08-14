---@type LazyPluginSpec[]
return {
	{
		---@module "edister"
		'Axlefublr/edister.nvim',
		lazy = true,
		dev = true,
		---@type EdisterOpts
		opts = { border = env.borders },
	},
	{
		'Axlefublr/harp-nvim',
		lazy = true,
		dev = true,
		opts = {},
	},
	{
		'Axlefublr/qfetter.nvim',
		lazy = true,
		dev = true,
		-- ---@module "qfetter"
		-- ---@type QfetterOpts
		-- opts = {}
	},
	{
		'Axlefublr/lupa.nvim',
		lazy = true,
		dev = true,
	},
	{
		'Axlefublr/selabel.nvim',
		dev = true,
		lazy = true,
		init = function()
			env.func_loads_plugin('selabel.nvim', vim.ui, 'select')
		end,
		---@type SelabelPluginOpts
		opts = {
			separator = ' ',
			win_opts = {
				border = env.borders,
			},
		},
	},
	{
		'Axlefublr/dress.nvim',
		dev = true,
		lazy = true,
		init = function()
			env.func_loads_plugin('dress.nvim', vim.ui, 'input')
		end,
		---@module "dress"
		---@type DressOpts
		opts = {
			win_opts = {
				border = env.borders
			}
		},
	},
	{
		'Axlefublr/wife.nvim',
		dev = true,
		lazy = true,
		---@type WifeOpts
		opts = {},
		config = function(_, opts)
			env.set_high('WifePrompt', { fg = env.color.shell_yellow, bold = true })
			require('wife').setup(opts)
		end,
	},
}
