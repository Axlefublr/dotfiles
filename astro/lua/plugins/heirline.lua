return {
	'rebelot/heirline.nvim',
	opts = function(_, opts)
		local status = require('astroui.status')
		opts.tabline[2] = {
			provider = function()
				if vim.bo.filetype ~= 'oil' then
 	 				return ' %f'
				end
			end
		} -- previously, bufferline
		table.remove(opts.tabline[4], 2)
		table.insert(opts.tabline, 4, { provider = function()
			local cwd = vim.fn.getcwd()
			---@diagnostic disable-next-line: param-type-mismatch
			return cwd:gsub(os.getenv('HOME'), '~') .. ' '
		end })

		opts.statusline[1] = status.component.mode({ mode_text = { padding = { left = 1, right = 1 } } })
		table.remove(opts.statusline, 13)
	end,
}
