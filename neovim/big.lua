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

function Regex_search(searchOperator)
	FeedKeys(searchOperator .. '\\v')
end
Map("", "<leader>/", "<cmd>lua Regex_search('/')<cr>")
Map("", "<leader>?", "<cmd>lua Regex_search('?')<cr>")

function Literal_search(searchOperator)
	local escaped_text = EscapeForLiteralSearch(vim.fn.input("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys(searchOperator .. '\\V' .. escaped_text)
	FeedKeysInt("<cr>")
end
Map("", "/", "<cmd>lua Literal_search('/')<cr>")
Map("", "?", "<cmd>lua Literal_search('?')<cr>")

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

	Cmd(range .. "s/" .. magic .. what .. "/" .. with .. "/g")
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

	Cmd(global_command_str .. '/' .. magic .. pattern .. '/' .. command)
end
