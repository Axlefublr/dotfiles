#!/usr/bin/env fish

function ggl
	printf (git remote get-url origin | sed 's/\.git$//')
end
funcsave ggl > /dev/null

function gglc
	ggl | tee /dev/tty | clip.exe
end
funcsave gglc > /dev/null

function gglb
	$BROWSER (ggl)
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
	printf (ggl)/$connector/(git branch --show-current)/$path
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
	set -l connector
	if set -q argv[2]
		set connector $argv[2]
	else
		set connector tree
	end
	printf (ggl)/$connector/(git rev-parse $argv[1])
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
	set -l path $argv[2]
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
	printf (gll $argv[1] $connector)/$path
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