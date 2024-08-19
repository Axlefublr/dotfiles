local color = env.color

local function link(hlgroup) return { link = hlgroup } end

local highlights = {
	-- Colors

	['Orange'] = { fg = color.orange },
	['Yellow'] = { fg = color.yellow },
	['Aqua'] = { fg = color.mint },
	['Purple'] = { fg = color.purple },

	['RedBold'] = { fg = color.red, bold = true },
	['OrangeBold'] = { fg = color.orange, bold = true },
	['YellowBold'] = { fg = color.yellow, bold = true },
	['GreenBold'] = { fg = color.green, bold = true },
	['AquaBold'] = { fg = color.mint, bold = true },
	['BlueBold'] = { fg = color.cyan, bold = true },
	['PurpleBold'] = { fg = color.purple, bold = true },

	['RedItalic'] = { fg = color.red, italic = true },
	['OrangeItalic'] = { fg = color.orange, italic = true },
	['YellowItalic'] = { fg = color.yellow, italic = true },
	['GreenItalic'] = { fg = color.green, italic = true },
	['AquaItalic'] = { fg = color.mint, italic = true },
	['BlueItalic'] = { fg = color.cyan, italic = true },
	['PurpleItalic'] = { fg = color.purple, italic = true },

	-- Colors

	-- Fixes

	['MoreMsg'] = link('YellowBold'),
	['Question'] = link('Yellow'),
	['WarningMsg'] = link('YellowBold'),
	['Substitute'] = { fg = color.level, bg = color.yellow },
	['Type'] = link('Yellow'),
	['Special'] = link('Yellow'),
	['WarningFloat'] = link('Yellow'),
	['WarningText'] = { sp = color.yellow, undercurl = true },
	['YellowSign'] = link('Yellow'),
	['TSWarning'] = { fg = color.level, bg = color.yellow, bold = true },
	['CmpItemKindDefault'] = link('Yellow'),
	['BufferVisibleTarget'] = { fg = color.yellow, bg = color.dark12, bold = true },
	['BufferInactiveTarget'] = { fg = color.yellow, bg = color.dark12, bold = true },
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

	['SpellRare'] = { sp = color.blush, undercurl = true },
	['QuickFixLine'] = { fg = color.blush, bold = true },
	['Number'] = { fg = color.blush },
	['Boolean'] = { fg = color.blush },
	['PurpleSign'] = { fg = color.blush },
	['UndotreeSavedBig'] = { fg = color.blush, bold = true },
	['markdownH6'] = { fg = color.blush, bold = true },
	['mkdInlineURL'] = { fg = color.blush, underline = true },
	['VimwikiHeader6'] = { fg = color.blush, bold = true },
	['rstStandaloneHyperlink'] = { fg = color.blush, underline = true },
	['htmlH6'] = { fg = color.blush, bold = true },
	['tomlTable'] = { fg = color.blush, bold = true },
	['helpNote'] = { fg = color.blush, bold = true },

	['SpellLocal'] = { sp = color.mint, undercurl = true },
	['Macro'] = link('Aqua'),
	['AquaSign'] = link('Aqua'),
	['QuickScopePrimary'] = { fg = color.mint, underline = true },

	-- Fixes

	-- Simple

	['Normal'] = { fg = color.white },
	['NormalFloat'] = { bg = color.dark14 },
	['NormalNC'] = link('Normal'),

	['Cursor'] = { fg = color.dark12, bg = color.orange },
	['Visual'] = { bg = color.orange_supporting },
	['VisualNOS'] = { bg = color.orange_supporting },

	['FloatBorder'] = { bg = color.dark14 },
	['FloatTitle'] = { bg = color.dark14, fg = color.orange, bold = true },

	-- ['FoldColumn'] = { bg = color.dark12 },
	['Folded'] = { bg = color.dark14 },

	['SpecialKey'] = { fg = color.feeble },

	['DiagnosticVirtualTextError'] = link('Red'),
	['DiagnosticVirtualTextWarn'] = link('Orange'),
	['DiagnosticVirtualTextInfo'] = link('Blue'),
	['DiagnosticVirtualTextHint'] = link('Blue'),
	-- ['DiagnosticError'] = link('Red'),
	['DiagnosticWarn'] = link('Yellow'),
	-- ['DiagnosticInfo'] = link('Blue'),
	-- ['DiagnosticHint'] = link('Green'),
	['DiagnosticSignError'] = link('RedBold'),
	['DiagnosticSignWarn'] = link('YellowBold'),
	['DiagnosticSignInfo'] = link('BlueBold'),
	['DiagnosticSignHint'] = link('GreenBold'),

	-- Simple

	-- Other

	['CccFloatNormal'] = { bg = color.dark12 },
	['Constant'] = link('Aqua'),
	['CurSearch'] = { fg = color.level, bg = color.purple, bold = true },
	['Define'] = { fg = color.blush },
	['IncSearch'] = { fg = color.level, bg = color.purple, bold = true },
	['Include'] = { fg = color.blush },
	['InlayHints'] = { fg = color.grey, italic = true },
	['LspCodeLens'] = link('InlayHints'),
	['LspCodeLensSeparator'] = link('InlayHints'),
	['LspInformationVirtual'] = link('InlayHints'),
	['PMenu'] = { bg = color.dark13 },
	['PMenuExtra'] = { bg = color.dark13 },
	['PMenuSBar'] = { bg = color.dark13 },
	['PMenuSel'] = { fg = color.shell_yellow, bg = color.dark12, bold = true },
	['PMenuThumb'] = { bg = color.dark13 },
	['PreCondit'] = { fg = color.blush },
	['PreProc'] = { fg = color.blush },
	['Search'] = { fg = color.level, bg = color.mint, bold = true },
	['SpecialChar'] = link('Yellow'),
	['StatusLine'] = link('Normal'),
	['Tabline'] = link('Normal'),
	['TablineFill'] = link('Normal'),
	['TablineSel'] = { bg = color.dark10 },
	['Title'] = link('OrangeBold'),
	['ToolbarLine'] = { bg = color.dark13 },

	-- Other

	-- Language

	['Float'] = { fg = color.blush },
	['String'] = link('Yellow'),
	['@string'] = link('Yellow'),
	['@string.escape'] = link('Grey'),
	['@comment'] = link('Grey'),
	['@punctuation.delimiter'] = link('Fg'),
	['@number'] = { fg = color.blush },
	['@operator'] = link('OrangeBold'),
	['@type'] = link('Blue'),
	['@type.definition'] = link('Blue'),
	['@boolean'] = link('PurpleItalic'),
	['@property'] = link('Aqua'),
	['@function'] = link('Green'),
	['@function.builtin'] = link('Green'),
	['@function.call'] = link('Green'),
	['@number.float'] = { fg = color.blush },
	['@function.method.call'] = link('Green'),

	-- Language lua

	['@variable.parameter.builtin.lua'] = { fg = color.red },
	['@lsp.type.macro.lua'] = { fg = color.red, bold = true },
	['@property.lua'] = link('Normal'),
	['@lsp.type.class.lua'] = link('Blue'),
	['@lsp.type.string.lua'] = link('Yellow'),
	['@function.builtin.lua'] = { fg = color.blush },
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
	['@lsp.typemod.function.defaultLibrary.lua'] = { fg = color.blush },
	['luaConstant'] = link('PurpleItalic'),
	['luaFunction'] = link('Red'),
	['@lsp.type.type.lua'] = link('YellowBold'),
	['@lsp.typemod.keyword.documentation.lua'] = { fg = color.blush },

	-- Language python

	['@function.builtin.python'] = link('Purple'),
	['@type.builtin.python'] = link('Blue'),
	['@function.call.python'] = { fg = color.green, nocombine = true },

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
	['@function.builtin.fish'] = { fg = color.blush },
	['@function.fish'] = link('Green'),

	-- Language css

	['@type.css'] = link('Orange'),
	['@type.qualifier.css'] = link('Red'),
	['@tag.attribute.css'] = link('Aqua'),
	['@tag.css'] = link('Purple'),
	['@variable.css'] = { fg = color.white, italic = true },
	['@constant.css'] = link('Blue'),
	['@attribute.css'] = link('Blue'), -- [something="something"]
	['@number.float.css'] = { fg = color.blush },

	-- Language json

	['@conceal.jsonc'] = link('Grey'),
	['@conceal.json'] = link('Grey'),
	['@constant.builtin.jsonc'] = link('PurpleItalic'),

	-- Language bash

	['@punctuation.special.bash'] = link('Purple'),
	['@variable.bash'] = link('Purple'),
	['@constant.bash'] = { fg = color.purple, underline = true },
	['@operator.bash'] = link('OrangeBold'),
	['@function.builtin.bash'] = link('Purple'),

	-- Language toml

	['@type.toml'] = link('Red'),
	['@number.float.toml'] = { fg = color.blush },
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

	['sqlNumber'] = { fg = color.blush },
	['sqlString'] = link('Yellow'),
	['sqlKeyword'] = link('Red'),

	['freebasicString'] = link('Yellow'),

	-- Language markdown

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
	['@lsp.typemod.property.private.rust'] = { fg = color.blush, underline = true },
	['@lsp.type.attributeBracket.rust'] = link('Purple'),
	['@lsp.type.comment.rust'] = link('Grey'),
	['@lsp.type.builtinType.rust'] = link('YellowBold'),
	['@lsp.type.interface.rust'] = link('Yellow'),
	['@lsp.type.operator.rust'] = link('OrangeBold'),
	['@lsp.type.selfTypeKeyword.rust'] = link('Purple'),
	['@lsp.type.lifetime.rust'] = link('OrangeItalic'),
	['@lsp.mod.controlFlow.rust'] = link('Red'),
	['@lsp.mod.reference.rust'] = { italic = true },
	['@lsp.mod.mutable.rust'] = { bold = true },
	['@lsp.type.number.rust'] = { fg = color.blush },
	['@lsp.type.function.rust'] = link('Green'),
	['@function.rust'] = link('Green'),
	['@function.macro.rust'] = link('Green'),
	['@lsp.type.method.rust'] = link('Green'),
	['@lsp.type.decorator.rust'] = link('Green'),
	['@type.builtin.rust'] = link('YellowBold'),
}

for key, value in pairs(highlights) do
	env.set_high(key, value)
end
