---@type LazyPluginSpec
return {
	'chrisgrieser/nvim-various-textobjs',
	lazy = true,
	keys = {
		{ mode = { 'o', 'x' }, 'g;', function() require('various-textobjs').lastChange('inner') end },
		{ mode = { 'o', 'x' }, 'is', function() require('various-textobjs').subword('inner') end },
		{ mode = { 'o', 'x' }, 'as', function() require('various-textobjs').subword('outer') end },
	},
	opts = {
		lookForwardSmall = 2,
		lookForwardBig = 0,
		useDefaultKeymaps = false,
	},
}
