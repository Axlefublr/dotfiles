local color = env.color

local function fg(colorname) return { fg = color[colorname] } end

local function bg(colorname) return { bg = color[colorname] } end

local function link(hlgroupname) return { link = hlgroupname } end

local highlights = {
	-- Colors

	['Italic'] = { italic = true },
	['Bold'] = { bold = true },
	['Strikethrough'] = { strikethrough = true },

	['Light25'] = bg('light25'),
	['Light19'] = bg('light19'),
	['Dark14'] = bg('dark14'),
	['Dark13'] = bg('dark13'),
	['Dark12'] = bg('dark12'),
	['Dark10'] = bg('dark10'),

	['Orange'] = fg('orange'),
	['Yellow'] = fg('yellow'),
	['Aqua'] = fg('mint'),
	['Purple'] = fg('purple'),
	['Blush'] = fg('blush'),
	['White'] = fg('white'),

	['RedBold'] = { fg = color.red, bold = true },
	['OrangeBold'] = { fg = color.orange, bold = true },
	['YellowBold'] = { fg = color.yellow, bold = true },
	['GreenBold'] = { fg = color.green, bold = true },
	['AquaBold'] = { fg = color.mint, bold = true },
	['BlueBold'] = { fg = color.cyan, bold = true },
	['PurpleBold'] = { fg = color.purple, bold = true },
	['BlushBold'] = { fg = color.blush, bold = true },

	['RedItalic'] = { fg = color.red, italic = true },
	['OrangeItalic'] = { fg = color.orange, italic = true },
	['YellowItalic'] = { fg = color.yellow, italic = true },
	['GreenItalic'] = { fg = color.green, italic = true },
	['AquaItalic'] = { fg = color.mint, italic = true },
	['BlueItalic'] = { fg = color.cyan, italic = true },
	['PurpleItalic'] = { fg = color.purple, italic = true },
	['BlushItalic'] = { fg = color.blush, italic = true },
	['FgItalic'] = { fg = color.white, italic = true },

	['GreenNormal'] = { fg = color.green, nocombine = true },

	['ShellYellow'] = { fg = color.shell_yellow },
	['ShellYellowBold'] = { fg = color.shell_yellow, bold = true },
	['ShellYellowBoldOnDark12'] = { fg = color.shell_yellow, bg = color.dark12, bold = true },
	['ShellYellowBoldBackground'] = { fg = color.level, bg = color.shell_yellow, bold = true },

	['ShellPink'] = { fg = color.shell_pink },
	['ShellPinkBold'] = { fg = color.shell_pink, bold = true },
	['ShellPinkBoldBackground'] = { fg = color.level, bg = color.shell_pink, bold = true },

	['ShellGrey'] = { fg = color.shell_grey },
	['ShellGreyBold'] = { fg = color.shell_grey, bold = true },

	['ShellRed'] = { fg = color.shell_red },
	['ShellRedBold'] = { fg = color.shell_red, bold = true },

	['ShellCyan'] = { fg = color.shell_cyan },
	['ShellCyanBold'] = { fg = color.shell_cyan, bold = true },

	['ShellSalad'] = { fg = color.shell_salad },
	['ShellSaladBold'] = { fg = color.shell_salad, bold = true },

	['ShellPurple'] = { fg = color.shell_purple },
	['ShellPurpleBold'] = { fg = color.shell_purple, bold = true },

	['RedBoldBackground'] = { fg = color.level, bg = color.red, bold = true },

	['OrangeBoldBackground'] = { fg = color.level, bg = color.orange, bold = true },
	['OrangeBoldNocombine'] = { fg = color.orange, bold = true, nocombine = true },
	['OrangeBoldOnDark12'] = { fg = color.orange, bg = color.dark12, bold = true },

	['GreenBoldBackground'] = { fg = color.level, bg = color.green, bold = true },

	['YellowAndUndercurl'] = { fg = color.yellow, undercurl = true },
	['YellowBackground'] = { fg = color.level, bg = color.yellow },
	['YellowBoldBackground'] = { fg = color.level, bg = color.yellow, bold = true },
	['YellowBoldOnDark12'] = { fg = color.yellow, bg = color.dark12, bold = true },
	['YellowOnDark12'] = { fg = color.yellow, bg = color.dark12 },
	['YellowOnDark13'] = { fg = color.yellow, bg = color.dark13 },
	['YellowUndercurl'] = { sp = color.yellow, undercurl = true },

	['AquaAndUnderline'] = { fg = color.mint, underline = true },
	['AquaBoldBackground'] = { fg = color.level, bg = color.mint, bold = true },
	['AquaUndercurl'] = { sp = color.mint, undercurl = true },

	['BlueBoldBackground'] = { fg = color.level, bg = color.cyan, bold = true },

	['PurpleAndUnderline'] = { fg = color.purple, underline = true },
	['PurpleBoldBackground'] = { fg = color.level, bg = color.purple, bold = true },

	['BlushBackground'] = { fg = color.level, bg = color.blush },
	['BlushBoldBackground'] = { fg = color.level, bg = color.blush, bold = true },
	['BlushOnDark13'] = { fg = color.blush, bg = color.dark13 },
	['BlushUndercurl'] = { sp = color.blush, undercurl = true },
	['BlushAndUnderline'] = { fg = color.blush, underline = true },

	-- Colors

	-- Fixes

	['MoreMsg'] = link('YellowBold'),
	['Question'] = link('Yellow'),
	['WarningMsg'] = link('YellowBold'),
	['Substitute'] = link('YellowBackground'),
	['Type'] = link('Yellow'),
	['Special'] = link('Yellow'),
	['WarningFloat'] = link('Yellow'),
	['WarningText'] = link('YellowUndercurl'),
	['YellowSign'] = link('Yellow'),
	['TSWarning'] = link('YellowBoldBackground'),
	['CmpItemKindDefault'] = link('Yellow'),
	['BufferVisibleTarget'] = link('YellowBoldOnDark12'),
	['BufferInactiveTarget'] = link('YellowBoldOnDark12'),
	['plugNumber'] = link('YellowBold'),
	['markdownH3'] = link('YellowBold'),
	['VimwikiHeader3'] = link('YellowBold'),
	['htmlH3'] = link('YellowBold'),
	['helpHyperTextEntry'] = link('YellowBold'),

	['Label'] = link('Orange'),
	['Operator'] = link('Orange'),
	['StorageClass'] = link('Orange'),
	['Structure'] = link('Orange'),
	['Tag'] = link('Orange'),
	['Debug'] = link('Orange'),
	['OrangeSign'] = link('Orange'),
	['plug1'] = link('OrangeBold'),
	['markdownH2'] = link('OrangeBold'),
	['VimwikiHeader2'] = link('OrangeBold'),
	['htmlH2'] = link('OrangeBold'),
	['helpHeader'] = link('OrangeBold'),

	['SpellRare'] = link('BlushUndercurl'),
	['QuickFixLine'] = link('BlushBold'),
	['Number'] = link('Blush'),
	['Boolean'] = link('Blush'),
	['PurpleSign'] = link('Blush'),
	['UndotreeSavedBig'] = link('BlushBold'),
	['markdownH6'] = link('BlushBold'),
	['mkdInlineURL'] = link('BlushAndUnderline'),
	['VimwikiHeader6'] = link('BlushBold'),
	['rstStandaloneHyperlink'] = link('BlushAndUnderline'),
	['htmlH6'] = link('BlushBold'),
	['tomlTable'] = link('BlushBold'),
	['helpNote'] = link('BlushBold'),

	['SpellLocal'] = link('AquaUndercurl'),
	['Macro'] = link('Aqua'),
	['AquaSign'] = link('Aqua'),
	['QuickScopePrimary'] = link('AquaAndUnderline'),

	-- Fixes

	-- Simple

	['Normal'] = link('White'),
	['NormalFloat'] = link('Dark14'),
	['NormalNC'] = link('Normal'),

	['FloatBorder'] = link('Normal'),
	['FloatTitle'] = link('Yellow'),

	-- Simple

	-- Other

	['CccFloatNormal'] = link('Dark12'),
	['Constant'] = link('Aqua'),
	['CurSearch'] = link('PurpleBoldBackground'),
	['Define'] = link('Blush'),
	['DiagnosticVirtualTextError'] = link('Red'),
	['DiagnosticVirtualTextHint'] = link('Blue'),
	['DiagnosticVirtualTextInfo'] = link('Blue'),
	['DiagnosticVirtualTextWarn'] = link('Orange'),
	['Folded'] = link('Dark14'),
	['IncSearch'] = link('PurpleBoldBackground'),
	['Include'] = link('Blush'),
	['InlayHints'] = { fg = color.grey, italic = true },
	['LspCodeLens'] = link('InlayHints'),
	['LspCodeLensSeparator'] = link('InlayHints'),
	['LspInformationVirtual'] = link('InlayHints'),
	['PMenu'] = link('Dark13'),
	['PMenuExtra'] = link('Dark13'),
	['PMenuSBar'] = link('Dark13'),
	['PMenuSel'] = link('ShellYellowBoldOnDark12'),
	['PMenuThumb'] = link('Dark13'),
	['PreCondit'] = link('Blush'),
	['PreProc'] = link('Blush'),
	['Search'] = link('AquaBoldBackground'),
	['SpecialChar'] = link('Yellow'),
	['StatusLine'] = link('Normal'),
	['Tabline'] = link('Normal'),
	['TablineFill'] = link('Normal'),
	['TablineSel'] = link('Dark10'),
	['Title'] = link('OrangeBold'),
	['ToolbarLine'] = link('Dark13'),

	-- Other

	-- Plugins

	['OilDir'] = link('Fg'),
	['OilDirIcon'] = link('ShellYellow'),
	['OilLink'] = link('Blush'),
	['OilLinkTarget'] = link('Red'),
	['OilTrash'] = link('Orange'),
	['OilRestore'] = link('Purple'),
	['OilPurge'] = link('Red'),
	['OilMove'] = link('Yellow'),

	['TelescopeResultsDiffUntracked'] = link('ShellGrey'),
	['TelescopeResultsDiffDelete'] = link('ShellRed'),
	['TelescopeResultsDiffChange'] = link('ShellCyan'),
	['TelescopeResultsDiffAdd'] = link('ShellSalad'),
	['TelescopeSelection'] = link('Dark12'),
	['TelescopeMatching'] = link('ShellYellowBold'),
	['TelescopeSelectionCaret'] = link('ShellYellowBoldOnDark12'),
	['TelescopeMultiSelection'] = link('Blue'),

	['EyelinerPrimary'] = link('ShellPinkBoldBackground'),
	['EyelinerSecondary'] = link('ShellYellowBoldBackground'),
	['LuminatePaste'] = link('RedBoldBackground'),
	['HighlightUndo'] = link('AquaBoldBackground'),
	['HighlightRedo'] = link('AquaBoldBackground'),

	['CmpItemKindSnippet'] = link('Yellow'),
	['CmpItemAbbrMatch'] = link('ShellYellowBold'),
	['CmpItemAbbrMatchFuzzy'] = link('ShellYellowBold'),
	['CmpItemKindClass'] = link('Orange'),

	-- Plugins

	-- Language

	['Float'] = link('Blush'),
	['String'] = link('Yellow'),
	['@string'] = link('Yellow'),
	['@string.escape'] = link('Grey'),
	['@comment'] = link('Grey'),
	['@punctuation.delimiter'] = link('Fg'),
	['@number'] = link('Blush'),
	['@operator'] = link('OrangeBold'),
	['@type'] = link('Blue'),
	['@type.definition'] = link('Blue'),
	['@boolean'] = link('PurpleItalic'),
	['@property'] = link('Aqua'),
	['@function'] = link('Green'),
	['@function.builtin'] = link('Green'),
	['@function.call'] = link('Green'),
	['@number.float'] = link('Blush'),
	['@function.method.call'] = link('Green'),

	-- Language lua

	['@lsp.type.class.lua'] = link('Blue'),
	['@lsp.type.string.lua'] = link('Yellow'),
	['@function.builtin.lua'] = link('Blush'),
	['@operator.lua'] = link('OrangeBold'),
	['@lsp.type.property.lua'] = link('Fg'),
	['@lsp.type.comment.lua'] = link('Grey'),
	['@variable.member.lua'] = link('Fg'),
	['@string.regexp.lua'] = link('YellowBold'),
	['@constant.builtin.lua'] = link('PurpleItalic'),
	['@module.builtin.lua'] = link('Purple'),
	['@lsp.type.function.lua'] = link('Green'),
	['@function.lua'] = link('Green'),
	['@lsp.type.method.lua'] = link('Green'),
	['@lsp.mod.defaultLibrary.lua'] = link('Purple'),
	['@lsp.typemod.function.defaultLibrary.lua'] = link('Blush'),
	['luaConstant'] = link('PurpleItalic'),
	['luaFunction'] = link('Red'),
	['@lsp.type.type.lua'] = link('YellowBold'),
	['@lsp.typemod.keyword.documentation.lua'] = link('Blush'),

	-- Language python

	['@function.builtin.python'] = link('Purple'),
	['@type.builtin.python'] = link('Blue'),
	['@function.call.python'] = link('GreenNormal'),

	-- Language nim

	['@constructor.nim'] = link('Blue'),

	-- Language html

	['@tag.html'] = link('Red'),
	['@tag.delimiter.html'] = link('Orange'),
	['@tag.attribute.html'] = link('Aqua'),
	['@markup.raw.html'] = link('Fg'),

	-- Language fish

	['@constant.fish'] = link('Purple'),
	['@variable.fish'] = link('Purple'),
	['@operator.fish'] = link('OrangeBold'),
	['@function.builtin.fish'] = link('Blush'),
	['@function.fish'] = link('Green'),

	-- Language css

	['@type.css'] = link('Orange'),
	['@type.qualifier.css'] = link('Red'),
	['@tag.attribute.css'] = link('Aqua'),
	['@tag.css'] = link('Purple'),
	['@variable.css'] = link('FgItalic'),
	['@constant.css'] = link('Blue'),
	['@attribute.css'] = link('Blue'), -- [something="something"]
	['@number.float.css'] = link('Blush'),

	-- Language json

	['@conceal.jsonc'] = link('Grey'),
	['@conceal.json'] = link('Grey'),
	['@constant.builtin.jsonc'] = link('PurpleItalic'),

	-- Language bash

	['@punctuation.special.bash'] = link('Purple'),
	['@variable.bash'] = link('Purple'),
	['@constant.bash'] = link('PurpleAndUnderline'),
	['@operator.bash'] = link('OrangeBold'),
	['@function.builtin.bash'] = link('Purple'),

	-- Language toml

	['@type.toml'] = link('Red'),
	['@number.float.toml'] = link('Blush'),
	['@operator.toml'] = link('OrangeBold'),

	-- Language yaml

	['@constant.builtin.yaml'] = link('PurpleItalic'),

	-- Language rasi

	['@module.rasi'] = link('Purple'),
	['@attribute.rasi'] = link('Blue'),
	['@punctuation.special.rasi'] = link('Yellow'),
	['@type.rasi'] = link('Yellow'),

	-- Language ini

	['@type.ini'] = link('Red'),

	-- Language sql

	['@variable.member.sql'] = link('Aqua'),
	['@type.builtin.sql'] = link('PurpleItalic'),
	['@type.sql'] = link('PurpleItalic'),

	-- Language general

	['confComment'] = link('Grey'),
	['confString'] = link('Yellow'),

	['CfgString'] = link('Yellow'),
	['CfgComment'] = link('Grey'),
	['CfgSection'] = link('Aqua'),

	['sqlNumber'] = link('Blush'),
	['sqlString'] = link('Yellow'),
	['sqlKeyword'] = link('Red'),

	['freebasicString'] = link('Yellow'),

	-- Language markdown

	['@markup.italic.markdown_inline'] = link('Italic'),
	['@markup.strikethrough.markdown_inline'] = link('Strikethrough'),
	['@markup.raw.markdown_inline'] = link('Yellow'), -- inline code
	['@markup.raw.delimiter.markdown_inline'] = link('Grey'), -- `` of inline code
	['@markup.raw.delimiter.markdown'] = link('Grey'), -- ``` of codeblocks
	['@markup.quote.markdown'] = link('Blue'),
	['@markup.list.markdown'] = link('Purple'),
	['@punctuation.special.markdown'] = link('Purple'), -- >
	['@markup.link.markdown_inline'] = link('Grey'),
	['@markup.link.url.markdown_inline'] = link('Blue'),
	['@markup.raw.block.markdown'] = link('Yellow'),
	['markdownCode'] = link('Yellow'),

	-- Language rust

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
	['@lsp.typemod.property.private.rust'] = link('BlushAndUnderline'),
	['@lsp.type.attributeBracket.rust'] = link('Purple'),
	['@lsp.type.comment.rust'] = link('Grey'),
	['@lsp.type.builtinType.rust'] = link('YellowBold'),
	['@lsp.type.interface.rust'] = link('Yellow'),
	['@lsp.type.operator.rust'] = link('OrangeBold'),
	['@lsp.type.selfTypeKeyword.rust'] = link('Purple'),
	['@lsp.type.lifetime.rust'] = link('OrangeItalic'),
	['@lsp.mod.controlFlow.rust'] = link('Red'),
	['@lsp.mod.reference.rust'] = link('Italic'),
	['@lsp.mod.mutable.rust'] = link('Bold'),
	['@lsp.type.number.rust'] = link('Blush'),
	['@lsp.type.function.rust'] = link('Green'),
	['@function.rust'] = link('Green'),
	['@function.macro.rust'] = link('Green'),
	['@lsp.type.method.rust'] = link('Green'),
	['@lsp.type.decorator.rust'] = link('Green'),
	['@type.builtin.rust'] = link('YellowBold'),
}

---@type LazySpec
return {
	'AstroNvim/astroui',
	---@type AstroUIOpts
	opts = {
		colorscheme = 'gruvbox-material',
		highlights = {
			init = highlights,
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
			-- 	GitAdd = '',
			-- 	GitChange = '',
			-- 	GitDelete = '',
		},
		status = {
			icon_highlights = {
				breadcrumbs = true,
			},
			separators = {
				breadcrumbs = ' > ',
				path = '/',
				none = { '', '' },
				left = { ' ', '' },
				right = { '', ' ' },
				center = { ' ', ' ' },
			},
			---@diagnostic disable-next-line: assign-type-mismatch
			colors = {
				git_branch_fg = env.color.purple,
				diag_ERROR = env.color.red,
				diag_WARN = env.color.yellow,
				diag_HINT = env.color.green,
				diag_INFO = env.color.cyan,
			},
		},
	},
}
