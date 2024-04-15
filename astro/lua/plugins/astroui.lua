local function fg(colorname) return { fg = Colors[colorname] } end

-- local function bg(colorname) return { bg = Colors[colorname] } end

local function link(hlgroupname) return { link = hlgroupname } end

---@type LazySpec
return {
	'AstroNvim/astroui',
	---@type AstroUIOpts
	opts = {
		colorscheme = 'gruvbox-material',
		highlights = {
			init = {
				['Orange'] = fg('orange'),
				['Yellow'] = fg('yellow'),
				['Purple'] = fg('purple'),
				['Aqua'] = fg('mint'),

				['RedBold'] = { fg = Colors.red, bold = true },
				['OrangeBold'] = { fg = Colors.orange, bold = true },
				['YellowBold'] = { fg = Colors.yellow, bold = true },
				['GreenBold'] = { fg = Colors.green, bold = true },
				['AquaBold'] = { fg = Colors.blush, bold = true },
				['BlueBold'] = { fg = Colors.cyan, bold = true },
				['PurpleBold'] = { fg = Colors.purple, bold = true },

				['RedItalic'] = { fg = Colors.red, italic = true },
				['OrangeItalic'] = { fg = Colors.orange, italic = true },
				['YellowItalic'] = { fg = Colors.yellow, italic = true },
				['GreenItalic'] = { fg = Colors.green, italic = true },
				['AquaItalic'] = { fg = Colors.blush, italic = true },
				['BlueItalic'] = { fg = Colors.cyan, italic = true },
				['PurpleItalic'] = { fg = Colors.purple, italic = true },

				['Tabline'] = link('Normal'),
				['TablineFill'] = link('Normal'),
				['BufTabLineActive'] = link('GruvboxDarkerest'),
				['StatusLine'] = link('Normal'),
				['Title'] = link('OrangeBold'),
				['Constant'] = link('Aqua'),
				['SpecialChar'] = link('Yellow'),

				['@string'] = link('Yellow'),
				['@string.escape'] = link('Grey'),
				['@comment'] = link('Grey'),
				['@punctuation.delimiter'] = link('Fg'),
				['@number'] = link('Orange'),
				['@operator'] = link('Fg'),
				['@type'] = link('Blue'),
				['@type.definition'] = link('Blue'),
				['@boolean'] = link('PurpleItalic'),
				['@property'] = link('Aqua'),
				['@function'] = link('Green'),

				['@lsp.type.property.lua'] = link('Fg'),
				['@lsp.type.comment.lua'] = link('Grey'),
				['@variable.member.lua'] = link('Fg'),
				['@string.regexp.lua'] = link('YellowBold'),
				['@constant.builtin.lua'] = link('PurpleItalic'),
				['@module.builtin.lua'] = link('Fg'),
				['@lsp.type.function.lua'] = link('Green'),
				['@function.call.lua'] = link('Green'),
				['@function.lua'] = link('Green'),
				['@lsp.type.method.lua'] = link('Green'),
				['@function.method.call.lua'] = link('Green'),
				['@function.builtin.lua'] = link('Green'),

				['@constant.fish'] = link('Purple'),
				['@variable.fish'] = link('Purple'),
				['@operator.fish'] = link('Orange'),
				['@function.call.fish'] = link('Green'),
				['@function.builtin.fish'] = link('Green'),
				['@function.fish'] = link('Green'),

				['@type.css'] = link('Orange'),
				['@type.qualifier.css'] = link('Red'),
				['@tag.attribute.css'] = link('Aqua'),
				['@tag.css'] = link('Purple'),
				['@variable.css'] = { fg = Colors.white, italic = true },
				['@constant.css'] = link('Blue'),
				['@attribute.css'] = link('Blue'), -- [something="something"]
				['@number.float.css'] = link('Orange'),

				['@conceal.jsonc'] = link('Fg'),
				['@conceal.json'] = link('Fg'),
				['@constant.builtin.jsonc'] = link('PurpleItalic'),

				['@punctuation.special.bash'] = link('Purple'),
				['@variable.bash'] = link('Purple'),
				['@constant.bash'] = { fg = Colors.purple, underline = true },
				['@operator.bash'] = link('Orange'),
				['@function.call.bash'] = link('Green'),

				['@type.toml'] = link('Red'),
				['@number.float.toml'] = link('Orange'),

				['@constant.builtin.yaml'] = link('PurpleItalic'),

				['@module.rasi'] = link('Purple'),
				['@attribute.rasi'] = link('Blue'),
				['@punctuation.special.rasi'] = link('Yellow'),
				['@type.rasi'] = link('Yellow'),

				['@type.ini'] = link('Red'),

				['@variable.member.sql'] = link('Aqua'),
				['@type.builtin.sql'] = link('PurpleItalic'),
				['@type.sql'] = link('PurpleItalic'),

				['confComment'] = link('Grey'),
				['confString'] = link('Yellow'),

				['CfgString'] = link('Yellow'),
				['CfgComment'] = link('Grey'),
				['CfgSection'] = link('Aqua'),

				['sqlNumber'] = link('Orange'),
				['sqlString'] = link('Yellow'),
				['sqlKeyword'] = link('Red'),

				['@markup.italic.markdown_inline'] = { italic = true },
				['@markup.strikethrough.markdown_inline'] = { strikethrough = true },
				['@markup.raw.markdown_inline'] = link('Yellow'), -- inline code
				['@markup.raw.delimiter.markdown_inline'] = link('Grey'), -- `` of inline code
				['@markup.raw.delimiter.markdown'] = link('Grey'), -- ``` of codeblocks
				['@markup.quote.markdown'] = link('Blue'),
				['@markup.list.markdown'] = link('Purple'),
				['@punctuation.special.markdown'] = link('Purple'), -- >
				['@markup.link.markdown_inline'] = link('Grey'),
				['@markup.link.url.markdown_inline'] = link('Blue'),
				['@markup.raw.block.markdown'] = link('Yellow'),

				['@type.qualifier.rust'] = link('OrangeItalic'),
				['@character.rust'] = link('YellowBold'),
				['@variable.member.rust'] = link('Fg'),
				['@module.rust'] = link('Fg'),
				['@punctuation.special.rust'] = link('Fg'),
				['@lsp.type.namespace.rust'] = link('Fg'),
				['@lsp.type.struct.rust'] = link('Blue'),
				['@lsp.type.enum.rust'] = link('Aqua'),
				['@lsp.type.enumMember.rust'] = link('Aqua'),
				['@lsp.type.property.rust'] = link('Fg'),
				['@lsp.type.macro.rust'] = link('Green'),
				['@lsp.type.string.rust'] = link('Yellow'),
				['@lsp.typemod.property.private.rust'] = { fg = Colors.blush, underline = true },
				['@lsp.type.attributeBracket.rust'] = link('Purple'),
				['@lsp.type.comment.rust'] = link('Grey'),
				['@lsp.type.builtinType.rust'] = link('YellowBold'),
				['@lsp.type.interface.rust'] = link('Yellow'),
				['@lsp.type.operator.rust'] = link('Fg'),
				['@lsp.type.selfTypeKeyword.rust'] = link('Purple'),
				['@lsp.type.lifetime.rust'] = link('OrangeItalic'),
				['@lsp.mod.controlFlow.rust'] = link('Red'),
				['@lsp.mod.reference.rust'] = { italic = true },
				['@lsp.mod.mutable.rust'] = { bold = true },
				['@lsp.type.number.rust'] = link('Orange'),
				['@lsp.type.function.rust'] = link('Green'),
				-- ['@function.rust'] = link('Green'),
				['@function.call.rust'] = link('Green'),
				['@function.macro.rust'] = link('Green'),
				['@lsp.type.method.rust'] = link('Green'),
				['@lsp.type.decorator.rust'] = link('Green'),
				['@type.builtin.rust'] = link('YellowBold'),

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
			Selected = '󱕅 ',
			GitBranch = '',
			-- GitAdd = '󰄬',
			-- GitChange = '',
			-- GitDelete = '󰍴',
		},
		status = {
			icon_highlights = {
				breadcrumbs = true,
			},
			separators = {
				breadcrumbs = ' > ',
				path = '/',
				left = { '', ' ' },
				right = { ' ', '' },
				center = { ' ', ' ' },
			},
			modes = {
				['n'] = {
					'N',
					'normal',
				},
				['i'] = {
					'I',
					'insert',
				},
				['v'] = {
					'V',
					'visual',
				},
				['V'] = {
					'L',
					'visual',
				},
				[''] = {
					'B',
					'visual',
				},
				['c'] = {
					'C',
					'command',
				},
			},
			colors = {
				git_branch_fg = Colors.purple,
			},
		},
	},
}
