--- @sync entry
return {
	entry = function()
		ps.sub('cd', function()
			local cwd = tostring(cx.active.current.cwd)
			local file = io.open('/tmp/helix-cwd-suspend', 'w')
			if file then
				file:write(cwd)
				file:close()
			end
			local file = io.open('/tmp/helix-buffer-head-suspend', 'w')
			if file then
				file:write(cwd)
				file:close()
			end
		end)
	end,
}
