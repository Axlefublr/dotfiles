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

function gll
	set -l connector
	if set -q argv[1]
		set connector $argv[1]
	else
		set connector tree
	end
	printf (ggl)/$connector/(git rev-parse HEAD)
end
funcsave gll > /dev/null

function gllc
	gll | tee /dev/tty | clip.exe
end
funcsave gllc > /dev/null

function gllb
	$BROWSER (gll)
end
funcsave gllb > /dev/null

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
	printf (gll $connector)/$path
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