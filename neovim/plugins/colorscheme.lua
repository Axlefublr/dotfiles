local highlight_modifications = function()

	local recolors = {
		['@string'] = 'yellow',
		['@string.escape'] = 'grey',
		['@comment'] = 'grey',
		['@punctuation.delimiter'] = 'white',
		['@number'] = 'orange',
		['@operator'] = 'white',
		['@type'] = 'cyan',
		['@type.definition'] = 'cyan',
		['@boolean'] = { fg = Colors.cyan, italic = true },
		['@property'] = 'mint',

		['@lsp.type.property.lua'] = 'white',
		['@lsp.type.comment.lua'] = 'grey',
		['@variable.member.lua'] = 'white',
		['@string.regexp.lua'] = { fg = Colors.yellow, bold = true },

		['@constant.fish'] = 'purple',
		['@variable.fish'] = 'purple',
		['@operator.fish'] = 'orange',

		['@type.css'] = 'orange',
		['@type.qualifier.css'] = 'red',
		['@tag.attribute.css'] = 'mint',
		['@tag.css'] = 'purple',
		['@variable.css'] = { fg = Colors.white, italic = true },
		['@constant.css'] = 'cyan',
		['@attribute.css'] = 'cyan', -- [something="something"]
		['@number.float.css'] = 'orange',

		['@conceal.jsonc'] = 'white',
		['@conceal.json'] = 'white',

		['@markup.italic.markdown_inline'] = { italic = true },
		['@markup.strikethrough.markdown_inline'] = { strikethrough = true },
		['@markup.raw.markdown_inline'] = 'yellow', -- inline code
		['@markup.raw.delimiter.markdown_inline'] = 'grey', -- `` of inline code
		['@markup.raw.delimiter.markdown'] = 'grey', -- ``` of codeblocks

		['@punctuation.special.bash'] = 'purple',
		['@variable.bash'] = 'purple',
		['@constant.bash'] = { fg = 'purple', underline = false },
		['@operator.bash'] = 'orange',

		['@type.toml'] = 'red',

		['@module.rasi'] = 'purple',
		['@attribute.rasi'] = 'cyan',
		['@punctuation.special.rasi'] = 'yellow',
		['@type.rasi'] = 'yellow',

		['confComment'] = 'grey',
		['confString'] = 'yellow',
	}

	for highlight, color in pairs(recolors) do
		local color_table
		if type(color) == 'string' then
			color_table = { fg = Colors[color] }
		else
			color_table = color
		end
		vim.api.nvim_set_hl(0, highlight, color_table)
	end

end

return {
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme('gruvbox-material')
			highlight_modifications()
			vim.api.nvim_create_autocmd('ColorScheme', {
				callback = highlight_modifications
			})
		end,
	},
}
