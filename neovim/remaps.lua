local function close_without_saving() vim.cmd('q!') end
local function trim_trailing_whitespace() pcall(vim.cmd, '%s`\\v\\s+$') end
local function write() pcall(vim.cmd, 'write') end
function Write_if_modified()
	if vim.bo.modified then write() end
end

local function save()
	trim_trailing_whitespace()
	Remove_highlighting()
	Write_if_modified()
	require('lualine').refresh()
end
local function close_try_save()
	Write_if_modified()
	close_without_saving()
end
vim.keymap.set('', '<Space>', save)
vim.keymap.set('i', '<f1>', close_try_save) -- f1 ends up being alt+enter for me
vim.keymap.set('n', ',K', close_without_saving)
vim.keymap.set('n', 'K', close_try_save)

local function curr_buff_full_path() return vim.api.nvim_buf_get_name(0) end

vim.keymap.set({ 'n', 'x' }, ',dq', function()
	local full_path = curr_buff_full_path()
	vim.fn.setreg('+', full_path)
	print('copied: ' .. full_path)
end)
vim.keymap.set({ 'n', 'x' }, ',dw', function()
	local file_name = vim.fn.expand('%:t')
	vim.fn.setreg('+', file_name)
	print('copied: ' .. file_name)
end)
vim.keymap.set({ 'n', 'x' }, ',dr', function()
	local relative_path = vim.fn.expand('%:p:.')
	vim.fn.setreg('+', relative_path)
	print('copied: ' .. relative_path)
end)
vim.keymap.set({ 'n', 'x' }, ',de', function()
	local full_path = vim.api.nvim_buf_get_name(0)
	local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
	local relative_path = string.gsub(full_path, '^' .. git_root .. '/', '')
	vim.fn.setreg('+', relative_path)
	print('copied: ' .. relative_path)
end)

vim.keymap.set({ 'n', 'x' }, 'gs', '=')
vim.keymap.set('n', 'gss', '==')

vim.keymap.set('', 'U', '@@')
vim.keymap.set('', '!', ':r !')
vim.keymap.set('', '!!', ':!')
vim.keymap.set('', '<cr>', ':')
vim.keymap.set({ 'n', 'x', 'o' }, "'", '"')
vim.keymap.set('', ':', ',')
vim.keymap.set('', ',s', '/\\V')
vim.keymap.set('', ',S', '?\\V')
vim.keymap.set('', '/', '/\\v')
vim.keymap.set('', '?', '?\\v')
vim.keymap.set('', 'zp', ']p')
vim.keymap.set('', 'zP', ']P')
vim.keymap.set('', 'gM', 'M')
vim.keymap.set('', 'zn', 'q')
vim.keymap.set('', 'zm', '@')
vim.keymap.set('', '_', function() FeedKeysInt(vim.v.count1 .. 'k$') end)
vim.keymap.set('', 'gm', function() FeedKeys(vim.v.count * 10 .. 'gM') end) -- cuts down precision of gM to 10s
vim.keymap.set('', ',v', '<c-v>')

vim.keymap.set('', 'H', function() vim.cmd.normal(Get_vertical_line_diff(true) .. 'k') end)
vim.keymap.set('', 'L', function() vim.cmd.normal(Get_vertical_line_diff(false) .. 'j') end)

vim.keymap.set({ 'n', 'x' }, '<A-/>', '<c-^>')

vim.keymap.set('x', 'u', '<Esc>u')
vim.keymap.set('x', '&', ':s`\\V')
vim.keymap.set('x', '@@', function() FeedKeysInt('ygv<Esc>' .. vim.v.count1 .. 'p') end) -- multiply selection

vim.keymap.set('i', '<a-,>', '<c-d>')
vim.keymap.set('i', '<a-.>', '<c-t>')
vim.keymap.set('i', '<c-l>', '<C-x><C-l>')
vim.keymap.set('i', '<C-k>', '<C-o>O')
-- vim.keymap.set('i', '<C-j>', '<C-o>o')
vim.keymap.set('i', '<C-h>', '<C-o>"_S<Esc><C-o>gI<BS>') -- Delete from the current position to the last character on the previous line

vim.keymap.set('o', '{', 'V{')
vim.keymap.set('o', '}', 'V}')
vim.keymap.set('o', '+', 'v+')
vim.keymap.set('o', '-', 'v-')

vim.keymap.set('n', 'm', '`')
vim.keymap.set('n', ',m', 'm')
vim.keymap.set('n', '<C-k>', 'O<Esc>')
vim.keymap.set('n', '<C-j>', 'o<Esc>')
vim.keymap.set('n', 'gK', 'K')
vim.keymap.set('n', 'Y', 'yg_')
vim.keymap.set('n', '~', 'g~l')
vim.keymap.set('n', 'dp', 'ddp')
vim.keymap.set('n', 'dP', 'ddkP')
vim.keymap.set('n', 'yp', 'yyp')
vim.keymap.set('n', 'yP', 'yyP')
vim.keymap.set('n', '&', ':%s`\\V')
vim.keymap.set('n', 'gy', '<cmd>%y+<cr>')
vim.keymap.set('n', ',g', Move_default_to_other)
vim.keymap.set('n', '*', function() Search_for_current_word('/', '') end)
vim.keymap.set('n', ',*', function() Search_for_current_word('/', '/e') end)
vim.keymap.set('n', '#', function() Search_for_current_word('?', '') end)
vim.keymap.set('n', ',#', function() Search_for_current_word('?', '?e') end)

vim.keymap.set('n', ',aw', '<c-w>v')
vim.keymap.set('n', ',ae', '<c-w>s')
vim.keymap.set('n', ',a,', function() vim.cmd('vnew') end)
vim.keymap.set('n', ',a.', '<c-w>n')
vim.keymap.set('n', ',a;', '<c-w>o')
vim.keymap.set('n', ',aj', '<c-w>j')
vim.keymap.set('n', ',ak', '<c-w>k')
vim.keymap.set('n', ',ah', '<c-w>h')
vim.keymap.set('n', ',al', '<c-w>l')
vim.keymap.set('n', ',af', '<c-w>J')
vim.keymap.set('n', ',ad', '<c-w>K')
vim.keymap.set('n', ',as', '<c-w>H')
vim.keymap.set('n', ',ag', '<c-w>L')
vim.keymap.set('n', ',au', '<c-w>t')
vim.keymap.set('n', ',ao', '<c-w>b')
vim.keymap.set('n', ',aU', '<c-w>t<c-w>|<c-w>_')
vim.keymap.set('n', ',aO', '<c-w>b<c-w>|<c-w>_')
vim.keymap.set('n', ',a/', '<c-w>p')
vim.keymap.set('n', ',ay', '<c-w>^')
vim.keymap.set('n', ',at', '<cmd>exe "vertical normal \\<c-w>^"<cr>')
vim.keymap.set('n', ',ar', '<c-w>r')
vim.keymap.set('n', ',aR', '<c-w>R')
vim.keymap.set('n', ',ax', '<c-w>x')
vim.keymap.set('n', ',ai', '<c-w>=')
vim.keymap.set('n', '<a-h>', '<c-w><')
vim.keymap.set('n', '<a-l>', '<c-w>>')
vim.keymap.set('n', '<c-n>', '<c-w>-')
vim.keymap.set('n', '<c-p>', '<c-w>+')
vim.keymap.set('n', ',aH', '<c-w>h<c-w>|')
vim.keymap.set('n', ',aJ', '<c-w>j<c-w>_')
vim.keymap.set('n', ',aK', '<c-w>k<c-w>_')
vim.keymap.set('n', ',aL', '<c-w>l<c-w>|')
vim.keymap.set('n', ',av', '<c-w>|')
vim.keymap.set('n', ',ac', '<c-w>_')
vim.keymap.set('n', ',aq', '<cmd>enew<cr>')

vim.keymap.set('n', '[w', '<cmd>cprev<cr>')
vim.keymap.set('n', ']w', '<cmd>cnext<cr>')
vim.keymap.set('n', ',an', function() vim.cmd(vim.v.count1 .. 'cc') end)

local function move_to_blank_line(to_next)
	local search_opts = to_next and '' or 'b'
	vim.fn.search('^\\s*$', search_opts)
end
vim.keymap.set('n', '{', function() move_to_blank_line(false) end)
vim.keymap.set('n', '}', function() move_to_blank_line(true) end)
vim.keymap.set({ 'n', 'x' }, ',dc', '<cmd>echo getcwd()<cr>')
vim.keymap.set('n', 'gJ', 'j0d^kgJ')                                              -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
vim.keymap.set('n', ',di', '"_ddddpvaB<Esc>>iB')                                  -- Push line of code after block into block
vim.keymap.set('n', ',du', 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK)   -- Move line to the top
vim.keymap.set('n', ',do', 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK)    -- Bottom
vim.keymap.set('n', ',p', 'Pv`[o`]do<c-r><c-p>"<esc>')                            -- Paste a characterwise register on a new line
vim.keymap.set('n', ',P', 'Pv`[o`]dO<c-r><c-p>"<esc>')                            -- Paste a characterwise register on a new line
vim.keymap.set('n', '@', function() FeedKeysInt('yl' .. vim.v.count1 .. 'p') end) -- multiply character
vim.keymap.set('n', '<Esc>', function()
	Remove_highlighting()
	FeedKeysInt('<Esc>')
end)
vim.keymap.set('n', 'J', function()
	for _ = 1, vim.v.count1 do
		FeedKeys('J')
	end
end)
vim.keymap.set('n', '.', function()
	for _ = 1, vim.v.count1 do
		FeedKeys('.')
	end
end)
vim.keymap.set('n', 'du', function()
	for _ = 1, vim.v.count1 do
		FeedKeys('dd')
	end
end)

-- registers

vim.keymap.set('', 'm[', '`[')
vim.keymap.set('', 'm]', '`]')
vim.keymap.set('', 'm.', '`>')
vim.keymap.set('', 'm,', '`<')
vim.keymap.set('', 'm/', '`^')
vim.keymap.set('', 'M', '``')

vim.keymap.set({ 'n', 'x', 'o' }, "'q", '"+')
vim.keymap.set({ 'n', 'x', 'o' }, "'w", '"0')
vim.keymap.set({ 'n', 'x', 'o' }, "'a", '"_')
vim.keymap.set({ 'n', 'x', 'o' }, "';", '":')

vim.keymap.set('i', "<a-'>", '<C-r><C-p>')
vim.keymap.set('i', '<c-v>', '<C-r><C-p>+')
vim.keymap.set('i', "<a-'>q", '<C-r><C-p>+')
vim.keymap.set('i', "<a-'>w", '<C-r><C-p>0')
vim.keymap.set('i', "<a-'>'", '<C-r><C-p>"')
vim.keymap.set('i', "<a-'><cr>", '<C-r><C-p>:')

vim.keymap.set('c', "<a-'>", '<C-r>')
vim.keymap.set('c', '<c-v>', '<C-r>+')
vim.keymap.set('c', "<a-'>q", '<C-r>+')
vim.keymap.set('c', "<a-'>w", '<C-r>0')
vim.keymap.set('c', "<a-'>'", '<C-r>"')
vim.keymap.set('c', "<a-'><cr>", '<C-r>:')

-- text objects

-- Percent sign %
vim.keymap.set('x', 'i%', 'T%ot%')
vim.keymap.set('x', 'a%', 'F%of%')
vim.keymap.set('o', 'i%', function() vim.cmd('normal vT%ot%') end)
vim.keymap.set('o', 'a%', function() vim.cmd('normal vF%of%') end)

-- Exclusive previous / next blank line
vim.keymap.set({ 'n', 'x' }, ']}', '}k')
vim.keymap.set({ 'n', 'x' }, '[{', '{j')
vim.keymap.set('o', ']}', function() vim.cmd('normal V}k') end)
vim.keymap.set('o', '[{', function() vim.cmd('normal V{j') end)

-- big

vim.keymap.set({ 'n', 'x' }, "'1", function() Numbered_get(1) end)
vim.keymap.set({ 'n', 'x' }, "'2", function() Numbered_get(2) end)
vim.keymap.set({ 'n', 'x' }, "'3", function() Numbered_get(3) end)
vim.keymap.set({ 'n', 'x' }, "'4", function() Numbered_get(4) end)
vim.keymap.set({ 'n', 'x' }, "'5", function() Numbered_get(5) end)
vim.keymap.set({ 'n', 'x' }, "'6", function() Numbered_get(6) end)
vim.keymap.set({ 'n', 'x' }, "'7", function() Numbered_get(7) end)
vim.keymap.set({ 'n', 'x' }, "'8", function() Numbered_get(8) end)
vim.keymap.set({ 'n', 'x' }, "'9", function() Numbered_get(9) end)
vim.keymap.set({ 'n', 'x' }, "'0", function() Numbered_get(10) end)

vim.keymap.set({ 'n', 'x' }, ',1', function() Numbered_set(1) end)
vim.keymap.set({ 'n', 'x' }, ',2', function() Numbered_set(2) end)
vim.keymap.set({ 'n', 'x' }, ',3', function() Numbered_set(3) end)
vim.keymap.set({ 'n', 'x' }, ',4', function() Numbered_set(4) end)
vim.keymap.set({ 'n', 'x' }, ',5', function() Numbered_set(5) end)
vim.keymap.set({ 'n', 'x' }, ',6', function() Numbered_set(6) end)
vim.keymap.set({ 'n', 'x' }, ',7', function() Numbered_set(7) end)
vim.keymap.set({ 'n', 'x' }, ',8', function() Numbered_set(8) end)
vim.keymap.set({ 'n', 'x' }, ',9', function() Numbered_set(9) end)
vim.keymap.set({ 'n', 'x' }, ',0', function() Numbered_set(10) end)

local function Numbered_insert(index) Numbered_get(index, true) end
local function Numbered_command(index) Numbered_get(index, 'command') end

vim.keymap.set('i', "<a-'>1", function() Numbered_insert(1) end)
vim.keymap.set('i', "<a-'>2", function() Numbered_insert(2) end)
vim.keymap.set('i', "<a-'>3", function() Numbered_insert(3) end)
vim.keymap.set('i', "<a-'>4", function() Numbered_insert(4) end)
vim.keymap.set('i', "<a-'>5", function() Numbered_insert(5) end)
vim.keymap.set('i', "<a-'>6", function() Numbered_insert(6) end)
vim.keymap.set('i', "<a-'>7", function() Numbered_insert(7) end)
vim.keymap.set('i', "<a-'>8", function() Numbered_insert(8) end)
vim.keymap.set('i', "<a-'>9", function() Numbered_insert(9) end)
vim.keymap.set('i', "<a-'>0", function() Numbered_insert(10) end)

vim.keymap.set('c', "<a-'>1", function() Numbered_command(1) end)
vim.keymap.set('c', "<a-'>2", function() Numbered_command(2) end)
vim.keymap.set('c', "<a-'>3", function() Numbered_command(3) end)
vim.keymap.set('c', "<a-'>4", function() Numbered_command(4) end)
vim.keymap.set('c', "<a-'>5", function() Numbered_command(5) end)
vim.keymap.set('c', "<a-'>6", function() Numbered_command(6) end)
vim.keymap.set('c', "<a-'>7", function() Numbered_command(7) end)
vim.keymap.set('c', "<a-'>8", function() Numbered_command(8) end)
vim.keymap.set('c', "<a-'>9", function() Numbered_command(9) end)
vim.keymap.set('c', "<a-'>0", function() Numbered_command(10) end)

vim.keymap.set('', ',f', function() Search_for_register('/', '') end)
vim.keymap.set('', ',F', function() Search_for_register('?', '') end)
vim.keymap.set('', ',,f', function() Search_for_register('/', '/e') end)
vim.keymap.set('', ',,F', function() Search_for_register('?', '?e') end)
vim.keymap.set('x', '*', function() Search_for_selection('/', '') end)
vim.keymap.set('x', ',*', function() Search_for_selection('/', '/e') end)
vim.keymap.set('x', '#', function() Search_for_selection('?', '') end)
vim.keymap.set('x', ',#', function() Search_for_selection('?', '?e') end)

vim.keymap.set('n', "'R", Killring_push_tail)
vim.keymap.set('n', "'r", Killring_push)
vim.keymap.set('n', "'E", Killring_pop_tail)
vim.keymap.set('n', "'e", Killring_pop)
vim.keymap.set('i', "<a-'>E", function() Killring_pop_tail(true) end)
vim.keymap.set('i', "<a-'>e", function() Killring_pop(true) end)
vim.keymap.set('c', "<a-'>E", function() Killring_pop_tail('command') end)
vim.keymap.set('c', "<a-'>e", function() Killring_pop('command') end)
vim.keymap.set({ 'n', 'x' }, "'t", Killring_compile)
vim.keymap.set({ 'n', 'x' }, "'T", Killring_compile_reversed)

vim.keymap.set('n', '"j', '<cmd>edit ~/prog/noties/notes.txt<cr>')
vim.keymap.set('n', '"l', '<cmd>edit ~/prog/noties/temp.txt<cr>')
vim.keymap.set('n', '"k', '<cmd>edit ~/prog/noties/links.jsonc<cr>')
vim.keymap.set('n', '"p', '<cmd>edit ~/prog/noties/wishlist.txt<cr>')
vim.keymap.set('n', '"i', '<cmd>edit ~/prog/noties/info.md<cr>')
vim.keymap.set('n', '"o', '<cmd>edit ~/prog/noties/persistent.txt<cr>')
vim.keymap.set('n', '"u', '<cmd>edit ~/prog/noties/diary.md<cr>')
vim.keymap.set('n', '";', '<cmd>edit ~/prog/noties/thoughts.md<cr>')
vim.keymap.set('n', '"e', '<cmd>cd ~/prog/dotfiles<cr>')
vim.keymap.set('n', '"t', '<cmd>cd ~/prog/noties<cr>')
