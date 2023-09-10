#!/usr/bin/env fish

function ggl
	set -l branch
	if set -q argv[1] && test $argv[1] != ''
		set branch $argv[1]
	else
		set branch (git branch --show-current)
	end
	set -l connector 'tree'
	if set -q argv[2] && test $argv[2] != ''
		set connector $argv[2]
	end
	echo (git remote get-url origin | sed 's/\.git$//')/$connector/$branch
end
funcsave ggl > /dev/null

function gglf
	set -l path $argv[1]
	set -l is_file
	if test -d $path
		set is_file false
	else if test -f $path
		set is_file true
	else
		return 1
	end
	set path (string replace -r '^\.\/' '' $path)
	set -l connector
	if test $is_file = true
		set connector 'blob'
	else
		set connector 'tree'
	end
	set -l branch ''
	if set -q argv[2]
		set branch $argv[2]
	end
	echo (ggl $branch $connector)/$path
end
funcsave gglf > /dev/null

function gll
	set -l hsh 'HEAD'
	if set -q argv[1] && test $argv[1] != ''
		set hsh $argv[1]
	end
	set hsh (git rev-parse $hsh)
	set -l connector ''
	if set -q argv[2]
		set connector $argv[2]
	end
	echo (ggl $hsh $connector)
end
funcsave gll > /dev/null

function gllf
	set -l path $argv[1]
	set -l is_file
	if test -d $path
		set is_file false
	else if test -f $path
		set is_file true
	else
		return 1
	end
	set path (string replace -r '^\.\/' '' $path)
	set -l connector
	if test $is_file = true
		set connector 'blob'
	else
		set connector 'tree'
	end
	set -l hsh ''
	if set -q argv[2]
		set hsh $argv[2]
	end
	echo (gll $hsh $connector)/$path
end
funcsave gllf > /dev/null

function gsp
	set -l remote (git remote 2> /dev/null)[1]
	set -l branch (git branch --show-current 2> /dev/null)
	if test $remote && test $branch
		git log --oneline $remote/$branch..$branch 2> /dev/null
	end
end
funcsave gsp > /dev/null

function gsa
	if not command -q octussy-git-status
		echo "you don't have octussy-git-status"
	end
	set -l prevDir (pwd)
	set -l directories (cat ~/prog/dotfiles/fish/recognized-git.txt | string split '\n')

	for dir in $directories

		set dir (string replace -r "^~" "$HOME" $dir)
		cd $dir
		echo -n (basename $dir)' '
		octussy-git-status --status (git status --porcelain | string collect -a) --unpushed (gsp | wc -l || echo 0)
		printf '\n'

	end

	cd $prevDir
end
funcsave gsa > /dev/null

function gsah
	if not command -q octussy-git-status
		echo "you don't have octussy-git-status"
	end
	set -l prevDir (pwd)
	set -l directories (fd -uu '.git$' | path dirname)

	for dir in $directories

		cd $prevDir/$dir
		echo -n $dir' '
		octussy-git-status --status (git status --porcelain | string collect -a) --unpushed (gsp | wc -l || echo 0)
		printf '\n'

	end

	cd $prevDir
end
funcsave gsah > /dev/null

function gpp
	set -l prevDir (pwd)
	set -l directories (cat ~/prog/dotfiles/fish/recognized-git.txt | string split '\n')

	for dir in $directories

		set dir (string replace -r "^~" "$HOME" $dir)
		cd $dir
		git push

	end

	cd $prevDir
end
funcsave gpp > /dev/null