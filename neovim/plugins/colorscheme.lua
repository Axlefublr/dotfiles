local function recolorize(what)
	for highlight, color in pairs(what) do
		local color_table
		if type(color) == 'string' then
			color_table = { fg = Colors[color] }
		else
			color_table = color
		end
		vim.api.nvim_set_hl(0, highlight, color_table)
	end
end

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
	['@constant.builtin.lua'] = { fg = Colors.cyan, italic = true },
	['@module.builtin.lua'] = 'white',

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
	['@constant.builtin.jsonc'] = { fg = Colors.cyan, italic = true },

	['@punctuation.special.bash'] = 'purple',
	['@variable.bash'] = 'purple',
	['@constant.bash'] = { fg = Colors.purple, underline = true },
	['@operator.bash'] = 'orange',

	['@type.toml'] = 'red',
	['@number.float.toml'] = 'orange',

	['@constant.builtin.yaml'] = { fg = Colors.cyan, italic = true },

	['@module.rasi'] = 'purple',
	['@attribute.rasi'] = 'cyan',
	['@punctuation.special.rasi'] = 'yellow',
	['@type.rasi'] = 'yellow',

	['@type.ini'] = 'red',

	['@variable.member.sql'] = 'mint',
	['@type.builtin.sql'] = { fg = Colors.cyan, italic = true },
	['@type.sql'] = { fg = Colors.cyan, bold = true },

	['confComment'] = 'grey',
	['confString'] = 'yellow',

	['CfgString'] = 'yellow',
	['CfgComment'] = 'grey',
	['CfgSection'] = 'mint',

	['sqlNumber'] = 'orange',
	['sqlString'] = 'yellow',
	['sqlKeyword'] = 'red',
}

local markdown_recolors = {
	['@markup.italic.markdown_inline'] = { italic = true },
	['@markup.strikethrough.markdown_inline'] = { strikethrough = true },
	['@markup.raw.markdown_inline'] = 'yellow', -- inline code
	['@markup.raw.delimiter.markdown_inline'] = 'grey', -- `` of inline code
	['@markup.raw.delimiter.markdown'] = 'grey', -- ``` of codeblocks
	['@markup.quote.markdown'] = 'cyan',
	['@markup.list.markdown'] = 'purple',
	['@punctuation.special.markdown'] = 'purple', -- >
	['@markup.link.markdown_inline'] = 'grey',
	['@markup.link.url.markdown_inline'] = 'mint',
	['@markup.raw.block.markdown'] = 'yellow',
}

local rust_recolors = {
	['@type.qualifier.rust'] = { fg = Colors.orange, italic = true },
	['@character.rust'] = { fg = Colors.yellow, bold = true },
	['@variable.member.rust'] = 'white',
	['@module.rust'] = 'white',
	['@punctuation.special.rust'] = 'white',
	['@lsp.type.namespace.rust'] = 'white',
	['@lsp.type.struct.rust'] = 'cyan',
	['@lsp.type.enum.rust'] = 'mint',
	['@lsp.type.enumMember.rust'] = 'mint',
	['@lsp.type.property.rust'] = 'white',
	['@lsp.type.macro.rust'] = 'green',
	['@lsp.type.string.rust'] = 'yellow',
	['@lsp.typemod.property.private.rust'] = { fg = Colors.mint, underline = true },
	['@lsp.type.attributeBracket.rust'] = 'purple',
	['@lsp.type.comment.rust'] = 'grey',
	['@lsp.type.builtinType.rust'] = { fg = Colors.yellow, bold = true },
	['@lsp.type.interface.rust'] = 'yellow',
	['@lsp.type.operator.rust'] = 'white',
	['@lsp.type.selfTypeKeyword.rust'] = 'purple',
	['@lsp.type.lifetime.rust'] = { fg = Colors.orange, italic = true },
	['@lsp.mod.controlFlow.rust'] = 'red',
	['@lsp.mod.reference.rust'] = { italic = true },
	['@lsp.mod.mutable.rust'] = { bold = true },
	['@lsp.type.number.rust'] = 'orange',
}

return {
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme('gruvbox-material')
			recolorize(recolors)

			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'rust',
				callback = function() recolorize(rust_recolors) end,
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'markdown',
				callback = function() recolorize(markdown_recolors) end,
			})
		end,
	},
}
