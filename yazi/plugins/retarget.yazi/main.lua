-- stolen from https://github.com/superb-striker/retarget-link.yazi/blob/main/main.lua

local get_hovered_path = ya.sync(function()
	local h = cx.active.current.hovered
	return h and tostring(h.url) or nil
end)

return {
	entry = function()
		local link = get_hovered_path()
		if not link then
			return
		end

		local result = Command("readlink"):arg(link):output()
		if not result or result.status.code ~= 0 then
			return ya.notify {
				title = "Change symlink target",
				content = "Could not read the symlink target.",
				level = "error",
			}
		end

		local current_target = result.stdout:gsub("[\r\n]+$", "")
		local target, event = ya.input {
			title = "Target:",
			value = current_target,
			pos = { "hovered", y = 1, w = 60 },
		}

		-- Esc cancels; leave the symlink unchanged.
		if event ~= 1 or not target or target == "" then
			return
		end

		local changed = Command("ln")
			:arg({ "-sfn", target, link })
			:output()

		if not changed or changed.status.code ~= 0 then
			ya.notify {
				title = "Change symlink target",
				content = "Could not update the symlink.",
				level = "error",
			}
		end
	end,
}
