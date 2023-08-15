local function goto_end_of_prev_line() FeedKeysInt(vim.v.count1 .. "k$") end
Map("", "_", goto_end_of_prev_line)

local join_lines_no_space = "j0d^kgJ"
Map("n", "gJ", join_lines_no_space)

local function multiply_visual() FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p") end
Map("v", "<leader>q", multiply_visual)

local delete_up_to_last_line_end = '<C-o>"_S<Esc><C-o>gI<BS>'
Map("i", "<C-h>", delete_up_to_last_line_end)

local function remove_highlighting__escape()
	Remove_highlighting()
	FeedKeysInt("<Esc>")
end
Map("n", "<Esc>", remove_highlighting__escape)

local function multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
Map("n", "<leader>q", multiply)

local vore_out_line_into_block = '"_ddddpvaB<Esc>'
Map("n", "<leader>di", vore_out_line_into_block)

local convert_to_arrow_function = 'vaBo<Esc>"_s=> <Esc>Jj"_dd'
Map("n", "<leader>da", convert_to_arrow_function)

local convert_to_normal_function = '^f(%f="_c3l{<cr><Esc>o}<Esc>'
Map("n", "<leader>dn", convert_to_normal_function)

local function add_character_at_the_end_of_line()
	local char = GetChar("Press a character:")
	if not char then return end
	FeedKeys("m" .. THROWAWAY_MARK .. "A" .. char)
	FeedKeysInt("<Esc>")
	FeedKeys("`" .. THROWAWAY_MARK)
end
Map("n", "<leader>;", add_character_at_the_end_of_line)

local function add_character_at_the_start_of_line()
	local char = GetChar("Press a character:")
	if not char then return end
	FeedKeys("m" .. THROWAWAY_MARK .. "I" .. char)
	FeedKeysInt("<Esc>")
	FeedKeys("`" .. THROWAWAY_MARK)
end
Map("n", "<leader>:", add_character_at_the_start_of_line)

local move_line_to_top = 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK
Map("", "<leader>do", move_line_to_top)

local move_line_to_bottom = 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK
Map("", "<leader>db", move_line_to_bottom)