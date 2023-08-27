-- I call it death because that's where we end up in. Just like /e or no /e
function Search_for_selection(direction, death)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
	end)
end
Map("v", "*", function() Search_for_selection('/', '') end)
Map("v", "<leader>*", function() Search_for_selection('/', '/e') end)
Map("v", "#", function() Search_for_selection('?', '') end)
Map("v", "<leader>#", function() Search_for_selection('?', '/e') end)

function Search_for_register(direction, death)
	local char = GetChar("register: ")
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(direction .. '\\V' .. escaped_register .. death)
	FeedKeysInt('<cr>')
end
Map("", "]f", function() Search_for_register('/', '') end)
Map("", "<leader>s", function() Search_for_register('/', '/e') end)
Map("", "[f", function() Search_for_register('?', '') end)

function Move_default_to_other()
	local char = GetChar("register: ")
	if not char then return end
	local register = Validate_register(char)
	local default_contents = vim.fn.getreg('"')
	vim.fn.setreg(register, default_contents)
end
Map("n", "<leader>g", Move_default_to_other)

function Search_for_current_word(direction, death)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V\\<' .. escaped_word .. "\\>" .. death)
		FeedKeysInt('<cr>')
	end)
end
Map("n", "*", function() Search_for_current_word('/', '') end)
Map("n", "<leader>*", function() Search_for_current_word('/', '/e') end)
Map("n", "#", function() Search_for_current_word('?', '') end)
Map("n", "<leader>#", function() Search_for_current_word('?', '/e') end)

local function write_to_register()
	local register = GetChar('register: ')
	if not register then print("no such register") return end
	register = Validate_register(register)
	local register_contents = vim.fn.getreg(register)
	local input = vim.fn.input(register_contents)
	if input == '' then return end
	vim.fn.setreg(register, input)
end
Map({"n", "v"}, "<leader>a", write_to_register)