#!/usr/bin/env fish

function fish_prompt_pwd
	set -l git_repo_full (git rev-parse --show-toplevel 2> /dev/null)
	if test $git_repo_full
		set -l git_repo (basename $git_repo_full)
		set -l not_git_repo (string replace $git_repo '' $git_repo_full)
		printf (string replace "$not_git_repo" '' $PWD)
	else
		set -l home (string escape --style=regex $HOME)
		set -l cwd (string replace -r "^$home" '~' $PWD)
		set -l base (basename $cwd)
		echo -n $base
	end
end
funcsave fish_prompt_pwd > /dev/null

function fish_prompt_status
	set -l countstatus (count $argv)
	if test $countstatus -gt 1
		set -l are_all_success true
		for i in (seq $countstatus)
			if test $argv[$i] -ne 0
				set are_all_success false
				break
			end
		end
		if test $are_all_success = false
			for i in (seq $countstatus)
				if test $i -gt 1
					printf ' '
				end
				if test $argv[$i] -ne 0
					set_color -o $color_red
					printf '󱎘'
				else
					set_color -o $color_green
					printf ''
				end
				printf $argv[$i]
			end
			printf ' '
		end
	else
		if test $argv -ne 0
			set_color -o $color_red
			printf '󱎘%s ' $argv
		end
	end
end
funcsave fish_prompt_status > /dev/null

function fish_prompt
	set -l fullstatuses $pipestatus
	set_color $color_yellow
	if set -q fish_private_mode
		printf '󰗹 '
	end
	if test (count (jobs)) -gt 0
		printf ' '
	end
	if not test -w .
		printf ' '
	end
	set_color $color_orange
	if test $USER != 'axlefublr'
		echo -n ' '$USER
	end
	if set -q SSH_TTY
		set_color -o $color_yellow
		echo -n '@'
		set_color normal
		set_color $color_orange
		echo -n $hostname
	end
	set_color -o $color_pink
	fish_prompt_pwd
	set_color normal
	if test $COLUMNS -ge $small_threshold
		printf ' '
	else
		printf '\n'
	end
	if git rev-parse --is-inside-work-tree &> /dev/null
		set -l curr_branch (git branch --show-current 2> /dev/null)
		set_color -o $color_purple
		if test $curr_branch
			echo -n ''$curr_branch' '
		else
			set -l curr_commit (git rev-parse --short HEAD 2> /dev/null)
			echo -n ''$curr_commit' '
		end
		set_color normal
		command -q octogit && octogit-set
		if test $COLUMNS -lt $small_threshold
			printf '\n'
		end
	end
	fish_prompt_status $fullstatuses
	set_color $color_yellow
	printf '󱕅 '
	set_color normal
end
funcsave fish_prompt > /dev/null

function fish_mode_prompt
end
funcsave fish_mode_prompt > /dev/null
