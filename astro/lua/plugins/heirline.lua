return {
	'rebelot/heirline.nvim',
	opts = function(_, opts)
		local status = require('astroui.status')

		opts.tabline[2] = {
			provider = ' %f',
			condition = function() return vim.bo.filetype ~= 'oil' end,
		} -- previously, bufferline

		table.remove(opts.tabline[4], 2)

		table.insert(opts.tabline, 3, opts.winbar)
		table.insert(opts.tabline, 5, {
			provider = function()
				local cwd = vim.fn.getcwd()
				return ' ' .. vim.fn.fnamemodify(cwd, ':~') .. ' '
			end,
		})

		opts.winbar = false

		opts.statusline[1] = {
			hl = function(_)
				local mode = vim.fn.mode()
				local modes = {
					['n'] = Colors.yellow,
					['i'] = Colors.green,
					['v'] = Colors.mint,
					['V'] = Colors.cyan,
					[''] = Colors.red,
					['c'] = Colors.purple,
					['R'] = Colors.blush,
				}
				if modes[mode] then
					return { fg = modes[mode], bold = true }
				else
					return { fg = Colors.white, bold = true }
				end
			end,
			provider = function()
				local mode = vim.fn.mode()
				local modes = {
					['n'] = 'normal',
					['i'] = 'insert',
					['v'] = 'visual',
					['V'] = 'linews',
					[''] = 'blocky',
					['c'] = 'comand',
					['R'] = 'replce',
				}
				if modes[mode] then
					return ' ' .. modes[mode] .. ' '
				else
					return ' ' .. mode .. ' '
				end
			end,
			update = {
				'ModeChanged',
				pattern = '*:*',
				callback = function() vim.schedule(vim.cmd.redrawstatus) end,
			},
		}
		opts.statusline[2] = {
			status.component.git_branch({
				git_branch = { icon = { kind = 'GitBranch', padding = { left = 1, right = 0 } } },
				padding = {
					right = 1,
				},
			}),
			padding = { right = 0 },
		}
		opts.statusline[3] = status.component.file_info({ file_icon = { padding = { left = 0 } } })
		opts.statusline[9] = status.component.lsp({
			lsp_client_names = {
				icon = {
					padding = { left = 1 },
				},
			},
		})
		opts.statusline[12] = status.component.nav({
			scrollbar = false,
		})

		table.remove(opts.statusline, 11)
		table.remove(opts.statusline, 12)
	end,
}
