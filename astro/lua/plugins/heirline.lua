return {
	'rebelot/heirline.nvim',
	opts = function(_, opts)
		local status = require('astroui.status')

		opts.tabline[2] = {
			provider = function()
				if vim.bo.filetype == 'oil' then
					return ' ' .. vim.fn.fnamemodify(require('oil').get_current_dir(), ':~'):gsub('/$', '')
				else
					return ' ' .. vim.fn.expand('%:~:.')
				end
			end,
		} -- previously, bufferline

		table.remove(opts.tabline[4], 2)

		table.insert(opts.tabline, 5, {
			provider = function()
				local cwd = vim.fn.getcwd()
				return ' ' .. vim.fn.fnamemodify(cwd, ':~') .. ' '
			end,
		})
		table.insert(
			opts.tabline,
			2,
			status.component.file_info({
				file_icon = { padding = { left = 1, right = 0 }, condition = function() return vim.bo.filetype ~= '' end },
				file_read_only = { condition = function() return vim.bo.readonly end },
				surround = { separator = 'none' },
				filetype = false,
				file_modified = false,
			})
		)

		table.remove(opts.tabline, 1)

		opts.winbar = false

		opts.statusline[1] = {
			hl = function(_)
				local mode = vim.fn.mode()
				local modes = {
					['n'] = env.color.yellow,
					['i'] = env.color.green,
					['v'] = env.color.mint,
					['V'] = env.color.cyan,
					[''] = env.color.red,
					['c'] = env.color.purple,
					['R'] = env.color.blush,
					['s'] = env.color.mint,
					['S'] = env.color.cyan,
					[''] = env.color.red,
				}
				if modes[mode] then
					return { fg = modes[mode], bold = true }
				else
					return { fg = env.color.white, bold = true }
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
					return ' ' .. modes[mode]
				else
					return ' ' .. mode
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
					right = 0,
				},
			}),
			padding = { right = 0 },
		}
		opts.statusline[12] = status.component.nav({
			scrollbar = false,
		})

		opts.statusline[13] = {
			provider = function() return ' ' .. vim.bo.filetype .. ' ' end,
			condition = function() return vim.bo.filetype ~= '' end,
		}
		table.insert(opts.statusline, {
			provider = ' ',
			condition = function() return vim.bo.modified end,
		})

		table.remove(opts.statusline, 11)
		table.remove(opts.statusline, 9)
		table.remove(opts.statusline, 3)
		table.remove(opts.statusline, 2)

		-- table.insert(opts.statusline, 10, {
		-- 	provider = function() return (vim.g.stored_count_shared or 1) .. ' ' end,
		-- 	hl = { fg = env.color.cyan, bold = true },
		-- })

		-- table.insert(opts.statusline, 11, {
		-- 	provider = function() return (vim.g.stored_count_shared_op or 1) .. ' ' end,
		-- 	hl = { fg = env.color.yellow, bold = true },
		-- })

		opts.statuscolumn[1] = status.component.foldcolumn({
			foldcolumn = { padding = { right = 0 } },
		})
	end,
}
