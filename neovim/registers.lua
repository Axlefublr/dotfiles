local small_substitute_doesnt_consume_register = '"_s'
Map("", "s", small_substitute_doesnt_consume_register)

local big_substitute_doesnt_consume_register = '"_S'
Map("", "S", big_substitute_doesnt_consume_register)

local system_clipboard_register = '"+'
Map("", "'q", system_clipboard_register)

local yanked_register = '"0'
Map("", "'w", yanked_register)

local black_hole_register = '"_'
Map("", "'i", black_hole_register)

local command_register = '":'
Map("", "';", command_register)

local paste_system_register = "<C-r><C-p>+"
Map("!", "<C-v>", paste_system_register)

local paste_yank_register = "<C-r><C-p>0"
Map("!", "<C-r>w", paste_yank_register)

local paste_command_register = "<C-r><C-p>:"
Map("!", "<C-r>;", paste_command_register)

local paste_default_register = '<C-r><C-p>"'
Map("!", "<C-b>", paste_default_register)

local delete_line_but_take_inside_line = 'dil\'_dd'
Map("n", "<leader>dl", delete_line_but_take_inside_line, { remap = true })
