# Colors I use
# FFAFD7 - pink
# AF87FF - purple

set -g fish_prompt_vim_symbol

set -U fish_color_cwd FFAFD7
set -U fish_color_symbol FFAFD7
set -U fish_color_date AF87FF

set -g __fish_git_prompt_char_stateseparator ' '
set -g fish_lazy_load_completions 'true'
set -g fish_lazy_load_functions 'true'
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

function fish_greeting
end

function fish_mode_prompt
	switch $fish_bind_mode
		case default
			set fish_prompt_vim_symbol ' $$$ '
		case insert
			set fish_prompt_vim_symbol ' >>> '
		# case replace_one
		# 	set fish_prompt_vim_symbol ' ___ '
		case visual
			set fish_prompt_vim_symbol ' ^^^ '
	end
end

function fish_prompt
	printf \n
	set_color $fish_color_cwd
	printf (prompt_pwd)
   fish_git_prompt
	set_color $fish_color_date
	printf \n(date "+%H:%M")
	set_color $fish_color_symbol
	printf $fish_prompt_vim_symbol
end