local killring = setmetatable({}, {__index = table})

local function killring_push()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print("default register is empty")
		return
	end
	killring:insert(register_contents)
	print("pushed")
end
Map("n", "<leader>z", killring_push)

local function killring_pop_tail()
	if #killring <= 0 then
		print("killring empty!")
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg('"', first_index)
	print("got tail")
end
Map("n", "<leader>x", killring_pop_tail)

local function killring_take_numbered(index)
	if index > #killring then
		print("no value at index!")
		return
	end
	local register_contents = killring[index]
	vim.fn.setreg('"', register_contents)
	print("got contents of " .. index)
end
Map({"n", "v"}, "'1", function() killring_take_numbered(1) end)
Map({"n", "v"}, "'2", function() killring_take_numbered(2) end)
Map({"n", "v"}, "'3", function() killring_take_numbered(3) end)
Map({"n", "v"}, "'4", function() killring_take_numbered(4) end)
Map({"n", "v"}, "'5", function() killring_take_numbered(5) end)
Map({"n", "v"}, "'6", function() killring_take_numbered(6) end)
Map({"n", "v"}, "'7", function() killring_take_numbered(7) end)
Map({"n", "v"}, "'8", function() killring_take_numbered(8) end)
Map({"n", "v"}, "'9", function() killring_take_numbered(9) end)
Map({"n", "v"}, "'0", function() killring_take_numbered(0) end)
