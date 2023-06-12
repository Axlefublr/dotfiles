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
vim.opt.colorcolumn          = "50,72,80"
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

-- Own constants

local THROWAWAY_REGISTER = 'o'
local THROWAWAY_MARK = 'I'

-- Own functions

function FeedKeys(keys)
	vim.api.nvim_feedkeys(keys, "n", false)
end

function FeedKeysInt(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, "n", true)
end

function EscapeForLiteralSearch(input)
	input = string.gsub(input, '\\', '\\\\')
	input = string.gsub(input, '/', '\\/')
	return input
end

function EscapeFromLiteralSearch(input)
	if string.sub(input, 1, 2) ~= "\\V" then return input end
	input = string.sub(input, 3)
	input = string.gsub(input, '\\/', '/')
	input = string.gsub(input, '\\\\', '\\')
	return input
end

function EscapeFromRegexSearch(input)
	if string.sub(input, 1, 2) ~= '\\v' then return input end
	return string.sub(input, 3)
end

function GetChar(prompt)
	vim.api.nvim_echo({ { prompt , "Input" } }, true, {})
	local char = vim.fn.getcharstr()
	-- That's the escape character (<Esc>). Not sure how to specify it smarter
	-- In other words, if you pressed escape, we return nil
	if char == '' then
		char = nil
	end
	return char
end
vim.keymap.set("n", "<leader>a", GetChar)

function Validate_register(register)
	if register == 'q' then
		return '+'
	elseif register == 'w' then
		return '0'
	elseif register == "'" then
		return '"'
	else
		return register
	end
end

function GetBool(message)
	local char = GetChar(message .. " (f/d):")
	local bool
	if char == 'f' then
		bool = true
	elseif char == 'd' then
		bool = false
	else
		print("Press f for true, d for false")
		return nil
	end
	return bool
end

if vim.g.vscode then

	local function center_screen() vim.cmd("call <SNR>4_reveal('center', 0)") end
	local function top_screen() vim.cmd("call <SNR>4_reveal('top', 0)") end
	local function bottom_screen() vim.cmd("call <SNR>4_reveal('bottom', 0)") end
	local function move_to_top_screen()
		vim.cmd("call <SNR>4_moveCursor('top')")
	end
	local function move_to_bottom_screen()
		vim.cmd("call <SNR>4_moveCursor('bottom')")
	end

	local function move_to_bottom_screen__center_screen()
		move_to_bottom_screen()
		center_screen()
	end
	vim.keymap.set("", "!", move_to_bottom_screen__center_screen)

	local function move_to_top_screen__center_screen()
		move_to_top_screen()
		center_screen()
	end
	vim.keymap.set("", "H", move_to_top_screen__center_screen)

	local function trim_trailing_whitespace()
		vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace")
	end

	local function save() vim.fn.VSCodeCall("workbench.action.files.save") end

	local function save_no_format()
		vim.fn.VSCodeCall("workbench.action.files.saveWithoutFormatting")
	end

	local function trim__save__no_format()
		trim_trailing_whitespace()
		save_no_format()
	end

	local function trim__save()
		trim_trailing_whitespace()
		save()
	end
	vim.keymap.set("", "U", trim__save)

	local function format()
		vim.fn.VSCodeNotify("editor.action.formatDocument")
		print("formatted!")
	end

	local function trim__save__format()
		trim_trailing_whitespace()
		format()
		save()
	end
	vim.keymap.set("", "<leader>U", trim__save__format)

	local function reveal_definition_aside()
		vim.fn.VSCodeNotify("editor.action.revealDefinitionAside")
	end
	vim.keymap.set("n", "gD", reveal_definition_aside)

	local function rename_symbol()
		vim.fn.VSCodeNotify("editor.action.rename")
	end
	vim.keymap.set("n", "<leader>r", rename_symbol)

	local function open_link() vim.fn.VSCodeNotify("editor.action.openLink") end
	vim.keymap.set("n", "gl", open_link)

	local function outdent()
		---@diagnostic disable-next-line: unused-local
		for i = 1, vim.v.count1 do
			vim.fn.VSCodeNotify("editor.action.outdentLines")
		end
	end
	vim.keymap.set("n", "<<", outdent)

	local function indent()
		---@diagnostic disable-next-line: unused-local
		for i = 1, vim.v.count1 do
			vim.fn.VSCodeNotify("editor.action.indentLines")
		end
	end
	vim.keymap.set("n", ">>", indent)

	local function comment() vim.fn.VSCodeNotify("editor.action.commentLine") end
	vim.keymap.set("n", "gcc", comment)

	local function reindent()
		vim.fn.VSCodeNotify("editor.action.reindentlines")
	end
	vim.keymap.set("n", "==", reindent)

	local function convert_to_spaces() vim.fn.VSCodeNotify("editor.action.indentationToSpaces") end
	vim.keymap.set("n", "=s", convert_to_spaces)

	local function convert_to_tabs()
		vim.fn.VSCodeNotify("editor.action.indentationToTabs")
	end
	vim.keymap.set("n", "=t", convert_to_tabs)

	local function toggle_fold() vim.fn.VSCodeNotify("editor.toggleFold") end
	vim.keymap.set("n", "za", toggle_fold)

	local function format_document()
		vim.fn.VSCodeNotify("editor.action.formatDocument")
		trim_trailing_whitespace()
		print("formatted")
	end
	vim.keymap.set("n", "=ie", format_document)

	local function closeEditor()
		vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
	end
	vim.keymap.set("n", "K", closeEditor)

	local function git_stage_file()
		trim_trailing_whitespace()
		save()
		vim.fn.VSCodeNotify("git.stage")
	end
	vim.keymap.set("n", "<leader>ga", git_stage_file)

	local function git_stage_all()
		trim_trailing_whitespace()
		save()
		vim.fn.VSCodeNotify("git.stageAll")
	end
	vim.keymap.set("n", "<leader>gA", git_stage_all)

	local function git_unstage_file()
		save()
		vim.fn.VSCodeNotify("git.unstage")
	end
	vim.keymap.set("n", "<leader>gu", git_unstage_file)

	local function git_revert_change()
		vim.fn.VSCodeNotifyVisual("git.revertSelectedRanges", 0)
	end
	vim.keymap.set("n", "<leader>gr", git_revert_change)
	vim.keymap.set("v", "<leader>gr", git_revert_change)

	local function git_stage_change()
		vim.fn.VSCodeNotifyVisual("git.stageSelectedRanges", 0)
	end
	vim.keymap.set("n", "<leader>gt", git_stage_change)
	vim.keymap.set("v", "<leader>gt", git_stage_change)

	local function git_open_all_changes()
		vim.fn.VSCodeNotifyVisual("git.openAllChanges", 0)
	end
	vim.keymap.set("n", "<leader>gN", git_open_all_changes)
	vim.keymap.set("v", "<leader>gN", git_open_all_changes)

	local function git_open_changes() vim.fn.VSCodeNotify("git.openChange") end
	vim.keymap.set("n", "<leader>gn", git_open_changes)

	local function codesnap()
		vim.fn.VSCodeNotifyVisual("codesnap.start", true)
	end
	vim.keymap.set("v", "gs", codesnap)

	local function outdent_vis()
		vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false)
	end
	vim.keymap.set("v", "<", outdent_vis)

	local function indent_vis()
		vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false)
	end
	vim.keymap.set("v", ">", indent_vis)

	local function comment_vis()
		vim.fn.VSCodeNotifyVisual("editor.action.commentLine", false)
	end
	vim.keymap.set("v", "gc", comment_vis)

else

	local function closeEditor()
		vim.cmd("x")
	end
	vim.keymap.set("n", "K", closeEditor)

	local function close_without_saving()
		vim.cmd("q!")
	end
	vim.keymap.set("n", "<leader>K", close_without_saving)

	local function save_vim() vim.cmd("w") end
	vim.keymap.set("", "U", save_vim)

	local move_to_bottom_screen__center_screen = 'Lzz'
	vim.keymap.set("", "!", move_to_bottom_screen__center_screen)

	local move_to_top_screen__center_screen = 'Hzz'
	vim.keymap.set("", "H", move_to_top_screen__center_screen)

end

local easyAlignMapping = "<Plug>(EasyAlign)"
vim.keymap.set("", "ga", easyAlignMapping)

local replaceWithRegisterMapping = "<Plug>ReplaceWithRegisterLine"
vim.keymap.set("n", "grr", replaceWithRegisterMapping)

local block_text_object_self_sameline = "aBV"
vim.keymap.set("v", "im", block_text_object_self_sameline)

local block_text_object_extra_sameline = "aBVj"
vim.keymap.set("v", "am", block_text_object_extra_sameline)

local block_text_object_self_diffline = "aBVok"
vim.keymap.set("v", "iM", block_text_object_self_diffline)

local block_text_object_extra_diffline = "aBVjok"
vim.keymap.set("v", "aM", block_text_object_extra_diffline)

local function block_text_object_self_sameline_operator()
	vim.cmd("normal vaBV")
end
vim.keymap.set("o", "im", block_text_object_self_sameline_operator)

local function block_text_object_extra_sameline_operator()
	vim.cmd("normal vaBVj")
end
vim.keymap.set("o", "am", block_text_object_extra_sameline_operator)

local function block_text_object_self_diffline_operator()
	vim.cmd("normal vaBVok")
end
vim.keymap.set("o", "iM", block_text_object_self_diffline_operator)

local function block_text_object_extra_diffline_operator()
	vim.cmd("normal vaBVjok")
end
vim.keymap.set("o", "aM", block_text_object_extra_diffline_operator)

local percent_sign_text_object_self_visual = "T%ot%"
vim.keymap.set("v", "i%", percent_sign_text_object_self_visual)

local percent_sign_text_object_extra_visual = "F%of%"
vim.keymap.set("v", "a%", percent_sign_text_object_extra_visual)

local function percent_sign_text_object_self_operator()
	vim.cmd("normal vT%ot%")
end
vim.keymap.set("o", "i%", percent_sign_text_object_self_operator)

local function percent_sign_text_object_extra_operator()
	vim.cmd("normal vF%of%")
end
vim.keymap.set("o", "a%", percent_sign_text_object_extra_operator)

local markdown_heading_text_object_self_sameline_visual = "?^#<cr>oNk"
vim.keymap.set("v", "ir", markdown_heading_text_object_self_sameline_visual)

local markdown_heading_text_object_self_diffline_visual = "?^#<cr>koNk"
vim.keymap.set("v", "iR", markdown_heading_text_object_self_diffline_visual)

local comment_text_object_self_visual = "[/3lo]/2h"
vim.keymap.set("v", "igc", comment_text_object_self_visual)

local comment_text_object_extra_visual = "[/o]/V"
vim.keymap.set("v", "agc", comment_text_object_extra_visual)

local function comment_text_object_extra_operator()
	vim.cmd("normal v[/o]/V")
end
vim.keymap.set("o", "agc", comment_text_object_extra_operator)

local function comment_text_object_self_operator()
	vim.cmd("normal v[/3lo]/2h")
end
vim.keymap.set("o", "igc", comment_text_object_self_operator)

local function goto_end_of_prev_line() FeedKeysInt(vim.v.count1 .. "k$") end
vim.keymap.set("", "_", goto_end_of_prev_line)

local command_mode_remap = ":"
vim.keymap.set("", ";", command_mode_remap)

local register_access_remap = '"'
vim.keymap.set("", "'", register_access_remap)

local redo_seek_motion_backwards = ","
vim.keymap.set("", ":", redo_seek_motion_backwards)

local redo_seek_motion_forwards = ";"
vim.keymap.set("", '"', redo_seek_motion_forwards)

local goto_middle_of_line = "gM"
vim.keymap.set("", "gm", goto_middle_of_line)

local small_substitute_doesnt_consume_register = '"_s'
vim.keymap.set("", "s", small_substitute_doesnt_consume_register)

local big_substitute_doesnt_consume_register = '"_S'
vim.keymap.set("", "S", big_substitute_doesnt_consume_register)

local capital_yank_doesnt_consume_newline = "yg_"
vim.keymap.set("n", "Y", capital_yank_doesnt_consume_newline)

local switch_case_stays_in_place = "~h"
vim.keymap.set("n", "~", switch_case_stays_in_place)

local switch_lines_forward = "ddp"
vim.keymap.set("n", "dp", switch_lines_forward)

local switch_lines_backward = "ddkP"
vim.keymap.set("n", "dP", switch_lines_backward)

local copy_line_forward = "yyp"
vim.keymap.set("n", "yp", copy_line_forward)

local copy_line_backward = "yyP"
vim.keymap.set("n", "yP", copy_line_backward)

local join_lines_no_space = "j0d^kgJ"
vim.keymap.set("n", "gJ", join_lines_no_space)

local space_action = ""
vim.keymap.set("n", "<Space>", space_action)

local backspace_action = ""
vim.keymap.set("n", "<BS>", backspace_action)

local disable_u_visual = "<Esc>u"
vim.keymap.set("v", "u", disable_u_visual)

local function multiply_visual()
	FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p")
end
vim.keymap.set("v", "<leader>q", multiply_visual)

local complete_line = "<C-x><C-l>"
vim.keymap.set("i", "<C-l>", complete_line)

local delete_up_to_last_line_end = '<C-o>"_S<Esc><C-o>gI<BS>'
vim.keymap.set("i", "<C-h>", delete_up_to_last_line_end)

local insert_blank_line_up_insert = "<C-o>O"
vim.keymap.set("i", "<C-k>", insert_blank_line_up_insert)

local insert_blank_line_down_insert = "<C-o>o"
-- vim.keymap.set("i", "<C-j>", insert_blank_line_down_insert)

local previous_blank_line_operator = "V{"
vim.keymap.set("o", "{", previous_blank_line_operator)

local next_blank_line_operator = "V}"
vim.keymap.set("o", "}", next_blank_line_operator)

local twenty_lines_down = "20jzz"
vim.keymap.set("", "<C-f>", twenty_lines_down)

local twenty_lines_up = "20kzz"
vim.keymap.set("", "<C-b>", twenty_lines_up)

local twelve_lines_down = "12jzz"
vim.keymap.set("", "<C-d>", twelve_lines_down)

local twelve_lines_up = "12kzz"
vim.keymap.set("", "<C-u>", twelve_lines_up)

local insert_blank_line_up = "O<Esc>"
vim.keymap.set("n", "<C-k>", insert_blank_line_up)

local insert_blank_line_down = "o<Esc>"
vim.keymap.set("n", "<C-j>", insert_blank_line_down)

local function remove_highlighting() vim.cmd("noh") end

local function remove_highlighting__escape()
	remove_highlighting()
	FeedKeysInt("<Esc>")
end
vim.keymap.set("n", "<Esc>", remove_highlighting__escape)

local function toggle_highlight_search() vim.cmd("set hlsearch!") end
-- vim.keymap.set("", "<leader>H", toggle_highlight_search)

local function multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
vim.keymap.set("n", "<leader>q", multiply)

local vore_out_line_into_block = '"_ddddpvaB<Esc>'
vim.keymap.set("n", "<leader>di", vore_out_line_into_block)

local convert_to_arrow_function = 'vaBo<Esc>"_s=> <Esc>Jj"_dd'
vim.keymap.set("n", "<leader>bi", convert_to_arrow_function)

local convert_to_normal_function = '^f(%f="_c3l{<cr><Esc>o}<Esc>'
vim.keymap.set("n", "<leader>ba", convert_to_normal_function)

local add_comma_at_end_of_line = "m" .. THROWAWAY_MARK .. "A,<Esc>`" .. THROWAWAY_MARK
vim.keymap.set("n", "<leader>,", add_comma_at_end_of_line)

local add_semicolon_at_end_of_line = "m" .. THROWAWAY_MARK .. "A;<Esc>`" .. THROWAWAY_MARK
vim.keymap.set("n", "<leader>;", add_semicolon_at_end_of_line)

local add_ahk_dependency = "m" .. THROWAWAY_MARK .. "#Include <"
vim.keymap.set("n", "<leader>in", add_ahk_dependency)

local system_clipboard_register = '"+'
vim.keymap.set("", "'q", system_clipboard_register)

local yanked_register = '"0'
vim.keymap.set("", "'w", yanked_register)

local black_hole_register = '"_'
vim.keymap.set("", "'i", black_hole_register)

local command_register = '":'
vim.keymap.set("", "';", command_register)

local paste_system_register = "<C-r><C-p>+"
vim.keymap.set("!", "<C-v>", paste_system_register)

local paste_yank_register = "<C-r><C-p>0"
vim.keymap.set("!", "<C-r>w", paste_yank_register)

local paste_command_register = "<C-r><C-p>:"
vim.keymap.set("!", "<C-r>;", paste_command_register)

local paste_default_register = '<C-r><C-p>"'
vim.keymap.set("!", "<C-b>", paste_default_register)

local delete_line_but_take_inside_line = 'dil\'_dd'
vim.keymap.set("n", "<leader>dl", delete_line_but_take_inside_line, { remap = true })

local move_line_to_top = 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK
vim.keymap.set("", "<leader>mt", move_line_to_top)

local move_line_to_bottom = 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK
vim.keymap.set("", "<leader>mb", move_line_to_bottom)

function Search_for_selection(search_operator)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(search_operator .. '\\V' .. escaped_selection)
		FeedKeysInt('<cr>')
	end)
end
vim.keymap.set("v", "*", "<cmd>lua Search_for_selection('/')<cr>")
vim.keymap.set("v", "#", "<cmd>lua Search_for_selection('?')<cr>")

function Regex_search(searchOperator)
	FeedKeys(searchOperator .. '\\v')
end
vim.keymap.set("", "<leader>/", "<cmd>lua Regex_search('/')<cr>")
vim.keymap.set("", "<leader>?", "<cmd>lua Regex_search('?')<cr>")

function Literal_search(searchOperator)
	local escaped_text = EscapeForLiteralSearch(vim.fn.input("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys(searchOperator .. '\\V' .. escaped_text)
	FeedKeysInt("<cr>")
end
vim.keymap.set("", "/", "<cmd>lua Literal_search('/')<cr>")
vim.keymap.set("", "?", "<cmd>lua Literal_search('?')<cr>")

function Search_for_register(search_operator)
	local char = GetChar("Input register key to search for:")
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(search_operator .. '\\V' .. escaped_register)
	FeedKeysInt('<cr>')
end
vim.keymap.set("", "<leader>f", "<cmd>lua Search_for_register('/')<cr>")
vim.keymap.set("", "<leader>F", "<cmd>lua Search_for_register('?')<cr>")

function Search_for_current_word(direction)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = vim.fn.getreg('"')
		FeedKeys(direction .. '\\v<' .. escaped_word .. ">")
		FeedKeysInt('<cr>')
	end)
end
vim.keymap.set("n", "*", "<cmd>lua Search_for_current_word('/')<cr>")
vim.keymap.set("n", "#", "<cmd>lua Search_for_current_word('/')<cr>")

function Better_replace(range)

	local what
	what = vim.fn.input("Enter what:")
	if what == '' then print("You didn't specify 'what'") return end

	local magic = ''
	if string.sub(what, 1, 2) ~= '\\v' then
		what = EscapeForLiteralSearch(what)
		magic = "\\V"
	end

	local with
	with = vim.fn.input("Enter with:")

	vim.cmd(range .. "s/" .. magic .. what .. "/" .. with .. "/g")
end
-- Both are inputs, non regex, current line
vim.keymap.set("n", "<leader>s", "<cmd>lua Better_replace('.')<cr>")
-- Both are inputs, non regex, whole file
vim.keymap.set("n", "<leader>S", "<cmd>lua Better_replace('%')<cr>")
-- Both are inputs, non regex, visual
vim.keymap.set("v", "<leader>s", "<esc><cmd>lua Better_replace(\"'<,'>\")<cr>")

function Better_global()

	local global_command = GetBool("Those that match?")
	if global_command == nil then return end

	local global_command_str
	if global_command then
		global_command_str = 'g'
	else
		global_command_str = 'v'
	end

	local pattern
	pattern = vim.fn.input("Enter the pattern:")
	if pattern == '' then print("You didn't specify the pattern") return end

	local magic = ''
	if string.sub(pattern, 1, 2) ~= '\\v' then
		pattern = EscapeForLiteralSearch(pattern)
		magic = "\\V"
	end

	local command = vim.fn.input("Enter command:")
	if command == '' then print("You didn't enter a command") return end

	vim.cmd(global_command_str .. '/' .. magic .. pattern .. '/' .. command)
end -- Better
vim.keymap.set("n", "<leader>v", Better_global)

local execute_normal_command = "<esc>:'<,'>norm "
vim.keymap.set("v", "<leader>v", execute_normal_command)

local repeat_replace_goes_next = "n&"
vim.keymap.set("n", "&", repeat_replace_goes_next)

local captal_R_records_macro = 'q'
vim.keymap.set("", "R", captal_R_records_macro)

local sneak_s = "<Plug>Sneak_s"
vim.keymap.set("n", "q", sneak_s)
vim.keymap.set("x", "q", sneak_s)
vim.keymap.set("o", "q", sneak_s)

local sneak_S = "<Plug>Sneak_S"
vim.keymap.set("n", "Q", sneak_S)
vim.keymap.set("x", "Q", sneak_S)
vim.keymap.set("o", "Q", sneak_S)

local sneak_repeat_forward = "<Plug>Sneak_;"
vim.keymap.set("", '"', sneak_repeat_forward)

local sneak_repeat_backward = "<Plug>Sneak_,"
vim.keymap.set("", ":", sneak_repeat_backward)

local inclusive_next_blankie = "}k"
vim.keymap.set("n", "<leader>}", inclusive_next_blankie)

local inclusive_prev_blankie = "{j"
vim.keymap.set("n", "<leader>{", inclusive_prev_blankie)

local function inclusive_next_blankie_visual() vim.cmd("normal V}k") end
vim.keymap.set("o", "<leader>}", inclusive_next_blankie_visual)

local function inclusive_prev_blankie_visual() vim.cmd("normal V{j") end
vim.keymap.set("o", "<leader>{", inclusive_prev_blankie_visual)

local dig_into_docs = "K"
vim.keymap.set("n", "gK", dig_into_docs)

print("nvim loaded")