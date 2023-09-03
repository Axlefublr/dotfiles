-- I call it death because that's where we end up in. Just like /e or no /e
function Search_for_selection(direction, death)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
	end)
end

function Search_for_register(direction, death)
	local char = GetChar("register: ")
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(direction .. '\\V' .. escaped_register .. death)
	FeedKeysInt('<cr>')
end

function Move_default_to_other()
	local char = GetChar("register: ")
	if not char then return end
	local register = Validate_register(char)
	local default_contents = vim.fn.getreg('"')
	vim.fn.setreg(register, default_contents)
end

function Search_for_current_word(direction, death)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V' .. escaped_word .. death)
		FeedKeysInt('<cr>')
	end)
end