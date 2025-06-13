--- @sync entry
return {
	entry = function()
		local cur = cx.active.current
		local files = cur.files
		local target_index = nil

		-- Find first non directory index
		for i = 1, #files do
			if not files[i].cha.is_dir then
				target_index = i
				break
			end
		end

		local delta = target_index - cur.cursor
		ya.manager_emit("arrow", { delta - 1 })
	end,
}
