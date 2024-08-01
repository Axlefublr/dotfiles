---@type LazyPluginSpec
return {
	'chrisgrieser/nvim-various-textobjs',
	lazy = true,
	keys = {
		{ mode = { 'o', 'x' }, 'g;', [[<Cmd>lua require('various-textobjs').lastChange('inner')<CR>]] },
		{ mode = { 'o', 'x' }, 'is', [[<Cmd>lua require('various-textobjs').subword('inner')<CR>]] },
		{ mode = { 'o', 'x' }, 'as', [[<Cmd>lua require('various-textobjs').subword('outer')<CR>]] },
	},
	-- opts = {
	-- 	lookForwardSmall = 2,
	-- 	lookForwardBig = 0,
	-- 	useDefaultKeymaps = false,
	-- },
}
