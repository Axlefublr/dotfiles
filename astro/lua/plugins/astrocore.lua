local killring = setmetatable({}, { __index = table })
local numbered = { '', '', '', '', '', '', '', '', '', '' }

local function trim_trailing_whitespace()
	local search = vim.fn.getreg('/')
	---@diagnostic disable-next-line: param-type-mismatch
	pcall(vim.cmd, '%s`\\v\\s+$')
	vim.fn.setreg('/', search)
end

local function save()
	trim_trailing_whitespace()
	vim.cmd('nohl')
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.bo.modified then pcall(vim.cmd, 'write') end
end

local function close_try_save()
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.bo.modified then pcall(vim.cmd, 'write') end
	vim.cmd('q!')
end

local function move_to_blank_line(to_next)
	local search_opts = to_next and '' or 'b'
	vim.fn.search('^\\s*$', search_opts)
end

local function edit_magazine()
	local register = Get_char('magazine: ')
	if register == nil then return end
	vim.cmd('edit ' .. vim.fn.expand('~/.local/share/magazine/') .. register)
	print('shoot ' .. register)
end

local function copy_full_path()
	local full_path = vim.api.nvim_buf_get_name(0)
	local home = os.getenv('HOME')
	if not home then return end
	local friendly_path = string.gsub(full_path, home, '~')
	vim.fn.setreg('+', friendly_path)
	vim.notify('full path: ' .. friendly_path)
end

local function copy_file_name()
	local file_name = vim.fn.expand('%:t')
	vim.fn.setreg('+', file_name)
	vim.notify('name: ' .. file_name)
end

local function copy_cwd_relative()
	local relative_path = vim.fn.expand('%:p:.')
	vim.fn.setreg('+', relative_path)
	vim.notify('cwd relative: ' .. relative_path)
end

local function copy_git_relative()
	local full_path = vim.api.nvim_buf_get_name(0)
	local git_root = Get_repo_root()
	local relative_path = string.gsub(full_path, '^' .. git_root .. '/', '')
	vim.fn.setreg('+', relative_path)
	vim.notify('repo relative: ' .. relative_path)
end

local function copy_cwd()
	local cwd = vim.fn.getcwd()
	cwd = vim.fn.fnamemodify(cwd, ':~')
	vim.fn.setreg('+', cwd)
	vim.notify('cwd: ' .. cwd)
end

local function another_quickfix_entry(to_next, buffer)
	local qflist = vim.fn.getqflist()
	if #qflist == 0 then
		print('quickfix list is empty')
		return
	end

	if vim.v.count > 0 then
		vim.cmd('cc ' .. vim.v.count)
		return
	end

	local qflist_index = vim.fn.getqflist({ idx = 0 }).idx
	local current_buffer = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	if qflist_index == 1 and (qflist[1].bufnr ~= current_buffer or qflist[1].lnum ~= current_line) then -- If you do have a quickfix list, the first index is automatically selected, meaning that the first time you try to `cnext`, you go to the second quickfix entry, even though you have never actually visited the first one. This is what I mean when I say vim has a bad foundation and is terrible to build upon. We need a modal editor with a better foundation, with no strange behavior like this!
		vim.cmd('cfirst')
		return
	end

	local status = true
	if to_next then
		if buffer then
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cnfile')
		else
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cnext')
		end
		if not status then vim.cmd('cfirst') end
	else
		if buffer then
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cpfile')
		else
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cprev')
		end
		if not status then vim.cmd('clast') end
	end
end

function killring_push_tail()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(1, register_contents)
	vim.notify('pushed')
end

function killring_push()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(register_contents)
	vim.notify('pushed')
end

function killring_pop_tail(insert)
	if #killring <= 0 then
		vim.notify('killring empty')
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg('"', first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>"')
		else
			FeedKeysInt('<C-r><C-p>"')
		end
	end
	vim.notify('got tail')
end

function killring_pop(insert)
	if #killring <= 0 then
		vim.notify('killring empty')
		return
	end
	local first_index = killring:remove(#killring)
	vim.fn.setreg('"', first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>"')
		else
			FeedKeysInt('<C-r><C-p>"')
		end
	end
	vim.notify('got nose')
end

function killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled')
end

function killring_compile_reversed()
	local reversed_killring = ReverseTable(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled in reverse')
end

function search_for_register(direction, death)
	local char = Get_char('register: ')
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(direction .. '\\V' .. escaped_register .. death)
	FeedKeysInt('<cr>')
end

local function numbered_set(index)
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		vim.notify('default register empty')
		return
	end
	numbered[index] = register_contents
	vim.notify('stabbed')
end

local function numbered_get(index, insert)
	if numbered[index] == '' then
		vim.notify(index .. ' is empty')
		return
	end
	vim.fn.setreg('"', numbered[index])
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>"')
		else
			FeedKeysInt('<C-r><C-p>"')
		end
	end
	vim.notify('grabbed')
end

local function numbered_insert(index) numbered_get(index, true) end
local function numbered_command(index) numbered_get(index, 'command') end

-- I call it death because that's where we end up in. Just like /e or no /e
local function search_for_selection(direction, death)
	local default = vim.fn.getreg('"')
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
		vim.fn.setreg('"', default)
	end)
end

local function ensure_dir_exists(path)
	local stat = vim.loop.fs_stat(path)
	if not stat then
		vim.loop.fs_mkdir(path, 511) -- 511 corresponds to octal 0777
	elseif stat.type ~= 'directory' then
		error(path .. ' is not a directory')
	end
end

local function harp_get(edit_command)
	local dir = vim.fn.expand('~/.local/share/harp')
	ensure_dir_exists(dir)
	local register = Get_char('harp: ')
	if register == nil then return end
	local file = io.open(dir .. '/' .. register, 'r')
	if file then
		local output = file:read('l')
		if #output > 0 then
			vim.cmd((edit_command or 'edit') .. ' ' .. output)
		else
			vim.notify(register .. ' is empty')
		end
		file:close()
	else
		vim.notify(register .. ' is empty')
	end
end

local function harp_set()
	local dir = vim.fn.expand('~/.local/share/harp')
	ensure_dir_exists(dir)
	local register = Get_char('harp: ')
	if register == nil then return end
	local full_path = vim.api.nvim_buf_get_name(0)
	local file = io.open(dir .. '/' .. register, 'w')
	if file then
		file:write(full_path)
		file:close()
		vim.notify('set harp ' .. register)
	end
end

local function move_default_to_other()
	local char = Get_char('register: ')
	if not char then return end
	local register = Validate_register(char)
	local default_contents = vim.fn.getreg('"')
	vim.fn.setreg(register, default_contents)
end

local function search_for_current_word(direction, death)
	local register = vim.fn.getreg('"')
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V\\C' .. escaped_word .. death)
		FeedKeysInt('<cr>')
		vim.fn.setreg('"', register)
	end)
end

local normal_mappings = {
	['<Leader>dq'] = { copy_full_path },
	['<Leader>dw'] = { copy_file_name },
	['<Leader>dr'] = { copy_cwd_relative },
	['<Leader>de'] = { copy_git_relative },
	['<Space>'] = { save },
	['"'] = { edit_magazine },
	["'R"] = { killring_push_tail },
	["'r"] = { killring_push },
	["'E"] = { killring_pop_tail },
	["'e"] = { killring_pop },
	["'t"] = { killring_compile },
	["'T"] = { killring_compile_reversed },
	[',S'] = { harp_set },
	[',s'] = { harp_get },
	K = { close_try_save },
	['<Leader>lD'] = { vim.lsp.buf.declaration },
	['<Leader>lr'] = { vim.lsp.buf.rename },
	['<Leader>K'] = { function() vim.cmd('q!') end },
	['""d'] = { function() vim.cmd('tcd ~/prog/dotfiles') end },
	['""t'] = { function() vim.cmd('tcd ~/prog/noties') end },
	['""b'] = { function() vim.cmd('tcd ~/prog/backup') end },
	['""c'] = { function() vim.cmd('tcd ~/.local/share/nvim/lazy/astrocommunity') end },
	['""u'] = { function() vim.cmd('tcd ~/.local/share/nvim/lazy/astroui') end },
	['""a'] = { function() vim.cmd('tcd ~/.local/share/nvim/lazy/AstroNvim') end },
	['""e'] = { function() vim.cmd('tcd ~/prog/other/astrotemplate') end },
	['<Leader>dm'] = { function() vim.cmd('messages') end },
	gy = { function() vim.cmd('%y+') end },
	['<Leader>g'] = { move_default_to_other },
	['*'] = { function() search_for_current_word('/', '') end },
	['<Leader>*'] = { function() search_for_current_word('/', '/e') end },
	['#'] = { function() search_for_current_word('?', '') end },
	['<Leader>#'] = { function() search_for_current_word('?', '?e') end },
	['{'] = { function() move_to_blank_line(false) end },
	['}'] = { function() move_to_blank_line(true) end },
	['@'] = { function() FeedKeys('yl' .. vim.v.count1 .. 'p') end },
	['<Leader>ath'] = { function() vim.cmd('leftabove vsplit') end },
	['<Leader>atj'] = { function() vim.cmd('split') end },
	['<Leader>atk'] = { function() vim.cmd('leftabove split') end },
	['<Leader>atl'] = { function() vim.cmd('vsplit') end },
	['<Leader>awh'] = { function() vim.cmd('leftabove vnew') end },
	['<Leader>awj'] = { function() vim.cmd('new') end },
	['<Leader>awk'] = { function() vim.cmd('leftabove new') end },
	['<Leader>awl'] = { function() vim.cmd('vnew') end },
	['<Leader>aww'] = { function() vim.cmd('enew') end },
	['<Leader>a/h'] = { function() vim.cmd('exe "leftabove vertical normal \\<c-w>^"') end },
	['<Leader>a/j'] = { function() vim.cmd('exe "normal \\<c-w>^"') end },
	['<Leader>a/k'] = { function() vim.cmd('exe "leftabove normal \\<c-w>^"') end },
	['<Leader>a/l'] = { function() vim.cmd('exe "vertical normal \\<c-w>^"') end },
	['[q'] = { function() another_quickfix_entry(false, false) end },
	[']q'] = { function() another_quickfix_entry(true, false) end },
	['[Q'] = { function() another_quickfix_entry(false, true) end },
	[']Q'] = { function() another_quickfix_entry(true, true) end },
	["'1"] = { function() numbered_get(1) end },
	["'2"] = { function() numbered_get(2) end },
	["'3"] = { function() numbered_get(3) end },
	["'4"] = { function() numbered_get(4) end },
	["'5"] = { function() numbered_get(5) end },
	["'6"] = { function() numbered_get(6) end },
	["'7"] = { function() numbered_get(7) end },
	["'8"] = { function() numbered_get(8) end },
	["'9"] = { function() numbered_get(9) end },
	["'0"] = { function() numbered_get(10) end },
	['<Leader>1'] = { function() numbered_set(1) end },
	['<Leader>2'] = { function() numbered_set(2) end },
	['<Leader>3'] = { function() numbered_set(3) end },
	['<Leader>4'] = { function() numbered_set(4) end },
	['<Leader>5'] = { function() numbered_set(5) end },
	['<Leader>6'] = { function() numbered_set(6) end },
	['<Leader>7'] = { function() numbered_set(7) end },
	['<Leader>8'] = { function() numbered_set(8) end },
	['<Leader>9'] = { function() numbered_set(9) end },
	['<Leader>0'] = { function() numbered_set(10) end },
	['<Leader>lp'] = { function() vim.cmd('Inspect') end },
	['<Esc>'] = {
		function()
			vim.cmd('noh')
			FeedKeysInt('<Esc>')
		end,
	},
	J = {
		function()
			for _ = 1, vim.v.count1 do
				FeedKeys('J')
			end
		end,
	},
	['.'] = {
		function()
			for _ = 1, vim.v.count1 do
				FeedKeys('.')
			end
		end,
	},
	du = {
		function()
			for _ = 1, vim.v.count1 do
				FeedKeys('dd')
			end
		end,
	},
	['gl'] = {
		function()
			vim.diagnostic.open_float()
			vim.diagnostic.open_float()
		end,
	},
	['[e'] = {
		function()
			for _ = 1, vim.v.count1 do
				vim.diagnostic.goto_prev()
			end
		end,
	},
	[']e'] = {
		function()
			for _ = 1, vim.v.count1 do
				vim.diagnostic.goto_next()
			end
		end,
	},
	['gh'] = {
		function()
			vim.lsp.buf.hover()
			vim.lsp.buf.hover()
		end,
	},
	gss = '==',
	U = '@n',
	zn = 'q',
	zm = '@',
	gK = 'K',
	Y = 'yg_',
	['~'] = 'g~l',
	['<C-k>'] = 'O<Esc>',
	['<F6>'] = 'o<Esc>',
	dp = 'ddp',
	dP = 'ddkP',
	yp = 'yyp',
	yP = 'yyP',
	['&'] = ':%s`\\V',
	gJ = 'j0d^kgJ', -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
	['<Leader>di'] = '"_ddddpvaB<Esc>>iB', -- Push line of code after block into block
	['<Leader>du'] = 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK, -- Move line to the top
	['<Leader>do'] = 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK, -- Bottom
	['<Leader>p'] = 'Pv`[o`]do<c-r><c-p>"<esc>', -- Paste a characterwise register on a new line
	['<Leader>P'] = 'Pv`[o`]dO<c-r><c-p>"<esc>', -- Paste a characterwise register on a new line
	['dr'] = '"' .. THROWAWAY_REGISTER .. 'diWxEp"' .. THROWAWAY_REGISTER .. 'p',
	['<Leader>a1'] = '1<C-w>w',
	['<Leader>a2'] = '2<C-w>w',
	['<Leader>a3'] = '3<C-w>w',
	['<Leader>a4'] = '4<C-w>w',
	['<Leader>a5'] = '5<C-w>w',
	['<Leader>a6'] = '6<C-w>w',
	['<Leader>a7'] = '7<C-w>w',
	['<Leader>a8'] = '8<C-w>w',
	['<Leader>a9'] = '9<C-w>w',
	['<Leader>aj'] = '<C-w>j',
	['<Leader>ak'] = '<C-w>k',
	['<Leader>ah'] = '<C-w>h',
	['<Leader>al'] = '<C-w>l',
	['<Leader>af'] = '<C-w>J',
	['<Leader>ad'] = '<C-w>K',
	['<Leader>as'] = '<C-w>H',
	['<Leader>ag'] = '<C-w>L',
	['<Leader>au'] = '<C-w>t',
	['<Leader>ao'] = '<C-w>b',
	['<A-h>'] = '<C-w><',
	['<A-l>'] = '<C-w>>',
	['<C-n>'] = '<C-w>-',
	['<C-p>'] = '<C-w>+',
	['<Leader>aH'] = '<C-w>h<C-w>|',
	['<Leader>aJ'] = '<C-w>j<C-w>_',
	['<Leader>aL'] = '<C-w>l<C-w>|',
	['<Leader>aK'] = '<C-w>k<C-w>_',
	['<Leader>aU'] = '<C-w>t<C-w>|<C-w>_',
	['<Leader>aO'] = '<C-w>b<C-w>|<C-w>_',
	["<Leader>a'"] = '<C-w>|',
	['<Leader>av'] = '<C-w>_',
	['<Leader>ar'] = '<C-w>r',
	['<Leader>aR'] = '<C-w>R',
	['<Leader>ay'] = '<C-w>x',
	['<Leader>a//'] = '<C-w>p',
	['<Leader>a?'] = '<C-^>',
	['<Leader>a;'] = '<C-w>o',
	['<Leader>ai'] = '<C-w>=',
	[']w'] = 'gt',
	['[w'] = 'gT',
	['<Leader>aP'] = '<Cmd>tabclose<CR>',
	['<Leader>ap'] = '<Cmd>tabnew<CR>',
}

local visual_mappings = {
	['@@'] = { function() FeedKeysInt('ygv<Esc>' .. vim.v.count1 .. 'p') end },
	['*'] = { function() search_for_selection('/', '') end },
	['<Leader>*'] = { function() search_for_selection('/', '/e') end },
	['#'] = { function() search_for_selection('?', '') end },
	['<Leader>#'] = { function() search_for_selection('?', '?e') end },
	['&'] = ':s`\\V',
	['i%'] = 'T%ot%',
	['a%'] = 'F%of%',
	u = '<Esc>u',
}

local insert_mappings = {
	['<A-/>'] = { close_try_save },
	["<A-'>1"] = { function() numbered_insert(1) end },
	["<A-'>2"] = { function() numbered_insert(2) end },
	["<A-'>3"] = { function() numbered_insert(3) end },
	["<A-'>4"] = { function() numbered_insert(4) end },
	["<A-'>5"] = { function() numbered_insert(5) end },
	["<A-'>6"] = { function() numbered_insert(6) end },
	["<A-'>7"] = { function() numbered_insert(7) end },
	["<A-'>8"] = { function() numbered_insert(8) end },
	["<A-'>9"] = { function() numbered_insert(9) end },
	["<A-'>0"] = { function() numbered_insert(10) end },
	["<A-'>E"] = { function() killring_pop_tail(true) end },
	["<A-'>e"] = { function() killring_pop(true) end },
	["<A-'><CR>"] = '<C-r><C-p>:',
	["<A-'>'"] = '<C-r><C-p>"',
	["<A-'>w"] = '<C-r><C-p>0',
	["<A-'>q"] = '<C-r><C-p>+',
	['<C-v>'] = '<C-r><C-p>+',
	["<A-'>"] = '<C-r><C-p>',
	['<A-,>'] = '<C-d>',
	['<A-.>'] = '<C-t>',
	['<C-l>'] = '<C-x><C-l>',
	['<C-k>'] = '<C-o>O',
	['<F6>'] = '<C-o>o',
	['<C-h>'] = '<C-o>"_S<Esc><C-o>gI<BS>', -- Delete from the current position to the last character on the previous line
	['<A-s>'] = '<C-x>',
	['<A-;>'] = '',
	['<F5>'] = '',
	['<A-i>'] = '',
	['<A-o>'] = '',
}

local pending_mappings = {
	['i%'] = { function() vim.cmd('normal vT%ot%') end },
	['a%'] = { function() vim.cmd('normal vF%of%') end },
	[']}'] = { function() vim.cmd('normal V}k') end },
	['[{'] = { function() vim.cmd('normal V{j') end },
	['{'] = 'V{',
	['}'] = 'V}',
	['+'] = 'v+',
	['-'] = 'v-',
}

local command_mappings = {
	["<A-'>1"] = { function() numbered_command(1) end },
	["<A-'>2"] = { function() numbered_command(2) end },
	["<A-'>3"] = { function() numbered_command(3) end },
	["<A-'>4"] = { function() numbered_command(4) end },
	["<A-'>5"] = { function() numbered_command(5) end },
	["<A-'>6"] = { function() numbered_command(6) end },
	["<A-'>7"] = { function() numbered_command(7) end },
	["<A-'>8"] = { function() numbered_command(8) end },
	["<A-'>9"] = { function() numbered_command(9) end },
	["<A-'>0"] = { function() numbered_command(10) end },
	["<A-'>E"] = { function() killring_pop_tail('command') end },
	["<A-'>e"] = { function() killring_pop('command') end },
	["<A-'>"] = '<C-r>',
	['<C-v>'] = '<C-r>+',
	["<A-'>q"] = '<C-r>+',
	["<A-'>w"] = '<C-r>0',
	["<A-'>'"] = '<C-r>"',
	["<A-'><CR>"] = '<C-r>:',
}

local command_insert_mappings = {
	['<A-f>'] = '<C-f>',
}

local normal_visual_pending_mappings = {
	H = { function() vim.cmd.normal(Get_vertical_line_diff(true) .. 'k') end },
	L = { function() vim.cmd.normal(Get_vertical_line_diff(false) .. 'j') end },
	['_'] = { function() FeedKeysInt(vim.v.count1 .. 'k$') end },
	gm = { function() FeedKeys(vim.v.count * 10 .. 'gM') end }, -- cuts down precision of gM to 10s
	['<Leader>f'] = { function() search_for_register('/', '') end },
	['<Leader>F'] = { function() search_for_register('?', '') end },
	['<Leader><Leader>f'] = { function() search_for_register('/', '/e') end },
	['<Leader><Leader>F'] = { function() search_for_register('?', '?e') end },
	m = '`',
	M = '``',
	['<Leader>m'] = 'm',
	['m['] = '`[',
	['m]'] = '`]',
	['m.'] = '`>',
	['m,'] = '`<',
	['m/'] = '`^',
	[':'] = ',',
	['<Leader>/'] = '/\\V',
	['<Leader>?'] = '?\\V',
	['/'] = '/\\v',
	['?'] = '?\\v',
	gM = 'M',
	["'q"] = '"+',
	["'w"] = '"0',
	["'a"] = '"_',
	["';"] = '":',
}

local normal_visual_mappings = {
	['<Leader>lc'] = { vim.lsp.buf.code_action },
	['<Leader>da'] = { copy_cwd },
	['<Leader>lf'] = { function() vim.lsp.buf.format({ async = true }) end },
	['<CR>'] = ':',
	['!'] = ':!',
	['!!'] = ':r !',
	["'"] = '"',
	gs = '=',
	[']}'] = '}k',
	['[{'] = '{j',
}

local insert_select_mappings = {
	['<A-l>'] = { function() require('luasnip').jump(1) end, silent = true },
	['<A-h>'] = { function() require('luasnip').jump(-1) end, silent = true },
}

local normal_insert_select_mappings = {
	['<A-u>'] = { vim.lsp.buf.signature_help },
}

local mappings_table = {
	n = normal_mappings,
	x = visual_mappings,
	i = insert_mappings,
	o = pending_mappings,
	c = command_mappings,
	['!'] = command_insert_mappings,
}

if not mappings_table.s then mappings_table.s = {} end

for key, value in pairs(normal_visual_pending_mappings) do
	mappings_table.n[key] = value
	mappings_table.x[key] = value
	mappings_table.o[key] = value
end

for key, value in pairs(normal_visual_mappings) do
	mappings_table.n[key] = value
	mappings_table.x[key] = value
end

for key, value in pairs(insert_select_mappings) do
	mappings_table.i[key] = value
	mappings_table.s[key] = value
end

for key, value in pairs(normal_insert_select_mappings) do
	mappings_table.n[key] = value
	mappings_table.i[key] = value
	mappings_table.s[key] = value
end

local opts_table = {
	features = {
		large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
		autopairs = true,
		cmp = true,
		diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
		highlighturl = true, -- highlight URLs at start
		notifications = true, -- enable notifications at start
	},
	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		virtual_text = true,
		underline = true,
		signs = false,
	},
	-- vim options can be configured here
	options = {
		opt = {
			relativenumber = true,
			number = false,
			spell = false,
			signcolumn = 'no', -- sets vim.opt.signcolumn to auto
			wrap = true,
			tabstop = 3,
			shiftwidth = 3,
			numberwidth = 3, -- this weirdly means 2
			-- scrolloff = 999,
			expandtab = false,
			smartindent = true,
			mouse = 'a',
			ignorecase = true,
			smartcase = true,
			hlsearch = true,
			colorcolumn = '',
			syntax = 'enable',
			termguicolors = true,
			background = 'dark',
			backup = false,
			writebackup = false,
			swapfile = false,
			undofile = true,
			timeout = false,
			eol = false,
			fixeol = false,
			cpoptions = 'aABceFs',
			splitbelow = true,
			splitright = true,
			virtualedit = 'block',
			inccommand = 'split',
			listchars = 'tab:↦ ,multispace:·',
			list = true,
			shortmess = 'finxtTIoOF',
			-- showtabline = 0,
			fillchars = 'eob: ',
			foldcolumn = '0',
			autowrite = true,
			autowriteall = true,
			cursorline = false,
			cmdwinheight = 1,
			matchpairs = '(:),{:},[:],<:>',
			showbreak = '󱞩 ',
			sidescrolloff = 999,
			clipboard = '',
			wildoptions = 'fuzzy,pum,tagfile',
			langmap = 'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'\\"zZxXcCvVbBnNmM\\,<.>',
		},
		g = {
			rust_recommended_style = true,
		},
	},
	commands = {
		O = {
			function(info)
				local range = ''
				if info.range > 0 then range = (info.line1 or '') .. ',' .. (info.line2 or '') end
				vim.cmd(range .. 'norm ' .. info.args)
			end,
			nargs = '*',
			range = true,
		},
	},
	autocmds = {
		everything = {
			{
				event = 'CursorMoved',
				command = 'normal! zz',
			},
			{
				event = { 'CursorMoved' },
				callback = function() vim.schedule(vim.cmd.redrawtabline) end,
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = '*.XCompose',
				command = 'setfiletype xcompose',
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = '*.rasi',
				command = 'setfiletype rasi',
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = vim.fn.expand('~/.local/share/magazine/l'),
				command = 'setfiletype markdown',
			},
			{
				event = { 'BufLeave', 'FocusLost' },
				callback = function()
					---@diagnostic disable-next-line: param-type-mismatch
					if vim.bo.modified then pcall(vim.cmd, 'write') end
				end,
			},
			{
				event = 'FileType',
				pattern = 'gitcommit',
				command = 'startinsert',
			},
			{
				event = 'FileType',
				pattern = 'fish',
				callback = function()
					vim.opt_local.expandtab = true
					vim.opt_local.shiftwidth = 4
				end,
			},
			{ -- needed to stop `q` from exiting manpages
				event = 'FileType',
				pattern = 'man',
				callback = function()
					vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-forward-to)', { buffer = true })
					vim.keymap.set({ 'n', 'x', 'o' }, 'Q', '<Plug>(leap-backward-to)', { buffer = true })
					vim.keymap.set({ 'n', 'x', 'o' }, ',q', '<Plug>(leap-forward-till)', { buffer = true })
					vim.keymap.set({ 'n', 'x', 'o' }, ',Q', '<Plug>(leap-backward-till)', { buffer = true })
				end,
			},
		},
	},
}

---@type LazySpec
return {
	'AstroNvim/astrocore',
	---@param opts AstroCoreOpts
	opts = function(_, opts)
		opts.mappings = mappings_table
		opts.autocmds.autoview = nil
		opts.autocmds.q_close_windows = nil
		return require('astrocore').extend_tbl(opts, opts_table)
	end,
}
