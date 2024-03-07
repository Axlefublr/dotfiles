local highlight_modifications = function()

	local recolors = {
		['@string'] = 'yellow',
		['@comment'] = 'grey',
		['@punctuation.delimiter'] = 'white',

		['@operator.lua'] = 'white',
		['@number.lua'] = 'orange',
		['@boolean.lua'] = { fg = Colors.cyan, italic = true },
		['@lsp.type.property.lua'] = 'white',
		['@lsp.type.comment.lua'] = 'grey',
		['@variable.member.lua'] = 'white',
		['@string.regexp.lua'] = { fg = Colors.yellow, bold = true },

		['@comment.yaml'] = 'grey',
		['@property.yaml'] = 'mint',
		['@boolean.yaml'] = { fg = Colors.cyan, italic = true },

		['@number.fish'] = 'orange',
		['@boolean.fish'] = { fg = Colors.cyan, italic = true },
		['@constant.fish'] = 'purple',
		['@variable.fish'] = 'purple',

		['@type.css'] = 'orange',
		['@number.css'] = 'orange',
		['@property.css'] = 'mint',
		['@operator.css'] = 'white',
		['@type.qualifier.css'] = 'red',
		['@tag.attribute.css'] = 'mint',
		['@tag.css'] = 'purple',
		['@variable.css'] = { fg = Colors.white, italic = true },
		['@constant.css'] = 'cyan',
		['@attribute.css'] = 'cyan', -- [something="something"]
		['@number.float.css'] = 'orange',

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
		config = function()
			vim.cmd.colorscheme('gruvbox-material')
			highlight_modifications()
		end,
	},
}
