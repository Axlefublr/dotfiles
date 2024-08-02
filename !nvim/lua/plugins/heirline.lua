local function build_opts(_, opts)
	local function devicons()
		---@module "nvim-web-devicons"
		local devicons = env.saquire('nvim-web-devicons')
		if not devicons then return end
		local path = vim.api.nvim_buf_get_name(0)
		if not path or path == '' then return end
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
			{
				init = function(self)
					local icon, highlight = devicons()
					self.icon = icon
					self.icon_hl = highlight
				end,
				provider = function(self) return self.icon and self.icon ~= '' and self.icon .. ' ' end,
				hl = function(self) return self.icon_hl end,
				update = { 'FileType', 'WinEnter', 'BufEnter' },
				condition = function()
					return vim.bo.filetype ~= '' and vim.api.nvim_buf_get_name(0) ~= ''
				end,
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
		},
		statusline = {
			{ -- mode
				static = {
					mode_hls = {
						-- ['n'] = env.color.white,
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
						return env.high({ fg = self.mode_hls[self.mode], bold = true })
					else
						return env.high({ fg = env.color.white, bold = true })
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
			{ -- latest :command
				hl = env.high({ fg = env.color.feeble }),
				condition = function() return vim.fn.getreg(':') ~= '' end,
				update = 'CmdlineLeave',
				padding(),
				{
					provider = ':',
					update = false,
				},
				{
					provider = function() return vim.fn.getreg(':') end,
				},
			},
			{ -- cmdinfo
				hl = env.high({ fg = env.color.orange, bold = true }),
				provider = ' %S',
			},
			fill(),
			{ -- macro record
				condition = function() return vim.fn.reg_recording() ~= '' end,
				hl = env.high({ fg = env.color.orange, bold = true }),
				update = {
					'RecordingEnter',
					'RecordingLeave',
				},
				{
					provider = ' ',
				},
				{
					provider = function() return vim.fn.reg_recording() end,
				},
				padding(),
			},
			{ -- searches
				condition = function() return vim.v.hlsearch ~= 0 end,
				{
					init = function(self)
						local ok, search = pcall(vim.fn.searchcount)
						if ok and search.total then self.search = search end
					end,
					hl = env.high({ fg = env.color.purple, bold = true }),
					provider = function(self)
						local search = self.search
						return string.format('%s %d/%d', env.icons.magnifying_glass, search.current, search.total)
					end,
				},
				padding(),
			},
			{ -- ruler
				provider = function()
					local line = vim.fn.line('.')
					local char = vim.fn.virtcol('.')
					return ('%%%dd:%%-%dd'):format(3, 2):format(line, char)
				end,
			},
			{ -- percentage
				update = 'CursorMoved',
				padding(),
				{
					provider = function()
						local text = '%2p%%'
						local current_line = vim.fn.line('.')
						if current_line == 1 then
							text = 'top'
						elseif current_line == vim.fn.line('$') then
							text = 'bot'
						end
						return text
					end,
				},
			},
			{ -- filetype
				padding(),
				{ provider = function()
					return vim.bo.filetype
				end },
				condition = function() return vim.bo.filetype ~= '' end,
				hl = env.high({ bold = true }),
				update = { 'FileType', 'BufEnter' },
			},
			{ -- modified
				provider = ' ' .. env.icons.circle_dot,
				condition = function() return vim.bo.modified end,
			},
		},
		statuscolumn = {
			{
				condition = function() return vim.wo.relativenumber end,
				init = function(self)
					local ffi = require('stolen_ffi')
					local wp = ffi.C.find_window_by_handle(0, ffi.new('Error')) -- get window handler
					local fold_info = ffi.C.fold_info(wp, vim.v.lnum)
					-- local starts_a_fold =  and '%#FoldColumn# ' or ' '
					self.starts_a_fold = fold_info.start == vim.v.lnum
					self.isnt_wrapped = vim.v.virtnum <= 0
				end,
				{
					condition = function(self) return self.isnt_wrapped end,
					provider = function() return env.to_base_36(vim.v.relnum) end,
				},
				{
					condition = function(self) return self.isnt_wrapped and self.starts_a_fold end,
					hl = env.high({ bg = env.color.dark13 }),
					provider = ' ',
				},
			},
		},
	}
end

---@type LazyPluginSpec
return {
	'rebelot/heirline.nvim',
	event = 'UiEnter',
	opts = build_opts,
}
