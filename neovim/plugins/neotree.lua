return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		cmd = 'Neotree',
		keys = {
			{ ',dt', '<cmd>Neotree toggle<cr>' },
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require('neo-tree').setup({
				sources = {
					'filesystem',
				},
				auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
				close_if_last_window = true,     -- Close Neo-tree if it is the last window left in the tab
				enable_diagnostics = true,
				enable_git_status = true,
				enable_modified_markers = true,                                    -- Show markers for files with unsaved changes.
				enable_opened_markers = true,                                      -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
				enable_refresh_on_write = true,                                    -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
				enable_cursor_hijack = false,                                      -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
				enable_normal_mode_for_inputs = true,                              -- Enable normal mode for input dialogs.
				git_status_async = true,
				hide_root_node = true,                                             -- Hide the root node.
				retain_hidden_root_indent = false,                                 -- IF the root node is hidden, keep the indentation anyhow.
				open_files_in_last_window = true,                                  -- false = open files in top left window
				open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy' }, -- when opening files, do not use windows containing these filetypes or buftypes
				-- popup_border_style is for input and confirmation dialogs.
				-- Configurtaion of floating window is done in the individual source sections.
				-- "NC" is a special style that works well with NormalNC set
				popup_border_style = 'single', -- "double", "none", "rounded", "shadow", "single" or "solid"
				resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
				-- set to -1 to disable the resize timer entirely
				--                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
				sort_case_insensitive = false, -- used when sorting files and directories in the tree
				use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
				use_default_mappings = false,
				default_component_configs = {
					container = {
						enable_character_fade = true,
						width = '100%',
						right_padding = 0,
					},
					diagnostics = {
						symbols = {
							hint = '󰌶',
							info = '?',
							warn = '󰀪 ',
							error = '󰅚 ',
						},
						highlights = {
							hint = 'DiagnosticSignHint',
							info = 'DiagnosticSignInfo',
							warn = 'DiagnosticSignWarn',
							error = 'DiagnosticSignError',
						},
					},
					indent = {
						indent_size = 2,
						padding = 1,
					},
					modified = {
						symbol = '!!!',
					},
					name = {
						trailing_slash = false,
						highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
						use_git_status_colors = true,
					},
					git_status = {
						symbols = {
							-- Change type
							added = '',
							modified = '',
							-- Status type
							untracked = '',
							ignored = '',
							unstaged = '󰄱',
							staged = '',
							conflict = '',
						},
					},
					-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
					file_size = {
						enabled = true,
					},
					type = {
						enabled = false,
					},
					last_modified = {
						enabled = false,
					},
					created = {
						enabled = false,
					},
					symlink_target = {
						enabled = true,
					},
				},
				window = {  -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
					-- possible options. These can also be functions that return these options.
					position = 'left', -- left, right, top, bottom, float, current
					width = 28,
					popup = { -- settings that apply to float position only
						size = {
							height = '80%',
							width = '50%',
						},
						position = '50%',
					},
					same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
					insert_as = 'child', -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
					-- "child":   Insert nodes as children of the directory under cursor.
					-- "sibling": Insert nodes  as siblings of the directory under cursor.
					-- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
					-- You can also create your own commands by providing a function instead of a string.
					show_path = 'absolute',
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						['l'] = 'open',
						['<esc>'] = 'cancel', -- close preview or floating neo-tree window
						['i'] = {
							'toggle_preview',
							config = { use_float = false, use_image_nvim = false },
						},
						['<a-f>'] = 'open_split',
						['<a-s>'] = 'open_vsplit',
						['<a-d>'] = 'open_tabnew',
						['z'] = 'close_node',
						['Z'] = 'close_all_nodes',
						['R'] = 'refresh',
						['a'] = {
							'add',
							-- some commands may take optional config options, see `:h neo-tree-mappings` for details
							config = {
								show_path = 'absolute', -- "none", "relative", "absolute"
							},
						},
						['d'] = 'delete',
						['r'] = 'rename',
						['y'] = 'copy_to_clipboard',
						['x'] = 'cut_to_clipboard',
						['p'] = 'paste_from_clipboard',
						['c'] = 'copy', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
						['m'] = 'move', -- takes text input for destination, also accepts the config.show_path and config.insert_as options
						['?'] = 'show_help',
					},
				},
				filesystem = {
					window = {
						mappings = {
							['f'] = 'filter_on_submit',

							['F'] = 'clear_filter',
							['q'] = 'navigate_up',
							['.'] = 'set_root',
							['[e'] = 'prev_git_modified',
							[']e'] = 'next_git_modified',
							-- ['i'] = 'show_file_details',
							['o'] = {
								'show_help',
								nowait = false,
								config = { title = 'Order by', prefix_key = 'o' },
							},
							['oc'] = { 'order_by_created', nowait = false },
							['od'] = { 'order_by_diagnostics', nowait = false },
							['og'] = { 'order_by_git_status', nowait = false },
							['om'] = { 'order_by_modified', nowait = false },
							['on'] = { 'order_by_name', nowait = false },
							['os'] = { 'order_by_size', nowait = false },
							['ot'] = { 'order_by_type', nowait = false },
						},
					},
					scan_mode = 'shallow',  -- "shallow": Don't scan into directories to detect possible empty directory a priori
					-- "deep": Scan into directories to detect empty or grouped empty directories a priori.
					bind_to_cwd = true,     -- true creates a 2-way binding between vim's cwd and neo-tree's root
					cwd_target = {
						sidebar = 'tab',     -- sidebar is when position = left or right
						current = 'window',  -- current is when position = current
					},
					check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
					-- setting this to false will speed up searches, but gitignored
					-- items won't be marked if they are visible.
					-- The renderer section provides the renderers that will be used to render the tree.
					--   The first level is the node type.
					--   For each node type, you can specify a list of components to render.
					--       Components are rendered in the order they are specified.
					--         The first field in each component is the name of the function to call.
					--         The rest of the fields are passed to the function as the "config" argument.
					filtered_items = {
						visible = true,           -- when true, they will just be displayed differently than normal items
						force_visible_in_empty_folder = true, -- when true, hidden files will be shown if the root folder is otherwise empty
						show_hidden_count = false, -- when true, the number of hidden items in each folder will be shown as the last entry
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					find_by_full_path_words = true, -- `false` means it only searches the tail of a path.
					find_args = {         -- you can specify extra args to pass to the find command.
						fd = {
							'--exclude',
							'.git',
							'--exclude',
							'node_modules',
							'--hidden',
						},
					},
					group_empty_dirs = true,      -- when true, empty folders will be grouped together
					search_limit = 50,            -- max number of search results when using filters
					follow_current_file = {
						enabled = false,           -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false,   -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
					-- in whatever position is specified in window.position
					-- "open_current",-- netrw disabled, opening a directory opens within the
					-- window like netrw would, regardless of window.position
					-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
					use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
					-- instead of relying on nvim autocmd events.
				},
			})
		end,
	},
}
