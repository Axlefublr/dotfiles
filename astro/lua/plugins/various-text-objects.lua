---@type LazySpec
return {
	{
		'chrisgrieser/nvim-various-textobjs',
		keys = {
			{ mode = { 'o', 'x' }, 'ii', function() require('various-textobjs').indentation('inner', 'inner') end },
			{ mode = { 'o', 'x' }, 'ai', function() require('various-textobjs').indentation('outer', 'inner') end },
			{ mode = { 'o', 'x' }, 'iD', function() require('various-textobjs').htmlAttribute('inner') end },
			{ mode = { 'o', 'x' }, 'aD', function() require('various-textobjs').htmlAttribute('outer') end },
			{ mode = { 'o', 'x' }, 'iI', function() require('various-textobjs').indentation('inner', 'inner') end },
			{ mode = { 'o', 'x' }, 'aI', function() require('various-textobjs').indentation('outer', 'outer') end },
			{ mode = { 'o', 'x' }, 'D', function() require('various-textobjs').restOfIndentation() end },
			{ mode = { 'o', 'x' }, 'is', function() require('various-textobjs').subword('inner') end },
			{ mode = { 'o', 'x' }, 'as', function() require('various-textobjs').subword('outer') end },
			{ mode = { 'o', 'x' }, 'ie', function() require('various-textobjs').entireBuffer() end },
			{ mode = { 'o', 'x' }, '.', function() require('various-textobjs').nearEoL() end },
			{ mode = { 'o', 'x' }, 'iv', function() require('various-textobjs').value('inner') end },
			{ mode = { 'o', 'x' }, 'av', function() require('various-textobjs').value('outer') end },
			{ mode = { 'o', 'x' }, 'ik', function() require('various-textobjs').key('inner') end },
			{ mode = { 'o', 'x' }, 'ak', function() require('various-textobjs').key('outer') end },
			{ mode = { 'o', 'x' }, 'iu', function() require('various-textobjs').number('inner') end },
			{ mode = { 'o', 'x' }, 'au', function() require('various-textobjs').number('outer') end },
			{ mode = { 'o', 'x' }, 'gl', function() require('various-textobjs').url() end },
			{ mode = { 'o', 'x' }, 'il', function() require('various-textobjs').lineCharacterwise('inner') end },
			{ mode = { 'o', 'x' }, 'al', function() require('various-textobjs').lineCharacterwise('outer') end },
			{ mode = { 'o', 'x' }, 'iC', function() require('various-textobjs').mdFencedCodeBlock('inner') end },
			{ mode = { 'o', 'x' }, 'aC', function() require('various-textobjs').mdFencedCodeBlock('outer') end },
			{ mode = { 'o', 'x' }, 'i|', function() require('various-textobjs').shellPipe('inner') end },
			{ mode = { 'o', 'x' }, 'a|', function() require('various-textobjs').shellPipe('outer') end },
			{ mode = { 'x' }, 'im', 'viiok', { remap = true } },
			{ mode = { 'x' }, 'am', 'viijok', { remap = true } },
			{ mode = { 'x' }, 'iM', 'viio2k', { remap = true } },
			{ mode = { 'x' }, 'aM', 'viijo2k', { remap = true } },
			{ mode = { 'o' }, 'im', function() vim.cmd('normal viiok') end },
			{ mode = { 'o' }, 'am', function() vim.cmd('normal viijok') end },
			{ mode = { 'o' }, 'iM', function() vim.cmd('normal viio2k') end },
			{ mode = { 'o' }, 'aM', function() vim.cmd('normal viijo2k') end },
			{
				'gx',
				function()
					-- select URL
					require('various-textobjs').url()

					-- plugin only switches to visual mode when textobj found
					local foundURL = vim.fn.mode():find('v')

					-- if not found, search whole buffer via urlview.nvim instead
					if not foundURL then
						vim.cmd.UrlView('buffer')
						return
					end

					-- retrieve URL with the z-register as intermediary
					vim.cmd.normal({ '"' .. THROWAWAY_REGISTER .. 'y', bang = true })
					local url = vim.fn.getreg(THROWAWAY_REGISTER)

					-- open with the OS-specific shell command
					local opener
					if vim.fn.has('macunix') == 1 then
						opener = 'open'
					elseif vim.fn.has('linux') == 1 then
						opener = 'xdg-open'
					elseif vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
						opener = 'start'
					end
					local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
					os.execute(openCommand)
				end,
			},
			{
				'dsi',
				function()
					-- select inner indentation
					require('various-textobjs').indentation('inner', 'inner')

					-- plugin only switches to visual mode when a textobj has been found
					local notOnIndentedLine = vim.fn.mode():find('V') == nil
					if notOnIndentedLine then return end

					-- dedent indentation
					vim.cmd.normal({ '<', bang = true })

					-- delete surrounding lines
					local endBorderLn = vim.api.nvim_buf_get_mark(0, '>')[1] + 1
					local startBorderLn = vim.api.nvim_buf_get_mark(0, '<')[1] - 1
					vim.cmd(tostring(endBorderLn) .. ' delete') -- delete end first so line index is not shifted
					vim.cmd(tostring(startBorderLn) .. ' delete')
				end,
			},
			{ '<Leader>dl', "dil'_dd", { remap = true } },
		},
		opts = {
			lookForwardSmall = 2,
			lookForwardBig = 0,
			useDefaultKeymaps = false,
		},
	},
}
