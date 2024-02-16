Map("", "<C-d>", "6+")
Map("", "<C-u>", "6-")
Map("", "<C-f>", "10+")
Map("", "<C-b>", "10-")
Map("", '<cr>', ":")
Map("", "'", '"')
Map("", ":", ",")
Map("", ",s", "/\\V")
Map("", ",S", "?\\V")
Map("", "/", "/\\v")
Map("", "?", "?\\v")
Map("", "zp", "]p")
Map("", "zP", "]P")
Map("", "gM", "M")
Map("", "zn", "q")
Map("", "zm", "@")
Map("", "zM", "@@")
Map("", "_", function() FeedKeysInt(vim.v.count1 .. "k$") end)
Map("", "gm", function() FeedKeys(vim.v.count * 10 .. "gM") end) -- cuts down precision of gM to 10s

Map("v", "u", "<Esc>u")
Map("v", "&", ":s`\\V")
Map("v", "@@", function() FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p") end) -- multiply selection

Map("i", "<C-l>", "<C-x><C-l>")
Map("i", "<C-k>", "<C-o>O")
-- Map("i", "<C-j>", "<C-o>o")
Map("i", "<C-h>", '<C-o>"_S<Esc><C-o>gI<BS>') -- Delete from the current position to the last character on the previous line

Map("o", "{", "V{")
Map("o", "}", "V}")
Map("o", "+", "v+")
Map("o", "-", "v-")

Map("n", "<C-k>", "O<Esc>")
Map("n", "<C-j>", "o<Esc>")
Map("n", "gK", "K")
Map("n", "Y", "yg_")
Map("n", "~", "~h")
Map("n", "dp", "ddp")
Map("n", "dP", "ddkP")
Map("n", "yp", "yyp")
Map("n", "yP", "yyP")
Map("n", "&", ":%s`\\V")
Map("n", "gy", "<cmd>%y+<cr>")
Map("n", ",g", Move_default_to_other)
Map("n", "*", function() Search_for_current_word('/', '') end)
Map("n", ",*", function() Search_for_current_word('/', '/e') end)
Map("n", "#", function() Search_for_current_word('?', '') end)
Map("n", ",#", function() Search_for_current_word('?', '?e') end)

Map("n", "gJ", "j0d^kgJ") -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
Map("n", ",dl", 'dil\'_dd', { remap = true }) -- Take the contents of the line, but delete the line too
Map("n", ",di", '"_ddddpvaB<Esc>>iB') -- Push line of code after block into block
Map("n", ",du", 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK) -- Move line to the top
Map("n", ",do", 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK) -- Bottom
Map("n", ",p", "Pv`[o`]do<c-r><c-p>\"<esc>") -- Paste a characterwise register on a new line
Map("n", ",P", "Pv`[o`]dO<c-r><c-p>\"<esc>") -- Paste a characterwise register on a new line
Map("n", ",m", "?\\V$0<cr>cgn")
Map("n", "@", function() FeedKeysInt("yl" .. vim.v.count1 .. "p") end) -- multiply character
Map("n", "<Esc>", function() Remove_highlighting() FeedKeysInt("<Esc>") end)
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
Map("n", "du", function()
	for i = 1, vim.v.count1 do
		FeedKeys("dd")
	end
end)

-- registers

Map("", "S", '"_S')
Map("", "s", '"_s')
Map("", "'qS", '"+S')
Map("", "'qs", '"+s')
Map("", "''S", 'S')
Map("", "''s", 's')
Map("", "C", '"_C')
Map("", "c", '"_c')
Map("", "'qC", '"+C')
Map("", "'qc", '"+c')
Map("", "''C", 'C')
Map("", "''c", 'c')

Map("", "M{", "`[")
Map("", "M}", "`]")
Map("", "M>", "`>")
Map("", "M<", "`<")
Map("", "M?", "`^")
Map("", "MM", "``")

Map("", "'q", '"+')
Map("", "'w", '"0')
Map("", "'i", '"_')
Map("", "';", '":')

Map("!", "<C-v>", "<C-r><C-p>+")
Map("!", "<C-r>w", "<C-r><C-p>0")
Map("!", "<C-r>;", "<C-r><C-p>:")
Map("!", "<C-b>", '<C-r><C-p>"')

-- text objects

-- Code block
Map("v", "im", "iiok", { remap = true })
Map("v", "am", "iijok", { remap = true })
Map("v", "iM", "iio2k", { remap = true })
Map("v", "aM", "iijo2k", { remap = true })
Map("o", "im", function() Cmd("normal viiok") end)
Map("o", "am", function() Cmd("normal viijok") end)
Map("o", "iM", function() Cmd("normal viio2k") end)
Map("o", "aM", function() Cmd("normal viijo2k") end)

-- Percent sign %
Map("v", "i%", "T%ot%")
Map("v", "a%", "F%of%")
Map("o", "i%", function() Cmd("normal vT%ot%") end)
Map("o", "a%", function() Cmd("normal vF%of%") end)

-- Exclusive previous / next blank line
Map({"n", "v"}, "]}", "}k")
Map({"n", "v"}, "[{", "{j")
Map("o", "]}", function() Cmd("normal V}k") end)
Map("o", "[{", function() Cmd("normal V{j") end)

-- Last operated on text
Map("v", "io", "`[o`]")

-- big

Map({'n', 'v'}, "'1", function() Numbered_get(1) end)
Map({'n', 'v'}, "'2", function() Numbered_get(2) end)
Map({'n', 'v'}, "'3", function() Numbered_get(3) end)
Map({'n', 'v'}, "'4", function() Numbered_get(4) end)
Map({'n', 'v'}, "'5", function() Numbered_get(5) end)
Map({'n', 'v'}, "'6", function() Numbered_get(6) end)
Map({'n', 'v'}, "'7", function() Numbered_get(7) end)
Map({'n', 'v'}, "'8", function() Numbered_get(8) end)
Map({'n', 'v'}, "'9", function() Numbered_get(9) end)
Map({'n', 'v'}, "'0", function() Numbered_get(10) end)

Map({'n', 'v'}, ",1", function() Numbered_set(1) end)
Map({'n', 'v'}, ",2", function() Numbered_set(2) end)
Map({'n', 'v'}, ",3", function() Numbered_set(3) end)
Map({'n', 'v'}, ",4", function() Numbered_set(4) end)
Map({'n', 'v'}, ",5", function() Numbered_set(5) end)
Map({'n', 'v'}, ",6", function() Numbered_set(6) end)
Map({'n', 'v'}, ",7", function() Numbered_set(7) end)
Map({'n', 'v'}, ",8", function() Numbered_set(8) end)
Map({'n', 'v'}, ",9", function() Numbered_set(9) end)
Map({'n', 'v'}, ",0", function() Numbered_set(10) end)

Map("", ",f", function() Search_for_register('/', '') end)
Map("", ",F", function() Search_for_register('?', '') end)
Map("", ",,f", function() Search_for_register('/', '/e') end)
Map("", ",,F", function() Search_for_register('?', '?e') end)
Map("v", "*", function() Search_for_selection('/', '') end)
Map("v", ",*", function() Search_for_selection('/', '/e') end)
Map("v", "#", function() Search_for_selection('?', '') end)
Map("v", ",#", function() Search_for_selection('?', '?e') end)

Map("n", "'R", Killring_push_tail)
Map("n", "'r", Killring_push)
Map("n", "'E", Killring_pop_tail)
Map("n", "'e", Killring_pop)
Map({"n", "v"}, ",z", Killring_kill)
Map({"n", "v"}, "'t", Killring_compile)
Map({"n", "v"}, "'T", Killring_compile_reversed)

Map("n", "zck", "ikitty: ")
Map("n", "zcx", "ixremap: ")
Map("n", "zca", "iawesome: ")
Map("n", "zcp", "ipkg: ")
Map("n", "zcf", "ifish: ")
Map("n", "zc,ax", "iawesome&xremap: ")
Map("n", "zc,sd", "istylus(discord): ")
Map("n", "zcl", "ilogin: ")
Map("n", "zcv", "ivscode: ")