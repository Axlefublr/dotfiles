local function center_screen() Cmd("call <SNR>3_reveal('center', 0)") end
Map("", "z,", center_screen)

local function top_screen() Cmd("call <SNR>3_reveal('top', 0)") end
Map("", "zm", top_screen)

local function bottom_screen() Cmd("call <SNR>3_reveal('bottom', 0)") end
Map("", "z.", bottom_screen)

local function move_to_top_screen()
	Cmd("call <SNR>3_moveCursor('top')")
end

local function move_to_bottom_screen()
	Cmd("call <SNR>3_moveCursor('bottom')")
end

local function move_to_bottom_screen__center_screen()
	move_to_bottom_screen()
	center_screen()
end
Map("", "L", move_to_bottom_screen__center_screen)

local function move_to_top_screen__center_screen()
	move_to_top_screen()
	center_screen()
end
Map("", "H", move_to_top_screen__center_screen)

local function trim_trailing_whitespace()
	VSCodeCall("editor.action.trimTrailingWhitespace")
end

local function save() VSCodeCall("workbench.action.files.save") end

local function save_no_format()
	VSCodeCall("workbench.action.files.saveWithoutFormatting")
end

local function trim__save__no_format()
	trim_trailing_whitespace()
	save_no_format()
end

local function trim__save()
	trim_trailing_whitespace()
	save()
end
Map("", "U", trim__save)

local function format()
	VSCodeCall("editor.action.formatDocument")
	print("formatted!")
end

local function trim__save__format()
	trim_trailing_whitespace()
	format()
	save()
end
Map("", "<leader>U", trim__save__format)

local function reveal_definition_aside()
	VSCodeNotify("editor.action.revealDefinitionAside")
end
Map("n", "gD", reveal_definition_aside)

local function go_to_implementation()
	VSCodeNotify("editor.action.goToImplementation")
end
Map("n", "gt", go_to_implementation)

local function go_to_reference()
	VSCodeNotify("editor.action.goToReferences")
end
Map("n", "gq", go_to_reference)

local function rename_symbol()
	VSCodeNotify("editor.action.rename")
end
Map("n", "<leader>r", rename_symbol)

local function outdent()
	---@diagnostic disable-next-line: unused-local
	for i = 1, vim.v.count1 do
		VSCodeNotify("editor.action.outdentLines")
	end
end
Map("n", "<<", outdent)

local function indent()
	---@diagnostic disable-next-line: unused-local
	for i = 1, vim.v.count1 do
		VSCodeNotify("editor.action.indentLines")
	end
end
Map("n", ">>", indent)

local function comment() VSCodeNotify("editor.action.commentLine") end
Map("n", "gcc", comment)

local function reindent()
	VSCodeNotify("editor.action.reindentlines")
end
Map("n", "==", reindent)

local function convert_to_spaces() VSCodeNotify("editor.action.indentationToSpaces") end
Map("n", "=s", convert_to_spaces)

local function convert_to_tabs()
	VSCodeNotify("editor.action.indentationToTabs")
end
Map("n", "=t", convert_to_tabs)

local function indent_with_spaces()
	VSCodeNotify("editor.action.indentUsingSpaces")
end
Map("n", "=d", indent_with_spaces)

local function indent_with_tabs()
	VSCodeNotify("editor.action.indentUsingTabs")
end
Map("n", "=g", indent_with_tabs)

local function toggle_fold() VSCodeNotify("editor.toggleFold") end
Map("n", "za", toggle_fold)

local function closeEditor()
	VSCodeNotify("workbench.action.closeActiveEditor")
end
Map("n", "K", closeEditor)

local function git_stage_file()
	trim_trailing_whitespace()
	save()
	VSCodeNotify("git.stage")
end
Map("n", "zk", git_stage_file)

local function git_unstage_file()
	save()
	VSCodeNotify("git.unstage")
end
Map("n", "zK", git_unstage_file)

local function git_revert_change()
	VSCodeNotify("git.revertSelectedRanges")
end
Map("n", "zJ", git_revert_change)
Map("v", "zJ", git_revert_change)

local function git_stage_change()
	VSCodeNotify("git.stageSelectedRanges")
end
Map("n", "zj", git_stage_change)
Map("v", "zj", git_stage_change)

local function git_unstage_change()
	VSCodeNotify("git.unstageSelectedRanges")
end

local function git_open_changes() VSCodeNotify("git.openChange") end
Map("n", "zi", git_open_changes)

local function git_open_all_changes()
	VSCodeNotify("git.openAllChanges")
end
Map("n", "zI", git_open_all_changes)

local function accept_merge_both()
	VSCodeNotify("merge-conflict.accept.both")
end
Map("n", "zo", accept_merge_both)

local function accept_merge_all_both()
	VSCodeNotify("merge-conflict.accept.all-both")
end
Map("n", "zO", accept_merge_all_both)

local function accept_merge_current()
	VSCodeNotify("merge-conflict.accept.current")
end
Map("n", "zu", accept_merge_current)

local function accept_merge_all_current()
	VSCodeNotify("merge-conflict.accept.all-current")
end
Map("n", "zU", accept_merge_all_current)

local function accept_merge_incoming()
	VSCodeNotify("merge-conflict.accept.incoming")
end
Map("n", "zp", accept_merge_incoming)

local function accept_merge_all_incoming()
	VSCodeNotify("merge-conflict.accept.all-incoming")
end
Map("n", "zP", accept_merge_all_incoming)

local function accept_merge_selection()
	VSCodeNotify("merge-conflict.accept.selection")
end
Map("n", "zl", accept_merge_selection)
Map("v", "zl", accept_merge_selection)

local function codesnap()
	VSCodeNotify("codesnap.start", true)
end
Map("v", "gs", codesnap)

local function outdent_vis()
	VSCodeNotify("editor.action.outdentLines", false)
end
Map("v", "<", outdent_vis)

local function indent_vis()
	VSCodeNotify("editor.action.indentLines", false)
end
Map("v", ">", indent_vis)

local function comment_vis()
	VSCodeNotify("editor.action.commentLine", false)
end
Map("v", "gc", comment_vis)

local function add_word_user_dictionary()
	VSCodeNotify("cSpell.addWordToUserDictionary")
end
Map("n", "=w", add_word_user_dictionary)

local function toggle_breakpoint()
	VSCodeNotify("editor.debug.action.toggleBreakpoint")
end
Map("n", "zy", toggle_breakpoint)