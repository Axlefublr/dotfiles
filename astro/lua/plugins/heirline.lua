return {
	'rebelot/heirline.nvim',
	opts = function(_, opts)
		local status = require('astroui.status')
		opts.tabline[2] = { provider = ' %f' }
	end,
}
