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
	printf (git remote get-url origin | sed 's/\.git$//')/$connector/$branch
end
funcsave ggl > /dev/null

function gglc
	ggl $argv | tee /dev/tty | clip.exe
end
funcsave gglc > /dev/null

function gglb
	$BROWSER (ggl $argv)
end
funcsave gglb > /dev/null

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
	printf (ggl $branch $connector)/$path
end
funcsave gglf > /dev/null

function gglfc
	gglf $argv | tee /dev/tty | clip.exe
end
funcsave gglfc > /dev/null

function gglfb
	$BROWSER (gglf $argv)
end
funcsave gglfb > /dev/null

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
	printf (ggl $hsh $connector)
end
funcsave gll > /dev/null

function gllc
	gll $argv | tee /dev/tty | clip.exe
end
funcsave gllc > /dev/null

function gllb
	$BROWSER (gll $argv)
end
funcsave gllb > /dev/null

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
	printf (gll $hsh $connector)/$path
end
funcsave gllf > /dev/null

function gllfc
	gllf $argv | tee /dev/tty | clip.exe
end
funcsave gllfc > /dev/null

function gllfb
	$BROWSER (gllf $argv)
end
funcsave gllfb > /dev/null

function gsp
	set -l remote (git remote)
	set -l branch (git branch --show-current)
	git log --oneline $remote/$branch..$branch
end
funcsave gsp > /dev/null

function gsa
	clear -x
	set -l prevDir (pwd)
	set -l directories $git_repositories

	for dir in $directories

		cd $dir
		set_color yellow
		echo $dir
		set_color normal
		and git status -s
		and gsp

	end

	cd $prevDir
end
funcsave gsa > /dev/null