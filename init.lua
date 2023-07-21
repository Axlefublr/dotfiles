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
vim.opt.colorcolumn          = ""
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

-- Russian layout support

local ru_keys = {
	'й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ',
	'ф', 'ы', 'в', 'а', 'п', 'р', 'о', 'л', 'д', 'ж', 'э',
	'я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю',
	'Й', 'Ц', 'У', 'К', 'Е', 'Н', 'Г', 'Ш', 'Щ', 'З', 'Х', 'Ъ',
	'Ф', 'Ы', 'В', 'А', 'П', 'Р', 'О', 'Л', 'Д', 'Ж', 'Э',
	'Я', 'Ч', 'С', 'М', 'И', 'Т', 'Ь', 'Б', 'Ю'
}
local en_keys = {
	'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']',
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'',
	'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.',
	'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}',
	'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"',
	'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>',
}

for i = 1, #ru_keys do
	vim.api.nvim_set_keymap('n', ru_keys[i], en_keys[i], { noremap = false })
	vim.api.nvim_set_keymap('v', ru_keys[i], en_keys[i], { noremap = false })
	vim.api.nvim_set_keymap('o', ru_keys[i], en_keys[i], { noremap = false })
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
	vim.keymap.set("", "z,", center_screen)
	local function top_screen() vim.cmd("call <SNR>4_reveal('top', 0)") end
	vim.keymap.set("", "zm", top_screen)
	local function bottom_screen() vim.cmd("call <SNR>4_reveal('bottom', 0)") end
	vim.keymap.set("", "z.", bottom_screen)
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
	vim.keymap.set("", "L", move_to_bottom_screen__center_screen)

	local function move_to_top_screen__center_screen()
		move_to_top_screen()
		center_screen()
	end
	vim.keymap.set("", "H", move_to_top_screen__center_screen)

	local function trim_trailing_whitespace()
		vim.fn.VSCodeCall("editor.action.trimTrailingWhitespace")
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
		vim.fn.VSCodeCall("editor.action.formatDocument")
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

	local function go_to_implementation()
		vim.fn.VSCodeNotify("editor.action.goToImplementation")
	end
	vim.keymap.set("n", "gt", go_to_implementation)

	local function go_to_reference()
		vim.fn.VSCodeNotify("editor.action.goToReferences")
	end
	vim.keymap.set("n", "gq", go_to_reference)

	local function rename_symbol()
		vim.fn.VSCodeNotify("editor.action.rename")
	end
	vim.keymap.set("n", "<leader>r", rename_symbol)

	function Open_link() vim.fn.VSCodeNotify("editor.action.openLink") end
	vim.keymap.set("n", "gl", Open_link)
	vim.keymap.set("v", "gl", "<esc><cmd>lua Open_link()<cr>")

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

	local function indent_with_spaces()
		vim.fn.VSCodeNotify("editor.action.indentUsingSpaces")
	end
	vim.keymap.set("n", "=d", indent_with_spaces)

	local function indent_with_tabs()
		vim.fn.VSCodeNotify("editor.action.indentUsingTabs")
	end
	vim.keymap.set("n", "=g", indent_with_tabs)

	local function toggle_fold() vim.fn.VSCodeNotify("editor.toggleFold") end
	vim.keymap.set("n", "za", toggle_fold)

	local function closeEditor()
		vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
	end
	vim.keymap.set("n", "K", closeEditor)

	local function git_stage_file()
		trim_trailing_whitespace()
		save()
		vim.fn.VSCodeNotify("git.stage")
	end
	vim.keymap.set("n", "zk", git_stage_file)

	local function git_unstage_file()
		save()
		vim.fn.VSCodeNotify("git.unstage")
	end
	vim.keymap.set("n", "zK", git_unstage_file)

	local function git_revert_change()
		vim.fn.VSCodeNotifyVisual("git.revertSelectedRanges", 0)
	end
	vim.keymap.set("n", "zJ", git_revert_change)
	vim.keymap.set("v", "zJ", git_revert_change)

	local function git_stage_change()
		vim.fn.VSCodeNotifyVisual("git.stageSelectedRanges", 0)
	end
	vim.keymap.set("n", "zj", git_stage_change)
	vim.keymap.set("v", "zj", git_stage_change)

	local function git_unstage_change()
		vim.fn.VSCodeNotifyVisual("git.unstageSelectedRanges", 0)
	end

	local function git_open_changes() vim.fn.VSCodeNotify("git.openChange") end
	vim.keymap.set("n", "zi", git_open_changes)

	local function git_open_all_changes()
		vim.fn.VSCodeNotify("git.openAllChanges")
	end
	vim.keymap.set("n", "zI", git_open_all_changes)

	local function accept_merge_both()
		vim.fn.VSCodeNotify("merge-conflict.accept.both")
	end
	vim.keymap.set("n", "zo", accept_merge_both)

	local function accept_merge_all_both()
		vim.fn.VSCodeNotify("merge-conflict.accept.all-both")
	end
	vim.keymap.set("n", "zO", accept_merge_all_both)

	local function accept_merge_current()
		vim.fn.VSCodeNotify("merge-conflict.accept.current")
	end
	vim.keymap.set("n", "zu", accept_merge_current)

	local function accept_merge_all_current()
		vim.fn.VSCodeNotify("merge-conflict.accept.all-current")
	end
	vim.keymap.set("n", "zU", accept_merge_all_current)

	local function accept_merge_incoming()
		vim.fn.VSCodeNotify("merge-conflict.accept.incoming")
	end
	vim.keymap.set("n", "zp", accept_merge_incoming)

	local function accept_merge_all_incoming()
		vim.fn.VSCodeNotify("merge-conflict.accept.all-incoming")
	end
	vim.keymap.set("n", "zP", accept_merge_all_incoming)

	local function accept_merge_selection()
		vim.fn.VSCodeNotifyVisual("merge-conflict.accept.selection", 0)
	end
	vim.keymap.set("n", "zl", accept_merge_selection)
	vim.keymap.set("v", "zl", accept_merge_selection)

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

	local function add_word_user_dictionary()
		vim.fn.VSCodeNotify("cSpell.addWordToUserDictionary")
	end
	vim.keymap.set("n", "=w", add_word_user_dictionary)

else

	local function closeEditor()
		vim.cmd("x")
	end
	vim.keymap.set("n", "K", closeEditor)
	vim.keymap.set("i", "<C-]>", closeEditor)

	local function close_without_saving()
		vim.cmd("q!")
	end
	vim.keymap.set("n", "<leader>K", close_without_saving)

	local function save_vim() vim.cmd("w") end
	vim.keymap.set("", "U", save_vim)

	local move_to_bottom_screen__center_screen = 'Lzz'
	vim.keymap.set("", "L", move_to_bottom_screen__center_screen)

	local move_to_top_screen__center_screen = 'Hzz'
	vim.keymap.set("", "H", move_to_top_screen__center_screen)

	local bottom_screen = "zb"
	vim.keymap.set("", "z.", bottom_screen)

	local top_screen = "zt"
	vim.keymap.set("", "zm", top_screen)

	local center_screen = "zz"
	vim.keymap.set("", "z,", center_screen)

end

local better_half_page_down = "6jzz"
vim.keymap.set("", "<C-d>", better_half_page_down)

local better_half_page_up = "6kzz"
vim.keymap.set("", "<C-u>", better_half_page_up)

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

local better_page_down = "12jzz"
vim.keymap.set("", "<C-f>", better_page_down)

local better_page_up = "12kzz"
vim.keymap.set("", "<C-b>", better_page_up)

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

local function multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
vim.keymap.set("n", "<leader>q", multiply)

local vore_out_line_into_block = '"_ddddpvaB<Esc>'
vim.keymap.set("n", "<leader>di", vore_out_line_into_block)

local convert_to_arrow_function = 'vaBo<Esc>"_s=> <Esc>Jj"_dd'
vim.keymap.set("n", "<leader>da", convert_to_arrow_function)

local convert_to_normal_function = '^f(%f="_c3l{<cr><Esc>o}<Esc>'
vim.keymap.set("n", "<leader>dn", convert_to_normal_function)

local function add_character_at_the_end_of_line()
	local char = GetChar("Press a character:")
	if not char then return end
	FeedKeys("m" .. THROWAWAY_MARK .. "A" .. char)
	FeedKeysInt("<Esc>")
	FeedKeys("`" .. THROWAWAY_MARK)
end
vim.keymap.set("n", "<leader>;", add_character_at_the_end_of_line)

local function add_character_at_the_start_of_line()
	local char = GetChar("Press a character:")
	if not char then return end
	FeedKeys("m" .. THROWAWAY_MARK .. "I" .. char)
	FeedKeysInt("<Esc>")
	FeedKeys("`" .. THROWAWAY_MARK)
end
vim.keymap.set("n", "<leader>:", add_character_at_the_start_of_line)

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
vim.keymap.set("", "<leader>do", move_line_to_top)

local move_line_to_bottom = 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK
vim.keymap.set("", "<leader>db", move_line_to_bottom)

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
end

local execute_normal_command = "<esc>:'<,'>norm "

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
vim.keymap.set("v", "<leader>}", inclusive_next_blankie)

local inclusive_prev_blankie = "{j"
vim.keymap.set("n", "<leader>{", inclusive_prev_blankie)
vim.keymap.set("v", "<leader>{", inclusive_prev_blankie)

local function inclusive_next_blankie_visual() vim.cmd("normal V}k") end
vim.keymap.set("o", "<leader>}", inclusive_next_blankie_visual)

local function inclusive_prev_blankie_visual() vim.cmd("normal V{j") end
vim.keymap.set("o", "<leader>{", inclusive_prev_blankie_visual)

local dig_into_docs = "K"
vim.keymap.set("n", "gK", dig_into_docs)

local copy_current_character = 'yl'
vim.keymap.set("n", "X", copy_current_character)

print("nvim loaded")