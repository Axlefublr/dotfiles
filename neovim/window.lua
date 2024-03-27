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

vim.keymap.set('n', '<a-h>', '<c-w><')
vim.keymap.set('n', '<a-l>', '<c-w>>')
vim.keymap.set('n', '<c-n>', '<c-w>-')
vim.keymap.set('n', '<c-p>', '<c-w>+')
vim.keymap.set('n', ',aH', '<c-w>h<c-w>|')
vim.keymap.set('n', ',aJ', '<c-w>j<c-w>_')
vim.keymap.set('n', ',aK', '<c-w>k<c-w>_')
vim.keymap.set('n', ',aL', '<c-w>l<c-w>|')
vim.keymap.set('n', ',aU', '<c-w>t<c-w>|<c-w>_')
vim.keymap.set('n', ',aO', '<c-w>b<c-w>|<c-w>_')

vim.keymap.set('n', ",a'", '<c-w>|')
vim.keymap.set('n', ',av', '<c-w>_')
vim.keymap.set('n', ',ar', '<c-w>r')
vim.keymap.set('n', ',aR', '<c-w>R')
vim.keymap.set('n', ',ax', '<c-w>x')

vim.keymap.set('n', ',atl', '<c-w>v')
vim.keymap.set('n', ',atj', '<c-w>s')

vim.keymap.set('n', ',awl', function() vim.cmd('vnew') end)
vim.keymap.set('n', ',awj', '<c-w>n')
vim.keymap.set('n', ',aww', '<cmd>enew<cr>')

vim.keymap.set('n', ',ael', '<cmd>exe "vertical normal \\<c-w>^"<cr>')
vim.keymap.set('n', ',aej', '<c-w>^')

vim.keymap.set('n', ',a;', '<c-w>o')
vim.keymap.set('n', ',a/', '<c-w>p')
vim.keymap.set('n', ',ai', '<c-w>=')

vim.keymap.set('n', ',ac', 'gt')
vim.keymap.set('n', ',ax', 'gT')
vim.keymap.set('n', ',aP', '<cmd>tabclose<cr>')
vim.keymap.set('n', ',ap', '<cmd>tabnew<cr>')
