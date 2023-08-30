local numbered = setmetatable({'', '', '', '', '', '', '', '', '', ''}, {__index = table})

local function numbered_get(index)
	if numbered[index] == '' then
		print(index .. ' is empty')
		return
	end
	vim.fn.setreg('"', numbered[index])
	print("grabbed")
end

local function numbered_set(index)
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print("default register empty")
		return
	end
	numbered[index] = register_contents
	print("stabbed")
end

Map({'n', 'v'}, "'1", function() numbered_get(1) end)
Map({'n', 'v'}, "'2", function() numbered_get(2) end)
Map({'n', 'v'}, "'3", function() numbered_get(3) end)
Map({'n', 'v'}, "'4", function() numbered_get(4) end)
Map({'n', 'v'}, "'5", function() numbered_get(5) end)
Map({'n', 'v'}, "'6", function() numbered_get(6) end)
Map({'n', 'v'}, "'7", function() numbered_get(7) end)
Map({'n', 'v'}, "'8", function() numbered_get(8) end)
Map({'n', 'v'}, "'9", function() numbered_get(9) end)
Map({'n', 'v'}, "'0", function() numbered_get(10) end)

Map({'n', 'v'}, ",1", function() numbered_set(1) end)
Map({'n', 'v'}, ",2", function() numbered_set(2) end)
Map({'n', 'v'}, ",3", function() numbered_set(3) end)
Map({'n', 'v'}, ",4", function() numbered_set(4) end)
Map({'n', 'v'}, ",5", function() numbered_set(5) end)
Map({'n', 'v'}, ",6", function() numbered_set(6) end)
Map({'n', 'v'}, ",7", function() numbered_set(7) end)
Map({'n', 'v'}, ",8", function() numbered_set(8) end)
Map({'n', 'v'}, ",9", function() numbered_set(9) end)
Map({'n', 'v'}, ",0", function() numbered_set(10) end)