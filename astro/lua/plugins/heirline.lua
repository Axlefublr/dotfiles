return {
	'rebelot/heirline.nvim',
	opts = function(_, opts)
		-- local status = require('astroui.status')
		opts.tabline[2] = { provider = ' %f' } -- previously, bufferline
		table.remove(opts.tabline[4], 2)
		table.insert(opts.tabline, 4, { provider = function()
			local cwd = vim.fn.getcwd()
			---@diagnostic disable-next-line: param-type-mismatch
			return cwd:gsub(os.getenv('HOME'), '~') .. ' '
		end })
	end,
}
