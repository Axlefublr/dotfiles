local function fg(colorname)
	return { fg = Colors[colorname] }
end

-- local function bg(colorname)
-- 	return { bg = Colors[colorname] }
-- end

---@type LazySpec
return {
	'AstroNvim/astroui',
	---@type AstroUIOpts
	opts = {
		colorscheme = 'gruvbox-material',
		highlights = {
			init = {
				['@string'] = fg('yellow'),
				['@string.escape'] = fg('grey'),
				['@comment'] = fg('grey'),
				['@punctuation.delimiter'] = fg('white'),
				['@number'] = fg('orange'),
				['@operator'] = fg('white'),
				['@type'] = fg('cyan'),
				['@type.definition'] = fg('cyan'),
				['@boolean'] = { fg = Colors.cyan, italic = true },
				['@property'] = fg('mint'),

				['@lsp.type.property.lua'] = fg('white'),
				['@lsp.type.comment.lua'] = fg('grey'),
				['@variable.member.lua'] = fg('white'),
				['@string.regexp.lua'] = { fg = Colors.yellow, bold = true },
				['@constant.builtin.lua'] = { fg = Colors.cyan, italic = true },
				['@module.builtin.lua'] = fg('white'),

				['@constant.fish'] = fg('purple'),
				['@variable.fish'] = fg('purple'),
				['@operator.fish'] = fg('orange'),

				['@type.css'] = fg('orange'),
				['@type.qualifier.css'] = fg('red'),
				['@tag.attribute.css'] = fg('mint'),
				['@tag.css'] = fg('purple'),
				['@variable.css'] = { fg = Colors.white, italic = true },
				['@constant.css'] = fg('cyan'),
				['@attribute.css'] = fg('cyan'), -- [something="something"]
				['@number.float.css'] = fg('orange'),

				['@conceal.jsonc'] = fg('white'),
				['@conceal.json'] = fg('white'),
				['@constant.builtin.jsonc'] = { fg = Colors.cyan, italic = true },

				['@punctuation.special.bash'] = fg('purple'),
				['@variable.bash'] = fg('purple'),
				['@constant.bash'] = { fg = Colors.purple, underline = true },
				['@operator.bash'] = fg('orange'),

				['@type.toml'] = fg('red'),
				['@number.float.toml'] = fg('orange'),

				['@constant.builtin.yaml'] = { fg = Colors.cyan, italic = true },

				['@module.rasi'] = fg('purple'),
				['@attribute.rasi'] = fg('cyan'),
				['@punctuation.special.rasi'] = fg('yellow'),
				['@type.rasi'] = fg('yellow'),

				['@type.ini'] = fg('red'),

				['@variable.member.sql'] = fg('mint'),
				['@type.builtin.sql'] = { fg = Colors.cyan, italic = true },
				['@type.sql'] = { fg = Colors.cyan, bold = true },

				['confComment'] = fg('grey'),
				['confString'] = fg('yellow'),

				['CfgString'] = fg('yellow'),
				['CfgComment'] = fg('grey'),
				['CfgSection'] = fg('mint'),

				['sqlNumber'] = fg('orange'),
				['sqlString'] = fg('yellow'),
				['sqlKeyword'] = fg('red'),

				['@markup.italic.markdown_inline'] = { italic = true },
				['@markup.strikethrough.markdown_inline'] = { strikethrough = true },
				['@markup.raw.markdown_inline'] = fg('yellow'), -- inline code
				['@markup.raw.delimiter.markdown_inline'] = fg('grey'), -- `` of inline code
				['@markup.raw.delimiter.markdown'] = fg('grey'), -- ``` of codeblocks
				['@markup.quote.markdown'] = fg('cyan'),
				['@markup.list.markdown'] = fg('purple'),
				['@punctuation.special.markdown'] = fg('purple'), -- >
				['@markup.link.markdown_inline'] = fg('grey'),
				['@markup.link.url.markdown_inline'] = fg('mint'),
				['@markup.raw.block.markdown'] = fg('yellow'),

				['@type.qualifier.rust'] = { fg = Colors.orange, italic = true },
				['@character.rust'] = { fg = Colors.yellow, bold = true },
				['@variable.member.rust'] = fg('white'),
				['@module.rust'] = fg('white'),
				['@punctuation.special.rust'] = fg('white'),
				['@lsp.type.namespace.rust'] = fg('white'),
				['@lsp.type.struct.rust'] = fg('cyan'),
				['@lsp.type.enum.rust'] = fg('mint'),
				['@lsp.type.enumMember.rust'] = fg('mint'),
				['@lsp.type.property.rust'] = fg('white'),
				['@lsp.type.macro.rust'] = fg('green'),
				['@lsp.type.string.rust'] = fg('yellow'),
				['@lsp.typemod.property.private.rust'] = { fg = Colors.mint, underline = true },
				['@lsp.type.attributeBracket.rust'] = fg('purple'),
				['@lsp.type.comment.rust'] = fg('grey'),
				['@lsp.type.builtinType.rust'] = { fg = Colors.yellow, bold = true },
				['@lsp.type.interface.rust'] = fg('yellow'),
				['@lsp.type.operator.rust'] = fg('white'),
				['@lsp.type.selfTypeKeyword.rust'] = fg('purple'),
				['@lsp.type.lifetime.rust'] = { fg = Colors.orange, italic = true },
				['@lsp.mod.controlFlow.rust'] = fg('red'),
				['@lsp.mod.reference.rust'] = { italic = true },
				['@lsp.mod.mutable.rust'] = { bold = true },
				['@lsp.type.number.rust'] = fg('orange'),
			},
		},
		icons = {
			LSPLoading1 = '⠋',
			LSPLoading2 = '⠙',
			LSPLoading3 = '⠹',
			LSPLoading4 = '⠸',
			LSPLoading5 = '⠼',
			LSPLoading6 = '⠴',
			LSPLoading7 = '⠦',
			LSPLoading8 = '⠧',
			LSPLoading9 = '⠇',
			LSPLoading10 = '⠏',
		},
	},
}
