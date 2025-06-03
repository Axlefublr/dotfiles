--- @sync entry
return {
	entry = function()
		local collector = ''
		for _, url in pairs(cx.active.selected) do
			collector = collector .. tostring(url) .. '\n'
		end
		if #collector == 0 then
			collector = tostring(cx.active.current.hovered.url) .. '\n'
		end
		local file = io.open('/home/axlefublr/.cache/mine/yazi-file-list', 'w')
		if file then
			file:write(collector)
			file:close()
		end
	end,
}
