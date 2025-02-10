--- @sync entry
return {
	entry = function()
		local cwd = tostring(cx.active.current.cwd)
		local file = io.open('/tmp/yazi-cwd-suspend', 'w')
		if file then
			file:write(cwd)
			file:close()
		end
		ya.manager_emit('suspend', {})
	end,
}
