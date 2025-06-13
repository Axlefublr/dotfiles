function Status:name() return '' end

require('toggle-pane'):entry('min-preview')
require("smart-enter"):setup {
	open_multi = true,
}

function Tabs.height()
	return 0
end

Header:children_add(function()
	if #cx.tabs <= 1 then
		return ""
	end
	local spans = {}
	for i = 1, #cx.tabs do
		local name = ya.truncate(string.format(" %d %s ", i, cx.tabs[i].name), { max = 20 })
		if i == cx.tabs.idx then
			spans[#spans + 1] = ui.Span(name):style(th.tabs.active)
		else
			spans[#spans + 1] = ui.Span(name):style(th.tabs.inactive)
		end
	end
	return ui.Line(spans)
end, 9000, Header.RIGHT)
