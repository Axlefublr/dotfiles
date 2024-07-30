if not env then env = {} end -- makes more sense once you consider `:source`
env.temp_mark = 'P'
env.default_register = '+'
-- env.soundeffects = vim.fn.expand('~/mus/soundeffects/')
env.external_extensions = { 'mp4', 'webm', 'mkv', 'jpg', 'png', 'gif', 'svg', 'mp3', 'wav', 'ogg', 'oga' }

env.treesitters = { 'diff', 'markdown_inline' }
env.lsps = { 'lua_ls', 'jsonls', 'html', 'cssls', 'emmet_ls', 'marksman', 'pyright', 'taplo', 'yamlls' }
env.formatters_by_ft = {
	lua = { 'stylua' },
	fish = { 'fish_indent' },
	html = { { 'prettierd', 'prettier' } },
	css = { { 'prettierd', 'prettier' } },
	scss = { { 'prettierd', 'prettier' } },
	less = { { 'prettierd', 'prettier' } },
	markdown = { { 'prettierd', 'prettier' } },
	['markdown.mdx'] = { { 'prettierd', 'prettier' } },
	python = { 'isort', 'black' },
	yaml = { { 'prettierd', 'prettier' } },
}
env.linters_by_ft = {
	fish = { 'fish' },
}

env.borders = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }
env.sleek_borders = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' }
env.extra_directories = {
	'~/t',
	'~/prog/noties',
	'~/.local/share/alien_temple',
	'~/.local/share/glaza',
}
env.color = {
	shell_red = '#ff2930',
	shell_orange = '#ff9f1a',
	shell_yellow = '#ffd75f',
	shell_salad = '#87ff5f',
	shell_green = '#3dff47',
	shell_cyan = '#00d7ff',
	shell_purple = '#af87ff',
	shell_pink = '#ffafd7',
	shell_grey = '#878787',

	black = '#0f0f0f',
	red = '#ea6962',
	orange = '#e49641',
	yellow = '#d3ad5c',
	green = '#a9b665',
	mint = '#78bf84',
	cyan = '#7daea3',
	purple = '#b58cc6',
	blush = '#e491b2',
	white = '#d4be98',
	grey = '#928374',

	light25 = '#403f3f',
	light19 = '#313030',
	level = '#292828',
	dark14 = '#242323',
	dark13 = '#212121',
	dark12 = '#1f1e1e',
	dark10 = '#1a1919',
}
env.icons = {
	circle_dot = '',
	diag_error = '',
	diag_hint = '󰌵',
	diag_info = '󰋼',
	diag_warn = '',
	debug = '',
}

function table.reverse(tbl)
	local reversed = {}
	local length = #tbl
	for i = length, 1, -1 do
		table.insert(reversed, tbl[i])
	end
	return reversed
end

function table.contains(table, item)
	for _, thingy in pairs(table) do
		if thingy == item then return true end
	end
	return false
end

function table.slice(tbl, start, stop)
	local sliced = {}
	for index = start or 1, (stop or #tbl) do
		table.insert(sliced, tbl[index])
	end
	return sliced
end

function table.index(tbl, item)
	for index, value in ipairs(tbl) do
		if value == item then return index end
	end
end

function table.join(tbl, joiner) return vim.fn.join(tbl, joiner) end

function string.trim(string, what) return vim.fn.trim(string, what or '') end

function string.rtrim(string, what) return vim.fn.trim(string, what or '', 2) end

function string.split(string, separator) return vim.fn.split(string, separator) end

---@param event string|string[]
---@param pattern (string|string[])?
---@param todo string|function `command` or `callback`
---@param opts table? other opts you may want to add to the autocmd
function env.acmd(event, pattern, todo, opts)
	local opts = opts or {}
	if pattern then opts.pattern = pattern end
	if type(todo) == 'string' then
		opts.command = todo
	elseif type(todo) == 'function' then
		opts.callback = todo
	end
	vim.api.nvim_create_autocmd(event, opts)
end

---Emit event into every valid buffer
---@param event string|string[]
---@param opts vim.api.keyset.exec_autocmds for the autocmd
function env.emit_bufs(event, opts)
	opts = vim.tbl_deep_extend('force', opts or {}, { modeline = false })
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		for _, bufnr in ipairs(vim.t[tabpage].bufs or {}) do
			if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype then
				opts.buffer = bufnr
				pcall(vim.api.nvim_exec_autocmds, event, opts)
			end
		end
	end
end

function env.echo(chunks, history)
	if history == nil then history = false end
	if type(chunks) == 'string' then
		chunks = { { chunks } }
	elseif type(chunks) == 'table' then
		for index, value in ipairs(chunks) do
			if type(value) == 'string' then
				chunks[index] = { value }
			elseif type(value) ~= 'table' then
				chunks[index] = { tostring(value) }
			end
		end
	else
		chunks = { { tostring(chunks) } }
	end
	vim.api.nvim_echo(chunks, history, {})
end

function env.shell(cmd, opts, on_exit)
	if type(cmd) == 'string' then cmd = { cmd } end
	return vim.system(cmd, vim.tbl_deep_extend('force', { text = true }, opts or {}), on_exit)
end

---@return string|nil
function env.input(prompt, default)
	local output = vim.fn.input({ prompt = prompt, default = default, cancelreturn = '\127' })
	if output == '\127' then
		return nil
	else
		return output
	end
end

function env.feedkeys(keys) vim.api.nvim_feedkeys(keys, 'n', false) end

function env.feedkeys_int(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, 'n', true)
end

--- Return the next character the user presses
---@param prompt string|nil
---@return string|nil character `nil` if the user pressed <Esc>
function env.char(prompt)
	if prompt then env.echo(prompt) end
	---@type string|nil
	local char = vim.fn.getcharstr()
	-- In '' is the escape character (<Esc>).
	-- Not sure how to check for it without literal character magic.
	if char == '' then char = nil end
	return char
end

function env.confirm(prompt, state, default)
	local options = {}
	for _, value in ipairs(state) do
		table.insert(options, value[1])
	end
	options = vim.fn.join(options, '\n')
	local index = vim.fn.confirm(prompt or '', options, default or 1)
	if index == 0 then return nil end
	return state[index][2]
end

function env.confirm_same(prompt, options, default)
	options_text = vim.fn.join(options, '\n')
	local index = vim.fn.confirm(prompt, options_text, default or 1)
	if index == 0 then return nil end
	return options[index]
end

local function get_selection_col_bounds()
	local maybe_start_col = vim.fn.col('v')
	local maybe_end_col = vim.fn.col('.')
	local start_col = maybe_start_col <= maybe_end_col and maybe_start_col or maybe_end_col
	local end_col = maybe_end_col >= maybe_start_col and maybe_end_col or maybe_start_col
	return start_col, end_col
end

---@return string[]
function env.get_inline_selection()
	local start_col, end_col = get_selection_col_bounds()
	return vim.api.nvim_buf_get_text(0, vim.fn.line('.') - 1, start_col - 1, vim.fn.line('.') - 1, end_col, {})
end

---@param text table|string
function env.replace_inline_selection(text)
	local start_col, end_col = get_selection_col_bounds()
	if type(text) == 'string' then text = { text } end
	vim.api.nvim_buf_set_text(0, vim.fn.line('.') - 1, start_col - 1, vim.fn.line('.') - 1, end_col, text)
end

---Gets a plugin spec.
---@param plugin string Name without author.
---@return LazyPlugin? available
function env.plugetspec(plugin)
	local lazy_config_available, lazy_config = pcall(require, 'lazy.core.config')
	return lazy_config_available and lazy_config.spec.plugins[plugin] or nil
end

---Resolve the `opts` table for a given plugin.
---@param plugin string Name without author.
---@return table opts
function env.plugopts(plugin)
  local spec = env.plugetspec(plugin)
  return spec and require("lazy.core.plugin").values(spec, "opts") or {}
end

---Check if a plugin is avaiable.
function env.plugalid(plugin) return env.plugetspec(plugn) ~= nil end

---A safe `require` that silently fails instead of yelling at you.
---@return table? module
function env.saquire(requiree)
	local success, module_or_error = pcall(require, requiree)
	if success then
		local module = module_or_error
		return module
	else
		local error = module_or_error
		vim.notify(error, vim.log.levels.ERROR)
		return nil
	end
end

---Wrap a function to load a plugin before executing.
---@param plugin string
---@param module table
---@param funcs string|string[]
function env.func_loads_plugin(plugin, module, funcs)
	if type(funcs) == 'string' then funcs = { funcs } end
	for _, func in ipairs(funcs) do
		local old_func = module[func]
		module[func] = function(...)
			module[func] = old_func
			require('lazy').load({ plugins = { plugin } })
			module[func](...)
		end
	end
end

---Execute a function once a plugin is loaded, or immediately if it already is.
---@param plugins string|string[] the name of the plugin or a list of plugins to defer the function execution on. If a list is provided, only one needs to be loaded to execute the provided function.
---@param load_op fun()|string|string[] the function to execute when the plugin is loaded, a plugin name to load, or a list of plugin names to load
function env.on_load(plugins, load_op)
	local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
	if not lazy_config_avail then return end
	if type(plugins) == 'string' then plugins = { plugins } end
	if type(load_op) ~= 'function' then
		local to_load = type(load_op) == 'string' and { load_op } or load_op --[=[@as string[]]=]
		load_op = function() require('lazy').load({ plugins = to_load }) end
	end

	for _, plugin in ipairs(plugins) do
		if vim.tbl_get(lazy_config.plugins, plugin, '_', 'loaded') then
			vim.schedule(load_op)
			return
		end
	end
	vim.api.nvim_create_autocmd('User', {
		pattern = 'LazyLoad',
		callback = function(args)
			if vim.tbl_contains(plugins, args.data) then
				load_op()
				return true
			end
		end,
	})
end
