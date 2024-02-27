return {
	{
		'chrisgrieser/nvim-various-textobjs',
		config = function()
			require('various-textobjs').setup({
				-- lines to seek forwards for 'small' textobjs (mostly characterwise textobjs)
				-- set to 0 to only look in the current line
				lookForwardSmall = 2,
				-- lines to seek forwards for 'big' textobjs (mostly linewise textobjs)
				lookForwardBig = 0,
				-- use suggested keymaps (see overview table in README)
				useDefaultKeymaps = false,
			})
			vim.keymap.set(
				{ 'o', 'x' },
				'ii',
				'<cmd>lua require("various-textobjs").indentation(true, true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'ai',
				'<cmd>lua require("various-textobjs").indentation(false, true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'iI',
				'<cmd>lua require("various-textobjs").indentation(true, true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'aI',
				'<cmd>lua require("various-textobjs").indentation(false, false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'R',
				'<cmd>lua require("various-textobjs").restOfIndentation()<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'iS',
				'<cmd>lua require("various-textobjs").subword(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'aS',
				'<cmd>lua require("various-textobjs").subword(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'ie',
				'<cmd>lua require("various-textobjs").entireBuffer()<CR>'
			)

			vim.keymap.set({ 'o', 'x' }, '.', '<cmd>lua require("various-textobjs").nearEoL()<CR>')

			vim.keymap.set(
				{ 'o', 'x' },
				'iv',
				'<cmd>lua require("various-textobjs").value(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'av',
				'<cmd>lua require("various-textobjs").value(false)<CR>'
			)

			vim.keymap.set({ 'o', 'x' }, 'ik', '<cmd>lua require("various-textobjs").key(true)<CR>')
			vim.keymap.set(
				{ 'o', 'x' },
				'ak',
				'<cmd>lua require("various-textobjs").key(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'iu',
				'<cmd>lua require("various-textobjs").number(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'au',
				'<cmd>lua require("various-textobjs").number(false)<CR>'
			)

			vim.keymap.set({ 'o', 'x' }, 'gl', '<cmd>lua require("various-textobjs").url()<CR>')

			vim.keymap.set(
				{ 'o', 'x' },
				'il',
				'<cmd>lua require("various-textobjs").lineCharacterwise(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'al',
				'<cmd>lua require("various-textobjs").lineCharacterwise(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'iC',
				'<cmd>lua require("various-textobjs").mdFencedCodeBlock(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'aC',
				'<cmd>lua require("various-textobjs").mdFencedCodeBlock(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'ix',
				'<cmd>lua require("various-textobjs").htmlAttribute(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'ax',
				'<cmd>lua require("various-textobjs").htmlAttribute(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'i|',
				'<cmd>lua require("various-textobjs").shellPipe(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'a|',
				'<cmd>lua require("various-textobjs").shellPipe(false)<CR>'
			)

			vim.keymap.set('n', 'gx', function()
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
				vim.cmd.normal({ '"zy', bang = true })
				local url = vim.fn.getreg('z')

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
			end, { desc = 'Smart URL Opener' })

			vim.keymap.set('n', 'dsi', function()
				-- select inner indentation
				require('various-textobjs').indentation(true, true)

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
			end, { desc = 'Delete surrounding indentation' })

			vim.keymap.set('n', ',dl', "dil'_dd", { remap = true }) -- Take the contents of the line, but delete the line too

			-- Code block
			vim.keymap.set('v', 'im', 'iiok', { remap = true })
			vim.keymap.set('v', 'am', 'iijok', { remap = true })
			vim.keymap.set('v', 'iM', 'iio2k', { remap = true })
			vim.keymap.set('v', 'aM', 'iijo2k', { remap = true })
			vim.keymap.set('o', 'im', function() vim.cmd('normal viiok') end)
			vim.keymap.set('o', 'am', function() vim.cmd('normal viijok') end)
			vim.keymap.set('o', 'iM', function() vim.cmd('normal viio2k') end)
			vim.keymap.set('o', 'aM', function() vim.cmd('normal viijo2k') end)

		end,
	},
}
