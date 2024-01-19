Map("n", "gJ", "j0d^kgJ") -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.

Map("i", "<C-h>", '<C-o>"_S<Esc><C-o>gI<BS>') -- Delete from the current position to the last character on the previous line

Map("n", ",dl", 'dil\'_dd', { remap = true }) -- Take the contents of the line, but delete the line too

Map("n", ",di", '"_ddddpvaB<Esc>>iB') -- Push line of code after block into block

Map("", ",do", 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK) -- Move line to the top
Map("", ",db", 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK) -- Bottom

-- Paste a characterwise register on a new line
Map("n", ",p", "Pv`[o`]do<c-r><c-p>\"<esc>")
Map("n", ",P", "Pv`[o`]dO<c-r><c-p>\"<esc>")

Map("n", ",m", "?\\V$0<cr>cgn")

Map("", "_", function() FeedKeysInt(vim.v.count1 .. "k$") end)

local function multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
Map("n", "@", multiply)

local function multiply_visual() FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p") end
Map("v", "@@", multiply_visual)

local function simplify_gM() FeedKeys(vim.v.count * 10 .. "gM") end
Map("", "gm", simplify_gM)

Map("n", "J", function()
	for i = 1, vim.v.count1 do
		FeedKeys("J")
	end
end)

Map("n", ".", function()
	for i = 1, vim.v.count1 do
		FeedKeys(".")
	end
end)

local function remove_highlighting__escape()
	Remove_highlighting()
	FeedKeysInt("<Esc>")
end
Map("n", "<Esc>", remove_highlighting__escape)

local function dd_count()
	for i = 1, vim.v.count1 do
		FeedKeys("dd")
	end
end
Map("n", "du", dd_count)