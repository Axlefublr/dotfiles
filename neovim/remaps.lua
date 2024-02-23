vim.keymap.set("", "<C-d>", "6+")
vim.keymap.set("", "<C-u>", "6-")
vim.keymap.set("", "<C-f>", "10+")
vim.keymap.set("", "<C-b>", "10-")
vim.keymap.set("", '<cr>', ":")
vim.keymap.set("", "'", '"')
vim.keymap.set("", ":", ",")
vim.keymap.set("", ",s", "/\\V")
vim.keymap.set("", ",S", "?\\V")
vim.keymap.set("", "/", "/\\v")
vim.keymap.set("", "?", "?\\v")
vim.keymap.set("", "zp", "]p")
vim.keymap.set("", "zP", "]P")
vim.keymap.set("", "gM", "M")
vim.keymap.set("", "zn", "q")
vim.keymap.set("", "zm", "@")
vim.keymap.set("", "zM", "@@")
vim.keymap.set("", "_", function() FeedKeysInt(vim.v.count1 .. "k$") end)
vim.keymap.set("", "gm", function() FeedKeys(vim.v.count * 10 .. "gM") end) -- cuts down precision of gM to 10s

vim.keymap.set({'n', 'v'}, '<A-/>', '<c-^>')

vim.keymap.set("v", "u", "<Esc>u")
vim.keymap.set("v", "&", ":s`\\V")
vim.keymap.set("v", "@@", function() FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p") end) -- multiply selection

vim.keymap.set("i", "<C-l>", "<C-x><C-l>")
vim.keymap.set("i", "<C-k>", "<C-o>O")
-- vim.keymap.set("i", "<C-j>", "<C-o>o")
vim.keymap.set("i", "<C-h>", '<C-o>"_S<Esc><C-o>gI<BS>') -- Delete from the current position to the last character on the previous line

vim.keymap.set("o", "{", "V{")
vim.keymap.set("o", "}", "V}")
vim.keymap.set("o", "+", "v+")
vim.keymap.set("o", "-", "v-")

vim.keymap.set("n", "<C-k>", "O<Esc>")
vim.keymap.set("n", "<C-j>", "o<Esc>")
vim.keymap.set("n", "gK", "K")
vim.keymap.set("n", "Y", "yg_")
vim.keymap.set("n", "~", "~h")
vim.keymap.set("n", "dp", "ddp")
vim.keymap.set("n", "dP", "ddkP")
vim.keymap.set("n", "yp", "yyp")
vim.keymap.set("n", "yP", "yyP")
vim.keymap.set("n", "&", ":%s`\\V")
vim.keymap.set("n", "gy", "<cmd>%y+<cr>")
vim.keymap.set("n", ",g", Move_default_to_other)
vim.keymap.set("n", "*", function() Search_for_current_word('/', '') end)
vim.keymap.set("n", ",*", function() Search_for_current_word('/', '/e') end)
vim.keymap.set("n", "#", function() Search_for_current_word('?', '') end)
vim.keymap.set("n", ",#", function() Search_for_current_word('?', '?e') end)

vim.keymap.set("n", "gJ", "j0d^kgJ") -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
vim.keymap.set("n", ",dl", 'dil\'_dd', { remap = true }) -- Take the contents of the line, but delete the line too
vim.keymap.set("n", ",di", '"_ddddpvaB<Esc>>iB') -- Push line of code after block into block
vim.keymap.set("n", ",du", 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK) -- Move line to the top
vim.keymap.set("n", ",do", 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK) -- Bottom
vim.keymap.set("n", ",p", "Pv`[o`]do<c-r><c-p>\"<esc>") -- Paste a characterwise register on a new line
vim.keymap.set("n", ",P", "Pv`[o`]dO<c-r><c-p>\"<esc>") -- Paste a characterwise register on a new line
vim.keymap.set("n", ",m", "?\\V$0<cr>cgn")
vim.keymap.set("n", "@", function() FeedKeysInt("yl" .. vim.v.count1 .. "p") end) -- multiply character
vim.keymap.set("n", "<Esc>", function()
	Remove_highlighting()
	FeedKeysInt("<Esc>")
end)
vim.keymap.set("n", "J", function()
	for i = 1, vim.v.count1 do
		FeedKeys("J")
	end
end)
vim.keymap.set("n", ".", function()
	for i = 1, vim.v.count1 do
		FeedKeys(".")
	end
end)
vim.keymap.set("n", "du", function()
	for i = 1, vim.v.count1 do
		FeedKeys("dd")
	end
end)

-- registers

vim.keymap.set("", "S", '"_S')
vim.keymap.set("", "s", '"_s')
vim.keymap.set("", "'qS", '"+S')
vim.keymap.set("", "'qs", '"+s')
vim.keymap.set("", "''S", 'S')
vim.keymap.set("", "''s", 's')
vim.keymap.set("", "C", '"_C')
vim.keymap.set("", "c", '"_c')
vim.keymap.set("", "'qC", '"+C')
vim.keymap.set("", "'qc", '"+c')
vim.keymap.set("", "''C", 'C')
vim.keymap.set("", "''c", 'c')

vim.keymap.set("", "M{", "`[")
vim.keymap.set("", "M}", "`]")
vim.keymap.set("", "M>", "`>")
vim.keymap.set("", "M<", "`<")
vim.keymap.set("", "M?", "`^")
vim.keymap.set("", "MM", "``")

vim.keymap.set("", "'q", '"+')
vim.keymap.set("", "'w", '"0')
vim.keymap.set("", "'i", '"_')
vim.keymap.set("", "';", '":')

vim.keymap.set("!", "<C-v>", "<C-r><C-p>+")
vim.keymap.set("!", "<C-r>w", "<C-r><C-p>0")
vim.keymap.set("!", "<C-r>;", "<C-r><C-p>:")
vim.keymap.set("!", "<C-b>", '<C-r><C-p>"')

-- text objects

-- Code block
vim.keymap.set("v", "im", "iiok", { remap = true })
vim.keymap.set("v", "am", "iijok", { remap = true })
vim.keymap.set("v", "iM", "iio2k", { remap = true })
vim.keymap.set("v", "aM", "iijo2k", { remap = true })
vim.keymap.set("o", "im", function() Cmd("normal viiok") end)
vim.keymap.set("o", "am", function() Cmd("normal viijok") end)
vim.keymap.set("o", "iM", function() Cmd("normal viio2k") end)
vim.keymap.set("o", "aM", function() Cmd("normal viijo2k") end)

-- Percent sign %
vim.keymap.set("v", "i%", "T%ot%")
vim.keymap.set("v", "a%", "F%of%")
vim.keymap.set("o", "i%", function() Cmd("normal vT%ot%") end)
vim.keymap.set("o", "a%", function() Cmd("normal vF%of%") end)

-- Exclusive previous / next blank line
vim.keymap.set({"n", "v"}, "]}", "}k")
vim.keymap.set({"n", "v"}, "[{", "{j")
vim.keymap.set("o", "]}", function() Cmd("normal V}k") end)
vim.keymap.set("o", "[{", function() Cmd("normal V{j") end)

-- Last operated on text
vim.keymap.set("v", "io", "`[o`]")

-- big

vim.keymap.set({'n', 'v'}, "'1", function() Numbered_get(1) end)
vim.keymap.set({'n', 'v'}, "'2", function() Numbered_get(2) end)
vim.keymap.set({'n', 'v'}, "'3", function() Numbered_get(3) end)
vim.keymap.set({'n', 'v'}, "'4", function() Numbered_get(4) end)
vim.keymap.set({'n', 'v'}, "'5", function() Numbered_get(5) end)
vim.keymap.set({'n', 'v'}, "'6", function() Numbered_get(6) end)
vim.keymap.set({'n', 'v'}, "'7", function() Numbered_get(7) end)
vim.keymap.set({'n', 'v'}, "'8", function() Numbered_get(8) end)
vim.keymap.set({'n', 'v'}, "'9", function() Numbered_get(9) end)
vim.keymap.set({'n', 'v'}, "'0", function() Numbered_get(10) end)

vim.keymap.set({'n', 'v'}, ",1", function() Numbered_set(1) end)
vim.keymap.set({'n', 'v'}, ",2", function() Numbered_set(2) end)
vim.keymap.set({'n', 'v'}, ",3", function() Numbered_set(3) end)
vim.keymap.set({'n', 'v'}, ",4", function() Numbered_set(4) end)
vim.keymap.set({'n', 'v'}, ",5", function() Numbered_set(5) end)
vim.keymap.set({'n', 'v'}, ",6", function() Numbered_set(6) end)
vim.keymap.set({'n', 'v'}, ",7", function() Numbered_set(7) end)
vim.keymap.set({'n', 'v'}, ",8", function() Numbered_set(8) end)
vim.keymap.set({'n', 'v'}, ",9", function() Numbered_set(9) end)
vim.keymap.set({'n', 'v'}, ",0", function() Numbered_set(10) end)

vim.keymap.set("", ",f", function() Search_for_register('/', '') end)
vim.keymap.set("", ",F", function() Search_for_register('?', '') end)
vim.keymap.set("", ",,f", function() Search_for_register('/', '/e') end)
vim.keymap.set("", ",,F", function() Search_for_register('?', '?e') end)
vim.keymap.set("v", "*", function() Search_for_selection('/', '') end)
vim.keymap.set("v", ",*", function() Search_for_selection('/', '/e') end)
vim.keymap.set("v", "#", function() Search_for_selection('?', '') end)
vim.keymap.set("v", ",#", function() Search_for_selection('?', '?e') end)

vim.keymap.set("n", "'R", Killring_push_tail)
vim.keymap.set("n", "'r", Killring_push)
vim.keymap.set("n", "'E", Killring_pop_tail)
vim.keymap.set("n", "'e", Killring_pop)
vim.keymap.set({"n", "v"}, ",z", Killring_kill)
vim.keymap.set({"n", "v"}, "'t", Killring_compile)
vim.keymap.set({"n", "v"}, "'T", Killring_compile_reversed)

vim.keymap.set("n", "zck", "ikitty: ")
vim.keymap.set("n", "zcx", "ixremap: ")
vim.keymap.set("n", "zca", "iawesome: ")
vim.keymap.set("n", "zcp", "ipkg: ")
vim.keymap.set("n", "zcf", "ifish: ")
vim.keymap.set("n", "zc,ax", "iawesome&xremap: ")
vim.keymap.set("n", "zc,sd", "istylus(discord): ")
vim.keymap.set("n", "zc,sy", "istylus(youtube): ")
vim.keymap.set("n", "zcl", "ilogin: ")
vim.keymap.set("n", "zcv", "ivscode: ")
vim.keymap.set("n", "zcn", "invim: ")
