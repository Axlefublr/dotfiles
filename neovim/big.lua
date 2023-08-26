-- I call it death because that's where we end up in. Just like /e or no /e
function Search_for_selection(death)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys('/\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
	end)
end
Map("v", "*", function() Search_for_selection('') end)
Map("v", "#", function() Search_for_selection('/e') end)

function Literal_search(death)
	local escaped_text = EscapeForLiteralSearch(vim.fn.input("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys('/\\V' .. escaped_text .. death)
	FeedKeysInt("<cr>")
end
Map("", "<leader>c", function() Literal_search('') end)
Map("", "<leader>C", function() Literal_search('/e') end)

function Search_for_register(death)
	local char = GetChar("Input register key to search for:")
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys('/\\V' .. escaped_register .. death)
	FeedKeysInt('<cr>')
end
Map("", "<leader>f", function() Search_for_register('') end)
Map("", "<leader>F", function() Search_for_register('/e') end)

function Move_default_to_other()
	local char = GetChar("Register: ")
	if not char then return end
	local register = Validate_register(char)
	local default_contents = vim.fn.getreg('"')
	vim.fn.setreg(register, default_contents)
end
Map("n", "<leader>g", Move_default_to_other)

function Search_for_newlines(death)
	local newlines = vim.v.count1 + 1
	local newlines_str = string.rep("\\n", newlines)
	FeedKeys('/\\V' .. newlines_str .. death)
	FeedKeysInt('<cr>')
end
Map("", "<leader>a", function() Search_for_newlines('') end)
Map("", "<leader>A", function() Search_for_newlines('/e') end)

function Search_for_current_word(death)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys('/\\V\\<' .. escaped_word .. "\\>" .. death)
		FeedKeysInt('<cr>')
	end)
end
Map("n", "*", function() Search_for_current_word('') end)
Map("n", "#", function() Search_for_current_word('/e') end)

local function visual_replace()
	FeedKeys('ygv')
	vim.schedule(function()
		local default_contents = vim.fn.getreg('"')
		local what = vim.fn.input("what: ")
		if what == '' then return end
		what = string.gsub(what, '\\\\', '\\')
		what = string.gsub(what, '\\n', '\n')
		what = string.gsub(what, '\\t', '\t')
		local with = vim.fn.input("with: ")
		with = string.gsub(with, '\\\\', '\\')
		with = string.gsub(with, '\\n', '\n')
		with = string.gsub(with, '\\t', '\t')
		with = string.gsub(with, '\\s', what)
		local splitted = string.gsub(default_contents, what, with)
		vim.fn.setreg('"', splitted)
		FeedKeys('p')
	end)
end
Map("v", "<leader>z", visual_replace)