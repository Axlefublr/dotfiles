---@diagnostic disable: inject-field
local function build_opts()
	local function devicons()
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
			update = false,
		}
	end

	local function text(text)
		return {
			provider = text,
			update = false,
		}
	end

	local fill = {
		update = function() return false end,
		provider = '%=',
	}

	---@param provider string|function
	---@param side nil|'right'|'left' `'right'` if `nil`
	local function decreasing_length(provider, side)
		local elements = {
			{ provider = provider },
		}
		for length = 80, 0, -5 do
			table.insert(elements, {
				provider = function()
					local output = nil
					if type(provider) == 'function' then
						output = provider()
					else
						output = provider
					end
					if length == 0 then return env.icons.etc end
					if not side or side == 'right' then
						return output:sub(1, length) .. env.icons.etc
					else
						return env.icons.etc .. output:sub(#output - length)
					end
				end,
			})
		end
		return unpack(elements)
	end

	---@type HeirlineConfig
	return {
		tabline = {
			{ -- buffer icon
				init = function(self)
					local icon, highlight = devicons()
					self.icon = icon
					self.icon_hl = highlight
				end,
				provider = function(self) return self.icon and self.icon ~= '' and self.icon .. ' ' end,
				hl = function(self) return self.icon_hl end,
				update = { 'FileType', 'WinEnter', 'BufEnter' },
				condition = function() return vim.bo.filetype ~= '' and vim.api.nvim_buf_get_name(0) ~= '' end,
			},
			{ -- buffer path
				update = { 'BufEnter', 'DirChanged', 'VimResized' },
				{
					flexible = 20,
					decreasing_length(function()
						if vim.bo.filetype == 'oil' then
							local oil_dir = require('oil').get_current_dir() -- ends with a /
							local cwd_relative = vim.fn.fnamemodify(oil_dir --[[@as string]], ':~:.')
							return cwd_relative:sub(1, -2)
						else
							return vim.fn.expand('%:~:.')
						end
					end, 'left'),
				},
			},
			fill,
			{ -- git branch
				update = { 'User', pattern = { 'GitSignsUpdate' } },
				{
					condition = require('heirline.conditions').is_git_repo(),
					init = function(self)
						self.dict = vim.b.gitsigns_status_dict
					end,
					hl = env.high({ fg = env.color.purple, bold = true }),
					{
						condition = function(self)
							return self.dict
						end,
						text(''),
						{
							provider = function(self)
								return self.dict.head
							end
						},
						padding(),
					}
				},
			},
			{ -- cwd
				update = { 'DirChanged', 'VimResized' },
				{
					flexible = 10,
					decreasing_length(function()
						local cwd = vim.fn.getcwd()
						return vim.fn.fnamemodify(cwd, ':~')
					end, 'left'),
				},
			},
			{ -- tabline
				condition = function() return #vim.api.nvim_list_tabpages() >= 2 end,
				padding(),
				require('heirline.utils').make_tablist({
					provider = function(self) return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T' end,
					hl = function(self)
						if not self.is_active then
							return 'TabLine'
						else
							return 'TabLineSel'
						end
					end,
				}),
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
			{ -- diags
				update = { 'DiagnosticChanged', 'BufEnter' },
				{
					condition = require('heirline.conditions').has_diagnostics,
					init = function(self)
						self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0
						self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) > 0
						self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }) > 0
						self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) > 0
					end,
					padding(),
					{
						condition = function(self) return self.errors end,
						text('!'),
						hl = 'DiagnosticSignError',
					},
					{
						condition = function(self) return self.warnings end,
						text('!'),
						hl = 'DiagnosticSignWarn',
					},
					{
						condition = function(self) return self.info end,
						text('!'),
						hl = 'DiagnosticSignInfo',
					},
					{
						condition = function(self) return self.hints end,
						text('!'),
						hl = 'DiagnosticSignHint',
					},
				},
			},
			{ -- latest :command
				hl = env.high({ fg = env.color.feeble }),
				update = { 'CmdlineLeave', 'VimResized' },
				{
					condition = function() return vim.fn.getreg(':') ~= '' end,
					padding(),
					text(':'),
					{
						flexible = 1,
						decreasing_length(function()
							local register = vim.fn.getreg(':')
							local cleaned = register:gsub("'", '’')
							return cleaned
						end),
					},
				},
			},
			{ -- cmdinfo
				hl = env.high({ fg = env.color.orange, bold = true }),
				provider = ' %S',
			},
			fill,
			{ -- macro record
				hl = env.high({ fg = env.color.orange, bold = true }),
				update = {
					'RecordingEnter',
					'RecordingLeave',
				},
				{
					condition = function() return vim.fn.reg_recording() ~= '' end,
					text(' '),
					{
						provider = function() return vim.fn.reg_recording() end,
					},
					padding(),
				},
			},
			{ -- searches
				update = { 'CursorMoved', 'InsertEnter', 'InsertLeave', 'CmdlineLeave' },
				{
					condition = function() return vim.v.hlsearch ~= 0 end,
					{
						init = function(self)
							local ok, search = pcall(vim.fn.searchcount)
							if ok and search.total then self.search = search end
						end,
						hl = env.high({ fg = env.color.purple, bold = true }),
						provider = function(self)
							local search = self.search
							if search.current == 0 and search.total == 0 then return end
							return string.format('%s %d/%d', env.icons.magnifying_glass, search.current, search.total)
						end,
					},
					padding(),
				},
			},
			{ -- ruler
				update = 'CursorMoved',
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
				hl = env.high({ bold = true }),
				update = { 'FileType', 'BufEnter' },
				{
					condition = function() return vim.bo.filetype ~= '' end,
					padding(),
					{
						provider = function() return vim.bo.filetype end,
					},
				},
			},
			{ -- modified
				update = 'BufModifiedSet',
				{
					condition = function() return vim.bo.modified end,
					text(' ' .. env.icons.circle_dot),
				},
			},
		},
		statuscolumn = {
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
				text(' '),
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
