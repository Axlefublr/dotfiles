Map({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
Map({ "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation(false, true)<CR>")
Map({ "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
Map({ "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation(false, false)<CR>")

Map({ "o", "x" }, "R", "<cmd>lua require('various-textobjs').restOfIndentation()<CR>")

Map({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
Map({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

Map({ "o", "x" }, "gG", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

Map({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

Map({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
Map({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

Map({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
Map({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

Map({ "o", "x" }, "gl", "<cmd>lua require('various-textobjs').url()<CR>")

Map({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').lineCharacterwise(true)<CR>")
Map({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').lineCharacterwise(false)<CR>")

Map({ "o", "x" }, "ie", "<cmd>lua require('various-textobjs').chainMember(true)<CR>")
Map({ "o", "x" }, "ae", "<cmd>lua require('various-textobjs').chainMember(false)<CR>")

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
	"iD",
	"<cmd>lua require('various-textobjs').doubleSquareBrackets(true)<CR>"
)
Map(
	{ "o", "x" },
	"aD",
	"<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<CR>"
)

Map(
	{ "o", "x" },
	"iP",
	"<cmd>lua require('various-textobjs').shellPipe(true)<CR>"
)
Map(
	{ "o", "x" },
	"aP",
	"<cmd>lua require('various-textobjs').shellPipe(false)<CR>"
)

Map({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
Map({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
Map({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
Map({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })

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

Map({ "n", "x", "o" }, "q", "<Plug>Sneak_s")
Map({ "n", "x", "o" }, "Q", "<Plug>Sneak_S")
Map("", '"', "<Plug>Sneak_;")
Map("", ":", "<Plug>Sneak_,")
