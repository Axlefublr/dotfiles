local function build_opts(_, opts)
	local function devicons()
		local devicons = env.saquire('nvim-web-devicons')
		if not devicons then return end
		local path = vim.api.nvim_buf_get_name(0)
		local tail = vim.fn.fnamemodify(path, ':t')
		local icon, highlight = devicons.get_icon(tail)
		return icon, highlight
	end

	local function padding(amount)
		if not amount then amount = 1 end
		return {
			provider = string.rep(' ', amount),
			update = function() return false end,
		}
	end

	local function fill()
		return {
			update = function() return false end,
			provider = '%=',
		}
	end

	return {
		tabline = {
			padding(),
			{
				init = function(self)
					local icon, highlight = devicons()
					if icon then self.icon = icon end
					if highlight then self.icon_hl = highlight end
				end,
				provider = function(self) return self.icon and self.icon .. ' ' end,
				hl = function(self) return self.icon_hl end,
				update = 'FileType',
			},
			{
				provider = function()
					if vim.bo.filetype == 'oil' then
						local oil_dir = require('oil').get_current_dir() -- ends with a /
						local cwd_relative = vim.fn.fnamemodify(oil_dir, ':~:.')
						return cwd_relative:sub(1, -2)
					else
						return vim.fn.expand('%:~:.')
					end
				end,
				update = { 'BufEnter', 'DirChanged' },
			},
			fill(),
			{
				provider = function()
					local cwd = vim.fn.getcwd()
					return vim.fn.fnamemodify(cwd, ':~')
				end,
				update = 'DirChanged',
			},
			padding(),
		},
		statusline = {
			padding(),
			{
				static = {
					mode_hls = {
						['n'] = env.color.yellow,
						['i'] = env.color.green,
						['v'] = env.color.mint,
						['V'] = env.color.cyan,
						[''] = env.color.red,
						['c'] = env.color.purple,
						['R'] = env.color.blush,
						['s'] = env.color.mint,
						['S'] = env.color.cyan,
						[''] = env.color.red,
					},
					mode_names = {
						['n'] = 'normal',
						['i'] = 'insert',
						['v'] = 'visual',
						['V'] = 'linews',
						[''] = 'blocky',
						['c'] = 'comand',
						['R'] = 'replce',
						['s'] = 'select',
						['S'] = 'seline',
						[''] = 'selock',
					},
				},
				init = function(self) self.mode = vim.fn.mode() end,
				hl = function(self)
					if self.mode_hls[self.mode] then
						return { fg = self.mode_hls[self.mode], bold = true }
					else
						return { fg = env.color.white, bold = true }
					end
				end,
				provider = function(self)
					if self.mode_names[self.mode] then
						return self.mode_names[self.mode]
					else
						return self.mode
					end
				end,
				update = 'ModeChanged',
			},
			fill(),
			{
				provider = function()
					local line = vim.fn.line('.')
					local char = vim.fn.virtcol('.')
					return ('%%%dd:%%-%dd'):format(3, 2):format(line, char)
				end,
			},
			{
				provider = function()
					local text = '%4p%%'
					local current_line = vim.fn.line('.')
					if current_line == 1 then
						text = 'top'
					elseif current_line == vim.fn.line('$') then
						text = 'bot'
					end
					return text
				end,
			},
			{
				provider = function()
					local filetype = vim.bo.filetype
					if filetype ~= '' then
						return ' ' .. filetype
					else
						return ''
					end
				end,
				hl = function(self)
					local _, highlight = devicons()
					return highlight
				end,
				update = 'FileType',
			},
			{
				provider = ' ' .. env.icons.circle_dot,
				condition = function() return vim.bo.modified end,
			},
			padding(),
		},
		-- statuscolumn = { -- FIXME: foldable things should be shown with a highlihgt (maybe check how gitsigns does it)
		-- 	{
		-- 		provider = function()
		-- 			return '%=' .. vim.v.relnum .. ' '
		-- 		end,
		-- 		hl = function()
		-- 			if vim.fn. then return { bg = env.color.dark14 } end
		-- 		end
		-- 	},
		-- },
	}
end

return {
	'rebelot/heirline.nvim',
	event = 'UiEnter',
	opts = build_opts,
}
