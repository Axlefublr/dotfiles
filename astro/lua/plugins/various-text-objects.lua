---@type LazySpec
return {
	{
		'chrisgrieser/nvim-various-textobjs',
		lazy = true,
		keys = {
			{ mode = { 'o', 'x' }, 'ii', function() require('various-textobjs').indentation('inner', 'inner') end },
			{ mode = { 'o', 'x' }, 'ai', function() require('various-textobjs').indentation('outer', 'inner') end },
			{ mode = { 'o', 'x' }, 'iD', function() require('various-textobjs').htmlAttribute('inner') end },
			{ mode = { 'o', 'x' }, 'aD', function() require('various-textobjs').htmlAttribute('outer') end },
			{ mode = { 'o', 'x' }, 'iI', function() require('various-textobjs').indentation('inner', 'inner') end },
			{ mode = { 'o', 'x' }, 'aI', function() require('various-textobjs').indentation('outer', 'outer') end },
			{ mode = { 'o', 'x' }, 'R', function() require('various-textobjs').restOfIndentation() end },
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
			{ '<Leader>dl' },
		},
		opts = {
			lookForwardSmall = 2,
			lookForwardBig = 0,
			useDefaultKeymaps = false,
		},
	},
}
