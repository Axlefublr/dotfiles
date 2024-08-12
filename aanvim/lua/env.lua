if not env then env = {} end -- makes more sense once you consider `:source`

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

function table.into_keys(tbl)
	local keys = {}
	for key, _ in pairs(tbl) do
		table.insert(keys, key)
	end
	return keys
end

function string.trim(str, what) return vim.fn.trim(str, what or '') end

function string.rtrim(str, what) return vim.fn.trim(str, what or '', 2) end

function string.split(str, separator) return vim.fn.split(str, separator or '\\s\\+') end

env.temp_mark = 'P'
env.default_register = '+'
-- env.soundeffects = vim.fn.expand('~/mus/soundeffects/')
env.external_extensions = { 'mp4', 'webm', 'mkv', 'jpg', 'png', 'gif', 'svg', 'mp3', 'wav', 'ogg', 'oga' }
-- stylua: ignore
env.disabled_default_plugins = {
	'2html_plugin', 'tohtml', 'gzip', 'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', 'tar', 'tarPlugin', 'spellfile', 'spellfile_plugin', 'zip', 'zipPlugin', 'tutor', 'optwin', 'compiler', 'bugreport',
	'rplugin', -- allows other processes to talk to nvim

	-- potentially useful
	'matchit',
	'editorconfig',

	-- god knows what these do
	'synmenu',
	'vimball',
	'vimballPlugin',
	'rrhelper',
	'logipat',
	'getscript',
	'getscriptPlugin',
}

env.treesitters = { 'diff', 'markdown_inline' }
env.lsps = { 'lua_ls', 'jsonls', 'html', 'cssls', 'emmet_ls', 'marksman', 'pyright', 'taplo', 'yamlls' }
-- env.lsp_fts = { 'lua', 'json', 'jsonc', 'html', 'css', 'markdown', 'python', 'toml', 'yaml', 'rust' }
env.formatters_by_ft = {
	lua = { 'stylua' },
	fish = { 'fish_indent' },
	html = { 'prettierd', 'prettier', stop_after_first = true },
	css = { 'prettierd', 'prettier', stop_after_first = true },
	scss = { 'prettierd', 'prettier', stop_after_first = true },
	less = { 'prettierd', 'prettier', stop_after_first = true },
	markdown = { 'prettierd', 'prettier', stop_after_first = true },
	['markdown.mdx'] = { 'prettierd', 'prettier', stop_after_first = true },
	python = { 'isort', 'black' },
	yaml = { 'prettierd', 'prettier', stop_after_first = true },
}
-- env.formatter_fts = table.into_keys(env.formatters_by_ft)
env.linters_by_ft = {
	fish = { 'fish' },
}
-- env.linter_fts = table.into_keys(env.linters_by_ft)

env.borders = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }
-- env.sleek_borders = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' }
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
	feeble = '#5a524c',

	light25 = '#403f3f',
	light19 = '#313030',
	level = '#292828',
	dark14 = '#242323',
	dark13 = '#212121',
	dark12 = '#1f1e1e',
	dark10 = '#1a1919',
}
env.icons = {
	diag_error = '',
	diag_hint = '󰌵',
	diag_info = '󰋼',
	diag_warn = '',
	git_added = '',
	git_modified = '',
	git_deleted = '',
	debug = '',
	circle_dot = '',
	magnifying_glass = '',
	etc = '…',
}

function env.to_base_36(number)
	if number < 0 or number > 35 then
		return '?'
	elseif number == 0 then
		return '┃'
	elseif number < 16 then
		return string.format('%X', number)
	end
	local mappings = {
		[16] = 'G',
		[17] = 'H',
		[18] = 'I',
		[19] = 'J',
		[20] = 'K',
		[21] = 'L',
		[22] = 'M',
		[23] = 'N',
		[24] = 'O',
		[25] = 'P',
		[26] = 'Q',
		[27] = 'R',
		[28] = 'S',
		[29] = 'T',
		[30] = 'U',
		[31] = 'V',
		[32] = 'W',
		[33] = 'X',
		[34] = 'Y',
		[35] = 'Z',
	}
	return mappings[number]
end

---@param event string|string[]
---@param pattern (string|string[])?
---@param todo string|function `command` or `callback`
---@param opts vim.api.keyset.create_autocmd? other opts you may want to add to the autocmd
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

---Try executing a function if `condition` is true or returns true.
---If `todo` is called and *doesn't* return true, also create an autocommand to call that function, using `opts`.
---This is useful for registering autocommands late, so they don't waste startup time.
---And can be used for both one-time actions, and "more than one time" actions.
---@param condition function|boolean
---@param todo function
---@param opts vim.api.keyset.create_autocmd?
function env.do_and_acmd(condition, todo, opts)
	local opts = opts or {}
	if type(condition) == 'function' then
		if condition() then
			if todo() then return end
		end
	else
		if condition then
			if todo() then return end
		end
	end
	opts.callback = todo
	local event = opts.event
	---@diagnostic disable-next-line: inject-field
	opts.event = nil
	vim.api.nvim_create_autocmd(event, opts)
end

---@class UserCommandExecuteClosure
---@field name string Command name.
---@field args string The args passed to the command, if any.
---@field fargs string[] The args split by unescaped whitespace (when more than one argument is allowed), if any.
---@field nargs integer Number of arguments.
---@field bang boolean "true" if the command was executed with a ! modifier.
---@field line1 integer The starting line of the command range.
---@field line2 integer The final line of the command range.
---@field range 0|1|2 The number of items in the command range.
---@field count integer Any count supplied.
---@field reg string The optional register, if specified.
---@field mods string Command modifiers, if any.
---@field smods table Command modifiers in a structured format.

---@param name string
---@param execute string|fun(args: UserCommandExecuteClosure)
---@param opts vim.api.keyset.user_command?
function env.cmd(name, execute, opts) vim.api.nvim_create_user_command(name, execute, opts or {}) end

---Emit event
---@param event string|string[]
---@param pattern (string|string[])?
---@param opts vim.api.keyset.exec_autocmds? for the autocmd
function env.emit(event, pattern, opts)
	local opts = vim.tbl_deep_extend('force', { modeline = false }, opts or {})
	if pattern then opts.pattern = pattern end
	pcall(vim.api.nvim_exec_autocmds, event, opts)
end

---Emit event into every valid buffer
---@param event string|string[]
---@param opts vim.api.keyset.exec_autocmds? for the autocmd
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

---@param chunks string|string[]|[string, string][]
---@param history boolean?
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
	local opts = vim.tbl_deep_extend('force', { text = true }, opts or {})
	if not opts.cwd then opts.cwd = vim.fn.getcwd() end
	return vim.system(cmd, opts, on_exit)
end

--- `env.shell`, but display the output in a `vim.notify` if it's a single line
--- and in a new split, if there are multiple lines of output.
--- Will be syncronous.
--- @param only_errors boolean? Only display output if there are errors
function env.shay(cmd, only_errors, opts)
	local output = env.shell(cmd, opts):wait()
	local successful = output.code == 0
	if only_errors and successful then return end
	local output_text = ''
	local stdout = output.stdout:rtrim()
	local stderr = output.stderr:rtrim()

	if #stdout > 0 then
		output_text = output_text .. stdout
	end
	if #stderr > 0 then
		if #output_text == 0 then
			output_text = output_text .. stderr
		else
			output_text = output_text .. '\n' .. stderr
		end
	end

	if #output_text == 0 then
		if not successful then
			vim.notify('exitcode: ' .. output.code, vim.log.levels.ERROR)
		end
		return
	end

	local lines = output_text:split('\n')

	if #lines == 1 then
		vim.notify(unpack(lines), successful and vim.log.levels.OFF or vim.log.levels.ERROR)
		return
	end

	vim.cmd('new')
	env.set_lines(lines)
end

---@alias InputCompletion
---| nil
---| 'arglist' file names in argument list
---| 'augroup' autocmd groups
---| 'buffer' buffer names
---| 'behave' :behave suboptions
---| 'color' color schemes
---| 'command' Ex command (and arguments)
---| 'compiler' compilers
---| 'dir' directory names
---| 'environment' environment variable names
---| 'event' autocommand events
---| 'expression' Vim expression
---| 'file' file and directory names
---| 'file_in_path' file and directory names in |'path'|
---| 'filetype' filetype names |'filetype'|
---| 'function' function name
---| 'help' help subjects
---| 'highlight' highlight groups
---| 'history' :history suboptions
---| 'keymap' keyboard mappings
---| 'locale' locale names (as output of locale -a)
---| 'lua' Lua expression |:lua|
---| 'mapclear' buffer argument
---| 'mapping' mapping name
---| 'menu' menus
---| 'messages' |:messages| suboptions
---| 'option' options
---| 'packadd' optional package |pack-add| names
---| 'shellcmd' Shell command
---| 'sign' |:sign| suboptions
---| 'syntax' syntax file names |'syntax'|
---| 'syntime' |:syntime| suboptions
---| 'tag' tags
---| 'tag_listfiles' tags, file names are shown when CTRL-D is hit
---| 'user' user names
---| 'var' user variables
---| 'custom' {func} custom completion, defined via {func}
---| 'customlist' {func} custom completion, defined via {func}

---@param prompt string|[string, string]|nil
---@param default string?
---@param completion InputCompletion?
---@return string|nil
function env.input(prompt, default, completion)
	local specified_highlight = type(prompt) == 'table'
	local prompt_text = prompt
	if specified_highlight then
		---@cast prompt -?
		prompt_text = prompt[1]
		vim.cmd.echohl(prompt[2])
	end
	local output =
		vim.fn.input({ prompt = prompt_text, default = default, cancelreturn = '\127', completion = completion })
	if specified_highlight then vim.cmd.echohl('None') end
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

---@param text string|string[]
---@param start integer? 0 if nil
---@param finish integer? last line in the file if nil. which only works if bufnr is also current buffer.
---@param bufnr integer? 0 if nil
function env.set_lines(text, start, finish, bufnr)
	if type(text) == 'string' then text = text:split('\n') end
	vim.api.nvim_buf_set_lines(bufnr or 0, start or 0, finish or vim.fn.line('$'), false, text)
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
	return spec and require('lazy.core.plugin').values(spec, 'opts') or {}
end

---Check if a plugin is avaiable.
function env.plugalid(plugin) return env.plugetspec(plugin) ~= nil end

---A safe `require` that silently fails instead of yelling at you.
---@param requiree string Module to require.
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

---Check if a buffer is valid
---@param bufnr integer? The buffer to check, default to current buffer
---@return boolean
function env.is_valid(bufnr)
	if not bufnr then bufnr = 0 end
	return bufnr ~= -1 and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts vim.keymap.set.Opts?
function env.map(mode, lhs, rhs, opts)
	if type(mode) == 'string' and #mode > 1 then mode = mode:split('\\zs') end
	vim.keymap.set(mode, lhs, rhs, opts)
end

---Makes a buffer-local mapping.
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts vim.keymap.set.Opts?
function env.bmap(mode, lhs, rhs, opts)
	local opts = opts or {}
	opts.buffer = true
	env.map(mode, lhs, rhs, opts)
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

local highlights = {}

---Get a cached or create a new highlight group
---@param highlight table
function env.high(highlight)
	if highlight.link then return highlight.link end
	local name = ''
	if highlight.fg then name = name .. highlight.fg:sub(2, -1) .. '_' end
	if highlight.bg then name = name .. 'bg_' .. highlight.bg:sub(2, -1) .. '_' end
	if highlight.sp then name = name .. 'sp_' .. highlight.sp:sub(2, -1) .. '_' end
	if highlight.blend then name = name .. 'Blend' .. highlight.blend end
	if highlight.bold then name = name .. 'Bold' end
	if highlight.standout then name = name .. 'Standout' end
	if highlight.underline then name = name .. 'Underline' end
	if highlight.undercurl then name = name .. 'Undercurl' end
	if highlight.underdouble then name = name .. 'Underdouble' end
	if highlight.underdotted then name = name .. 'Underdotted' end
	if highlight.underdashed then name = name .. 'Underdashed' end
	if highlight.strikethrough then name = name .. 'Strikethough' end
	if highlight.italic then name = name .. 'Italic' end
	if highlight.reverse then name = name .. 'Reverse' end
	if highlight.nocombine then name = name .. 'Nocombine' end
	if highlights[name] then
		return name
	else
		highlights[name] = true
	end
	highlight.force = true
	vim.api.nvim_set_hl(0, name, highlight)
	return name
end

function env.set_high(name, highlight) vim.api.nvim_set_hl(0, name, { link = env.high(highlight) }) end
