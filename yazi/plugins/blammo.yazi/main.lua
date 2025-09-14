--- @sync entry
return {
	entry = function()
		local collector = ''
		for _, url in pairs(cx.active.selected) do
			collector = collector .. tostring(url) .. '\n'
		end
		local hovered = tostring(cx.active.current.hovered.url) .. '\n'
		if #collector == 0 then
			collector = hovered
		end
		local file = io.open('/home/axlefublr/.cache/mine/blammo', 'w')
		if file then
			file:write(collector)
			file:close()
		end
		local file = io.open('/home/axlefublr/.cache/mine/blammo-selection', 'w')
		if file then
			file:write(hovered)
			file:close()
		end
	end,
}
