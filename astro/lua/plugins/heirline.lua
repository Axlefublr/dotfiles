return {
	'rebelot/heirline.nvim',
	opts = function(_, opts)
		local status = require('astroui.status')

		opts.tabline[2] = {
			provider = ' %f',
			condition = function() return vim.bo.filetype ~= 'oil' end,
		} -- previously, bufferline

		table.remove(opts.tabline[4], 2)

		opts.winbar[2] = status.component.breadcrumbs({
			max_depth = 2,
		})
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
					['s'] = Colors.mint,
					['S'] = Colors.cyan,
					[''] = Colors.red,
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
					['s'] = 'select',
					['S'] = 'seline',
					[''] = 'selock',
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
				git_branch = { icon = { kind = 'GitBranch', padding = { left = 0, right = 0 } } },
				padding = {
					right = 1,
				},
			}),
			padding = { right = 0 },
		}
		opts.statusline[3] = status.component.git_diff({
			-- added = { surround = { separator = 'none' }, icon = { padding = { left = 0, right = 0 } } },
			-- changed = { surround = { separator = 'none' }, icon = { padding = { left = 0, right = 0 } } },
			-- removed = { surround = { separator = 'none' }, icon = { padding = { left = 0, right = 0 } } },
			surround = { separator = {} }
		})
		opts.statusline[12] = status.component.nav({
			scrollbar = false,
		})

		opts.statusline[13] = status.component.file_info({
			surround = {
				separator = 'center',
			},
			file_icon = false,
		})

		table.remove(opts.statusline, 11)
		table.remove(opts.statusline, 9)
		table.remove(opts.statusline, 3)
	end,
}
