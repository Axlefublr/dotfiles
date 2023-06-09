--- Options
vim.opt.number               = true
vim.opt.relativenumber       = true
vim.opt.tabstop              = 3
vim.opt.shiftwidth           = 3
vim.opt.expandtab            = false
vim.opt.smartindent          = true
vim.opt.mouse                = "a"
vim.opt.ignorecase           = true
vim.opt.smartcase            = true
vim.opt.hlsearch             = true
vim.g.mapleader              = ","
vim.g.rust_recommended_style = false
vim.opt.syntax               = "enable"
vim.opt.termguicolors        = true
vim.opt.background           = "dark"
vim.g.camelcasemotion_key    = "<leader>"
vim.g.targets_nl             = "nh"
vim.cmd("colorscheme tender")
vim.cmd("let g:sneak#use_ic_scs = 1")
vim.cmd("highlight link Sneak None")

--- Plugins: VimPlug
local Plug = vim.fn['plug#']
vim.call("plug#begin")
Plug("tpope/vim-repeat")
Plug("sheerun/vim-polyglot")
Plug("bkad/CamelCaseMotion")
Plug("junegunn/vim-easy-align")
Plug("kana/vim-textobj-user")
Plug("kana/vim-textobj-entire")
Plug("kana/vim-textobj-line")
Plug("michaeljsmith/vim-indent-object")
Plug("vim-scripts/ReplaceWithRegister")
Plug("wellle/targets.vim")
Plug('justinmk/vim-sneak')
vim.call("plug#end")

--- Plugins: Packer
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "savq/melange"
	use "sainnhe/everforest"
	use "sainnhe/edge"
	use "sainnhe/gruvbox-material"
	use "jacoborus/tender.vim"
	use "farmergreg/vim-lastplace"
	use "ap/vim-css-color"
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end
	})
end)
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

vim.g.clipboard = {
	name = "wslclipboard",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf"
	},
	cache_enabled = true
}

-- Mark fix
for c = string.byte("a"), string.byte("z") do
	local char = string.char(c)
	local upper_char = string.upper(char)
	vim.keymap.set("n", "m" .. char, "m" .. upper_char)
	vim.keymap.set("n", "`" .. char, "`" .. upper_char)
	vim.keymap.set("n", "<leader>m" .. char, "m" .. char)
end

function FeedKeys(keys)
	vim.api.nvim_feedkeys(keys, "n", false)
end

function FeedKeysInt(keys)
	local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

function Escape_V_search(input)
	input = string.gsub(input, '\\', '\\\\')
	input = string.gsub(input, '/', '\\/')
	return input
end

function GetInput(suggestion_string)
	return vim.fn.input(suggestion_string)
end

if vim.g.vscode then

	function Center_screen() vim.cmd("call <SNR>4_reveal('center', 0)") end
	function Top_screen() vim.cmd("call <SNR>4_reveal('top', 0)") end
	function Bottom_screen() vim.cmd("call <SNR>4_reveal('bottom', 0)") end
	function Move_to_top_screen() vim.cmd("call <SNR>4_moveCursor('top')") end
	function Move_to_bottom_screen() vim.cmd("call <SNR>4_moveCursor('bottom')") end

	function Move_to_bottom_screen__center_screen()
		Move_to_bottom_screen()
		Center_screen()
	end
	vim.keymap.set("", "L", Move_to_bottom_screen__center_screen)

	function Move_to_top_screen__center_screen()
		Move_to_top_screen()
		Center_screen()
	end
	vim.keymap.set("", "H", Move_to_top_screen__center_screen)

	function Trim_trailing_whitespace() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end

	function Save() vim.fn.VSCodeCall("workbench.action.files.save") end

	function Save_no_format() vim.fn.VSCodeCall("workbench.action.files.saveWithoutFormatting") end

	function Trim__Save__No_format()
		Trim_trailing_whitespace()
		Save_no_format()
	end
	vim.keymap.set("", "U", Trim__Save__No_format)

	function Reveal_definition_aside() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end
	vim.keymap.set("n", "gD", Reveal_definition_aside)

	function Rename_symbol() vim.fn.VSCodeNotify("editor.action.rename") end
	vim.keymap.set("n", "<leader>r", Rename_symbol)

	function Open_link() vim.fn.VSCodeNotify("editor.action.openLink") end
	vim.keymap.set("n", "gl", Open_link)

	function Outdent()
		---@diagnostic disable-next-line: unused-local
		for i = 1, vim.v.count1 do
			vim.fn.VSCodeNotify("editor.action.outdentLines")
		end
	end
	vim.keymap.set("n", "<<", Outdent)

	function Indent()
		---@diagnostic disable-next-line: unused-local
		for i = 1, vim.v.count1 do
			vim.fn.VSCodeNotify("editor.action.indentLines")
		end
	end
	vim.keymap.set("n", ">>", Indent)

	function Comment() vim.fn.VSCodeNotify("editor.action.commentLine") end
	vim.keymap.set("n", "gcc", Comment)

	function Reindent() vim.fn.VSCodeNotify("editor.action.reindentlines") end
	vim.keymap.set("n", "==", Reindent)

	function Convert_to_spaces() vim.fn.VSCodeNotify("editor.action.indentationToSpaces") end
	vim.keymap.set("n", "=s", Convert_to_spaces)

	function Convert_to_tabs() vim.fn.VSCodeNotify("editor.action.indentationToTabs") end
	vim.keymap.set("n", "=t", Convert_to_tabs)

	function Toggle_fold() vim.fn.VSCodeNotify("editor.toggleFold") end
	vim.keymap.set("n", "za", Toggle_fold)

	function Format_document()
		vim.fn.VSCodeNotify("editor.action.formatDocument")
		Trim_trailing_whitespace()
		print("formatted")
	end
	vim.keymap.set("n", "=ie", Format_document)

	function CloseEditor()
		vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
	end
	vim.keymap.set("n", "K", CloseEditor)

	function ReopenClosedEditor()
		vim.fn.VSCodeNotify("workbench.action.reopenClosedEditor")
	end
	vim.keymap.set("n", "<leader>K", ReopenClosedEditor)

	function Git_stage_file()
		Trim_trailing_whitespace()
		Save()
		vim.fn.VSCodeNotify("git.stage")
	end
	vim.keymap.set("n", "<leader>ga", Git_stage_file)

	function Git_stage_all()
		Trim_trailing_whitespace()
		Save()
		vim.fn.VSCodeNotify("git.stageAll")
	end
	vim.keymap.set("n", "<leader>gA", Git_stage_all)

	function Git_unstage_file()
		Save()
		vim.fn.VSCodeNotify("git.unstage")
	end
	vim.keymap.set("n", "<leader>gu", Git_unstage_file)

	function Git_revert_change() vim.fn.VSCodeNotifyVisual("git.revertSelectedRanges", 0) end
	vim.keymap.set("n", "<leader>gr", Git_revert_change)
	vim.keymap.set("v", "<leader>gr", Git_revert_change)

	function Git_stage_change() vim.fn.VSCodeNotifyVisual("git.stageSelectedRanges", 0) end
	vim.keymap.set("n", "<leader>gt", Git_stage_change)
	vim.keymap.set("v", "<leader>gt", Git_stage_change)

	function Git_open_all_changes() vim.fn.VSCodeNotifyVisual("git.openAllChanges", 0) end
	vim.keymap.set("n", "<leader>gN", Git_open_all_changes)
	vim.keymap.set("v", "<leader>gN", Git_open_all_changes)

	function Git_open_changes() vim.fn.VSCodeNotify("git.openChange") end
	vim.keymap.set("n", "<leader>gn", Git_open_changes)

	function Codesnap() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end
	vim.keymap.set("v", "gs", Codesnap)

	function Outdent_vis() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end
	vim.keymap.set("v", "<", Outdent_vis)

	function Indent_vis() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end
	vim.keymap.set("v", ">", Indent_vis)

	function Comment_vis() vim.fn.VSCodeNotifyVisual("editor.action.commentLine", false) end
	vim.keymap.set("v", "gc", Comment_vis)

else

	function CloseEditor()
		vim.cmd("x")
	end
	vim.keymap.set("n", "K", CloseEditor)

	function Save_vim() vim.cmd("w") end
	vim.keymap.set("", "U", Save_vim)

	local Move_to_bottom_screen__center_screen = 'Lzz'
	vim.keymap.set("", "L", Move_to_bottom_screen__center_screen)

	local Move_to_top_screen__center_screen = 'Hzz'
	vim.keymap.set("", "H", Move_to_top_screen__center_screen)

end

local EasyAlignMapping = "<Plug>(EasyAlign)"
vim.keymap.set("", "ga", EasyAlignMapping)

local ReplaceWithRegisterMapping = "<Plug>ReplaceWithRegisterLine"
vim.keymap.set("n", "grr", ReplaceWithRegisterMapping)

local Block_text_object_self_sameline = "aBV"
vim.keymap.set("v", "im", Block_text_object_self_sameline)

local Block_text_object_extra_sameline = "aBVj"
vim.keymap.set("v", "am", Block_text_object_extra_sameline)

local Block_text_object_self_diffline = "aBVok"
vim.keymap.set("v", "iM", Block_text_object_self_diffline)

local Block_text_object_extra_diffline = "aBVjok"
vim.keymap.set("v", "aM", Block_text_object_extra_diffline)

function Block_text_object_self_sameline_operator() vim.cmd("normal vaBV") end
vim.keymap.set("o", "im", Block_text_object_self_sameline_operator)

function Block_text_object_extra_sameline_operator() vim.cmd("normal vaBVj") end
vim.keymap.set("o", "am", Block_text_object_extra_sameline_operator)

function Block_text_object_self_diffline_operator() vim.cmd("normal vaBVok") end
vim.keymap.set("o", "iM", Block_text_object_self_diffline_operator)

function Block_text_object_extra_diffline_operator() vim.cmd("normal vaBVjok") end
vim.keymap.set("o", "aM", Block_text_object_extra_diffline_operator)

local Percent_sign_text_object_self_visual = "T%ot%"
vim.keymap.set("v", "i%", Percent_sign_text_object_self_visual)

local Percent_sign_text_object_extra_visual = "F%of%"
vim.keymap.set("v", "a%", Percent_sign_text_object_extra_visual)

function Percent_sign_text_object_self_operator() vim.cmd("normal vT%ot%") end
vim.keymap.set("o", "i%", Percent_sign_text_object_self_operator)

function Percent_sign_text_object_extra_operator() vim.cmd("normal vF%of%") end
vim.keymap.set("o", "a%", Percent_sign_text_object_extra_operator)

local Markdown_heading_text_object_self_sameline_visual = "?^#<CR>oNk"
vim.keymap.set("v", "ir", Markdown_heading_text_object_self_sameline_visual)

local Markdown_heading_text_object_self_diffline_visual = "?^#<CR>koNk"
vim.keymap.set("v", "iR", Markdown_heading_text_object_self_diffline_visual)

local Comment_text_object_self_visual = "[/3lo]/2h"
vim.keymap.set("v", "igc", Comment_text_object_self_visual)

local Comment_text_object_extra_visual = "[/o]/V"
vim.keymap.set("v", "agc", Comment_text_object_extra_visual)

function Comment_text_object_extra_operator() vim.cmd("normal v[/o]/V") end
vim.keymap.set("o", "agc", Comment_text_object_extra_operator)

function Comment_text_object_self_operator() vim.cmd("normal v[/3lo]/2h") end
vim.keymap.set("o", "igc", Comment_text_object_self_operator)

function Goto_end_of_prev_line() FeedKeysInt(vim.v.count1 .. "k$") end
vim.keymap.set("", "_", Goto_end_of_prev_line)

local Command_mode_remap = ":"
vim.keymap.set("", ";", Command_mode_remap)

local Register_access_remap = '"'
vim.keymap.set("", "'", Register_access_remap)

local Redo_seek_motion_backwards = ","
vim.keymap.set("", ":", Redo_seek_motion_backwards)

local Redo_seek_motion_forwards = ";"
vim.keymap.set("", '"', Redo_seek_motion_forwards)

local Goto_middle_of_line = "gM"
vim.keymap.set("", "gm", Goto_middle_of_line)

local Small_substitute_doesnt_consume_register = '"_s'
vim.keymap.set("", "s", Small_substitute_doesnt_consume_register)

local Big_substitute_doesnt_consume_register = '"_S'
vim.keymap.set("", "S", Big_substitute_doesnt_consume_register)

local Capital_yank_doesnt_consume_newline = "yg_"
vim.keymap.set("n", "Y", Capital_yank_doesnt_consume_newline)

local Switch_case_stays_in_place = "~h"
vim.keymap.set("n", "~", Switch_case_stays_in_place)

local Switch_lines_forward = "ddp"
vim.keymap.set("n", "dp", Switch_lines_forward)

local Switch_lines_backward = "ddkP"
vim.keymap.set("n", "dP", Switch_lines_backward)

local Copy_line_forward = "yyp"
vim.keymap.set("n", "yp", Copy_line_forward)

local Copy_line_backward = "yyP"
vim.keymap.set("n", "yP", Copy_line_backward)

local Join_lines_no_space = "j0d^kgJ"
vim.keymap.set("n", "gJ", Join_lines_no_space)

local Space_action = ""
vim.keymap.set("n", "<Space>", Space_action)

local Backspace_action = ""
vim.keymap.set("n", "<BS>", Backspace_action)

local Disable_u_visual = "<Esc>u"
vim.keymap.set("v", "u", Disable_u_visual)

function Multiply_visual() FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p") end
vim.keymap.set("v", "<leader>q", Multiply_visual)

local Complete_line = "<C-x><C-l>"
vim.keymap.set("i", "<C-l>", Complete_line)

local Delete_up_to_last_line_end = '<C-o>"_S<Esc><C-o>gI<BS>'
vim.keymap.set("i", "<C-h>", Delete_up_to_last_line_end)

local Insert_blank_line_up_insert = "<C-o>O"
vim.keymap.set("i", "<C-k>", Insert_blank_line_up_insert)

local Insert_blank_line_down_insert = "<C-o>o"
-- vim.keymap.set("i", "<C-j>", Insert_blank_line_down_insert)

local Previous_blank_line_operator = "V{"
vim.keymap.set("o", "{", Previous_blank_line_operator)

local Next_blank_line_operator = "V}"
vim.keymap.set("o", "}", Next_blank_line_operator)

local Twenty_lines_down = "20jzz"
vim.keymap.set("", "<C-f>", Twenty_lines_down)

local Twenty_lines_up = "20kzz"
vim.keymap.set("", "<C-b>", Twenty_lines_up)

local Twelve_lines_down = "12jzz"
vim.keymap.set("", "<C-d>", Twelve_lines_down)

local Twelve_lines_up = "12kzz"
vim.keymap.set("", "<C-u>", Twelve_lines_up)

local Insert_blank_line_up = "O<Esc>"
vim.keymap.set("n", "<C-k>", Insert_blank_line_up)

local Insert_blank_line_down = "o<Esc>"
vim.keymap.set("n", "<C-j>", Insert_blank_line_down)

function Remove_highlighting() vim.cmd("noh") end

function Remove_highlighting__escape()
	Remove_highlighting()
	FeedKeysInt("<Esc>")
end
vim.keymap.set("n", "<Esc>", Remove_highlighting__escape)

function Toggle_highlight_search() vim.cmd("set hlsearch!") end
-- vim.keymap.set("", "<leader>H", Toggle_highlight_search)

function Multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
vim.keymap.set("n", "<leader>q", Multiply)

local Vore_out_line_into_block = '"_ddddpvaB<Esc>'
vim.keymap.set("n", "<leader>di", Vore_out_line_into_block)

local Convert_to_arrow_function = "vaBo<Esc>s=> <Esc>Jjdd"
vim.keymap.set("n", "<leader>bi", Convert_to_arrow_function)

local Convert_to_normal_function = "^f(%f=c3l{<CR><Esc>o}<Esc>"
vim.keymap.set("n", "<leader>ba", Convert_to_normal_function)

local Add_comma_at_end_of_line = "mIA,<Esc>`I"
vim.keymap.set("n", "<leader>,", Add_comma_at_end_of_line)

local Add_semicolon_at_end_of_line = "mIA;<Esc>`I"
vim.keymap.set("n", "<leader>;", Add_semicolon_at_end_of_line)

local Add_ahk_dependency = "mIggO#Include <"
vim.keymap.set("n", "<leader>in", Add_ahk_dependency)

local System_clipboard_register = '"+'
vim.keymap.set("", "'q", System_clipboard_register)

local Yanked_register = '"0'
vim.keymap.set("", "'w", Yanked_register)

local Black_hole_register = '"_'
vim.keymap.set("", "'i", Black_hole_register)

local Command_register = '":'
vim.keymap.set("", "';", Command_register)

local Paste_system_register = "<C-r><C-p>+"
vim.keymap.set("!", "<C-v>", Paste_system_register)

local Paste_yank_register = "<C-r><C-p>0"
vim.keymap.set("!", "<C-r>w", Paste_yank_register)

local Paste_command_register = "<C-r><C-p>:"
vim.keymap.set("!", "<C-r>;", Paste_command_register)

local Paste_default_register = '<C-r><C-p>"'
vim.keymap.set("!", "<C-b>", Paste_default_register)

local Delete_line_but_take_inside_line = 'dil\'_dd'
vim.keymap.set("n", "<leader>dl", Delete_line_but_take_inside_line, { remap = true })

local Move_line_to_top = 'ddmiggP`i'
vim.keymap.set("", "<leader>mt", Move_line_to_top)

local Move_line_to_bottom = 'ddmiGp`i'
vim.keymap.set("", "<leader>mb", Move_line_to_bottom)

function Search_for_selection(searchOperator)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = Escape_V_search(vim.fn.getreg('"'))
		FeedKeys(searchOperator .. '\\V' .. escaped_selection)
		FeedKeysInt('<CR>')
	end)
end
vim.keymap.set("v", "*", "<cmd>lua Search_for_selection('/')<CR>")
vim.keymap.set("v", "#", "<cmd>lua Search_for_selection('?')<CR>")

function Regex_search(searchOperator)
	FeedKeys(searchOperator .. '\\v')
end
vim.keymap.set("", "<leader>/", "<cmd>lua Regex_search('/')<CR>")
vim.keymap.set("", "<leader>?", "<cmd>lua Regex_search('?')<CR>")

function Literal_search(searchOperator)
	local escaped_text = Escape_V_search(GetInput("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys(searchOperator .. '\\V' .. escaped_text)
	FeedKeysInt("<CR>")
end
vim.keymap.set("", "/", "<cmd>lua Literal_search('/')<CR>")
vim.keymap.set("", "?", "<cmd>lua Literal_search('?')<CR>")

function Search_for_register(register, searchOperator)
	local escaped_register = Escape_V_search(vim.fn.getreg(register))
	FeedKeys(searchOperator .. '\\V' .. escaped_register)
	FeedKeysInt('<CR>')
end
for c = string.byte("a"), string.byte("z") do
	local char = string.char(c)
	if char == 'q' then
		vim.keymap.set("n", "'q/", "<cmd>lua Search_for_register('+',  '/')<CR>")
		vim.keymap.set("n", "'q?", "<cmd>lua Search_for_register('+',  '?')<CR>")
	elseif char == 'w' then
		vim.keymap.set("n", "'w/", "<cmd>lua Search_for_register('0',  '/')<CR>")
		vim.keymap.set("n", "'w?", "<cmd>lua Search_for_register('0',  '?')<CR>")
	else
		vim.keymap.set("n", "'" .. char .. "/", "<cmd>lua Search_for_register('" .. char .. "', '/')<CR>")
		vim.keymap.set("n", "'" .. char .. "?", "<cmd>lua Search_for_register('" .. char .. "', '?')<CR>")
	end
end
vim.keymap.set("n", "''/", "<cmd>lua Search_for_register('\"', '/')<CR>")
vim.keymap.set("n", "''?", "<cmd>lua Search_for_register('\"', '?')<CR>")

local Captal_R_records_macro = 'q'
vim.keymap.set("", "R", Captal_R_records_macro)

local Sneak_s = "<Plug>Sneak_s"
vim.keymap.set("n", "q", Sneak_s)
vim.keymap.set("x", "q", Sneak_s)
vim.keymap.set("o", "q", Sneak_s)

local Sneak_S = "<Plug>Sneak_S"
vim.keymap.set("n", "Q", Sneak_S)
vim.keymap.set("x", "Q", Sneak_S)
vim.keymap.set("o", "Q", Sneak_S)

local Sneak_repeat_forward = "<Plug>Sneak_;"
vim.keymap.set("", '"', Sneak_repeat_forward)

local Sneak_repeat_backward = "<Plug>Sneak_,"
vim.keymap.set("", ":", Sneak_repeat_backward)

local Inclusive_next_blankie = "}k"
vim.keymap.set("n", "<leader>}", Inclusive_next_blankie)

local Inclusive_prev_blankie = "{j"
vim.keymap.set("n", "<leader>{", Inclusive_prev_blankie)

function Inclusive_next_blankie_visual() vim.cmd("normal V}k") end
vim.keymap.set("o", "<leader>}", Inclusive_next_blankie_visual)

function Inclusive_prev_blankie_visual() vim.cmd("normal V{j") end
vim.keymap.set("o", "<leader>{", Inclusive_prev_blankie_visual)

print("nvim loaded")