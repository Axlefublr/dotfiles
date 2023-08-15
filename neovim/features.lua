Map("n", "gJ", "j0d^kgJ") -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.

Map("i", "<C-h>", '<C-o>"_S<Esc><C-o>gI<BS>') -- Delete from the current position to the last character on the previous line

Map("n", "<leader>dl", 'dil\'_dd', { remap = true }) -- Take the contents of the line, but delete the line too

Map("n", "<leader>di", '"_ddddpvaB<Esc>') -- Push line of code after block into block

Map("", "<leader>do", 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK) -- Move line to the top
Map("", "<leader>db", 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK) -- Bottom

Map("n", "<BS>", "ggcG")
Map("n", "<leader><BS>", "ggdG")

Map("", "_", function() FeedKeysInt(vim.v.count1 .. "k$") end)

local function multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
Map("n", "<leader>q", multiply)

local function multiply_visual() FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p") end
Map("v", "<leader>q", multiply_visual)

Map("n", "J", function()
	for i = 1, vim.v.count1 do
		FeedKeys("J")
	end
end)

local function remove_highlighting__escape()
	Remove_highlighting()
	FeedKeysInt("<Esc>")
end
Map("n", "<Esc>", remove_highlighting__escape)