function Search_for_selection(search_operator)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(search_operator .. '\\V' .. escaped_selection)
		FeedKeysInt('<cr>')
	end)
end
Map("v", "*", "<cmd>lua Search_for_selection('/')<cr>")
Map("v", "#", "<cmd>lua Search_for_selection('?')<cr>")

function Literal_search(searchOperator)
	local escaped_text = EscapeForLiteralSearch(vim.fn.input("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys(searchOperator .. '\\V' .. escaped_text)
	FeedKeysInt("<cr>")
end
Map("", "<leader>c", "<cmd>lua Literal_search('/')<cr>")
Map("", "<leader>C", "<cmd>lua Literal_search('?')<cr>")

function Search_for_register(search_operator)
	local char = GetChar("Input register key to search for:")
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(search_operator .. '\\V' .. escaped_register)
	FeedKeysInt('<cr>')
end
Map("", "<leader>f", "<cmd>lua Search_for_register('/')<cr>")
Map("", "<leader>F", "<cmd>lua Search_for_register('?')<cr>")

function Move_default_to_other()
	local char = GetChar("Register: ")
	if not char then return end
	local register = Validate_register(char)
	local default_contents = vim.fn.getreg('"')
	vim.fn.setreg(register, default_contents)
end
Map("n", "<leader>g", Move_default_to_other)

function Search_for_char(search_operator)
	local char = GetChar("Input char key to search for:")
	if not char then return end
	local escaped_char = EscapeForLiteralSearch(char)
	FeedKeys("m" .. THROWAWAY_MARK .. search_operator .. '\\V' .. escaped_char)
	FeedKeysInt('<cr>')
end
Map("", "<leader>s", "<cmd>lua Search_for_char('/')<cr>")
Map("", "<leader>S", "<cmd>lua Search_for_char('?')<cr>")

function Search_for_newlines(search_operator)
	local newlines = vim.v.count1 + 1
	local newlines_str = string.rep("\\n", newlines)
	FeedKeys(search_operator .. newlines_str .. "/e")
	FeedKeysInt('<cr>')
end
Map("", "<leader>a", function() Search_for_newlines('/') end)
Map("", "<leader>A", function() Search_for_newlines('?') end)

function Search_for_current_word(direction)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = vim.fn.getreg('"')
		FeedKeys(direction .. '\\v<' .. escaped_word .. ">")
		FeedKeysInt('<cr>')
	end)
end
Map("n", "*", function() Search_for_current_word('/') end)
Map("n", "#", function() Search_for_current_word('?') end)