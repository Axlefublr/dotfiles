vim.keymap.set('', 'L', Move_to_bottom_screen__center_screen)
vim.keymap.set('', 'H', Move_to_top_screen__center_screen)
vim.keymap.set('', '<Space>', Trim__save__no_highlight)
vim.keymap.set('', 'U', Trim__save__format)

vim.keymap.set('n', 'gD', Reveal_definition_aside)
vim.keymap.set('n', 'gt', Go_to_implementation)
vim.keymap.set('n', 'gq', Go_to_reference)
vim.keymap.set('n', ',r', Rename_symbol)
vim.keymap.set('n', '<<', Outdent)
vim.keymap.set('n', '>>', Indent)
vim.keymap.set('n', 'gcc', Comment)
vim.keymap.set('n', '=s', Convert_to_spaces)
vim.keymap.set('n', '=t', Convert_to_tabs)
vim.keymap.set('n', '=d', Indent_with_spaces)
vim.keymap.set('n', '=g', Indent_with_tabs)
vim.keymap.set('n', 'K', CloseEditor)
vim.keymap.set('n', ',K', UndoCloseEditor)
vim.keymap.set('n', 'zk', Git_stage_file)
vim.keymap.set('n', 'zK', Git_unstage_file)
vim.keymap.set('n', 'zi', Git_open_changes)
vim.keymap.set('n', 'zI', Git_open_all_changes)
vim.keymap.set('n', 'zy', Toggle_breakpoint)
vim.keymap.set('n', 'yr', Copy_relative_path)
vim.keymap.set('n', 'yR', Copy_path)

vim.keymap.set('v', 'gs', Codesnap)
vim.keymap.set('v', '<', Outdent_vis)
vim.keymap.set('v', '>', Indent_vis)
vim.keymap.set('v', 'gc', Comment_vis)

vim.keymap.set({ 'n', 'v' }, 'zJ', Git_revert_change)
vim.keymap.set({ 'n', 'v' }, 'zj', Git_stage_change)
-- vim.keymap.set({ 'n', 'v' }, 'zt', Vscode_ctrl_d)
-- vim.keymap.set({ 'n', 'v' }, 'zb', Vscode_ctrl_u)

vim.keymap.set('', ',K', 'ZQ', { remap = true })