Map({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
Map({ "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation(false, true)<CR>")
Map({ "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
Map({ "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation(false, false)<CR>")

Map({ "o", "x" }, "R", "<cmd>lua require('various-textobjs').restOfIndentation()<CR>")

Map({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
Map({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

Map({ "o", "x" }, "ie", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

Map({ "o", "x" }, ".", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

Map({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
Map({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

Map({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
Map({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

Map({ "o", "x" }, "iu", "<cmd>lua require('various-textobjs').number(true)<CR>")
Map({ "o", "x" }, "au", "<cmd>lua require('various-textobjs').number(false)<CR>")

Map({ "o", "x" }, "gl", "<cmd>lua require('various-textobjs').url()<CR>")

Map({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').lineCharacterwise(true)<CR>")
Map({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').lineCharacterwise(false)<CR>")

Map(
	{ "o", "x" },
	"iC",
	"<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<CR>"
)
Map(
	{ "o", "x" },
	"aC",
	"<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>"
)

Map(
	{ "o", "x" },
	"ix",
	"<cmd>lua require('various-textobjs').htmlAttribute(true)<CR>"
)
Map(
	{ "o", "x" },
	"ax",
	"<cmd>lua require('various-textobjs').htmlAttribute(false)<CR>"
)

Map(
	{ "o", "x" },
	"i|",
	"<cmd>lua require('various-textobjs').shellPipe(true)<CR>"
)
Map(
	{ "o", "x" },
	"a|",
	"<cmd>lua require('various-textobjs').shellPipe(false)<CR>"
)

Map("n", "gx", function()
	-- select URL
	require("various-textobjs").url()

	-- plugin only switches to visual mode when textobj found
	local foundURL = vim.fn.mode():find("v")

	-- if not found, search whole buffer via urlview.nvim instead
	if not foundURL then
		Cmd.UrlView("buffer")
		return
	end

	-- retrieve URL with the z-register as intermediary
	Cmd.normal { '"zy', bang = true }
	local url = vim.fn.getreg("z")

	-- open with the OS-specific shell command
	local opener
	if vim.fn.has("macunix") == 1 then
		opener = "open"
	elseif vim.fn.has("linux") == 1 then
		opener = "xdg-open"
	elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
		opener = "start"
	end
	local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
	os.execute(openCommand)
end, { desc = "Smart URL Opener" })

Map("n", "dsi", function()
	-- select inner indentation
	require("various-textobjs").indentation(true, true)

	-- plugin only switches to visual mode when a textobj has been found
	local notOnIndentedLine = vim.fn.mode():find("V") == nil
	if notOnIndentedLine then return end

	-- dedent indentation
	Cmd.normal { "<", bang = true }

	-- delete surrounding lines
	local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
	local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
	Cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
	Cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete surrounding indentation" })

Map("", "ga", "<Plug>(EasyAlign)")
Map("n", "grr", "<Plug>ReplaceWithRegisterLine")

Map({"n", "x", "o"}, "q", function()
	require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)
Map({"x", "o"}, "x", "<Plug>(leap-forward-till)")
Map({"x", "o"}, "X", "<Plug>(leap-backward-till)")