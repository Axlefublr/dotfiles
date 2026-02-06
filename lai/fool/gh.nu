#!/usr/bin/env -S nu -n --no-std-lib

use always.nu 'path shrink'

def --wrapped main [...rest] {
	^gh ...$rest
}

def --wrapped 'main repo clone' [url: string, --dir(-d): directory, --shallow(-s), ...rest] {
	let dir = $dir | default ($url | path basename)
	let rest = $rest | shallow include $shallow
	try { gh repo clone (expand-me $url) $dir ...$rest }
	# shallow enqueue $shallow $dir
	$dir | commit
}

def --wrapped 'main give' [url: string = '', ...rest] {
	cd ~/fes/ork/duc
	main repo clone ($url | default -e (wl-paste -n)) -s ...$rest
}

def --wrapped 'main repo create' [name: string, ...rest] {
	^gh repo create --clone -l MIT $name ...$rest
	$name | commit
}

def --wrapped 'main repo fork' [url: string, --dir(-d): directory, --shallow(-s), ...rest] {
	let dir = $dir | default ($url | path basename)
	let rest = $rest | shallow include $shallow
	^gh repo fork --clone --default-branch-only (expand-me $url) --fork-name $dir ...$rest
	# shallow enqueue $shallow $dir
	$dir | commit
}

def 'main pull' [url: string] {
	let id = $url | str trim | split row ' ' | get 0 | split row '/' | last
	let pwdb = $env.PWD | path shrink | path basename
	let data_path = '~/fes/talia' | path expand | path join $pwdb pull.nuon
	let branch_name = try { # resolve the full branch name from the stored data
		let pull = open $data_path | get $id
		$'($id)/($pull.title)/($pull.author)'
	} catch { # resolve the author and ask for the branch title, store it into the nuon file
		let pull = gh pr view --json number,author,title $url | from json
		| { id: ($in.number | into string), author: $in.author.login, title: $in.title }

		print -e $pull.title
		let input = input --reedline 'branchname:'
		if ($input | is-empty) { return }
		let pull = $pull | update title $input

		let pull = if ($pull.author == 'app/') {
			print -e 'author is dead. provide manually'
			gh pr view $url e>| ignore
			fish -c 'ensure_browser'
			input --reedline 'author:' | let input | if ($in | is-empty) { return }
			$pull | update author $input
		} else { $pull }

		try { open $data_path } catch {{}}
		| upsert $pull.id { author: $pull.author, title: $pull.title }
		| to nuon -t 1
		| save -f $data_path

		$'($pull.id)/($pull.title)/($pull.author)'
	}
	gh pr checkout -b $branch_name -f $id
}

def 'main pull list' [] {
	let pwdb = $env.PWD | path shrink | path basename
	let data_path = '~/fes/talia' | path expand | path join $pwdb pull.nuon
	open $data_path
	| items { |key, value|
		{ a: $key, b: $value.author, c: $value.title }
	} | rename -c { a: index }
	| table -t none
	| lines
	| skip 1
	| to text
}

def 'main pull fix' [] {
	let prnum = gh pr view --json number | from json | get number
	let branch_name = git branch --show-current
	git branch -m $'($branch_name)/($prnum)'
}

def 'main pull open' [branch_name: string] {
	let components = $branch_name | split row '/'
	let prnum = $components | first | if ($in not-like '^\d+$') {
		$components | last | if ($in like '^\d+$') {} else { return }
	} else {}
	gh pr view -w $prnum
	fish -c 'ensure_browser'
}

def 'main dogni-upstream' [branch_name: string] {
	$branch_name | split row '/' | first | if ($in like '^\d+$') {
		main pull $in
	} else {
		git fetch upstream
      git symbolic-ref --short refs/remotes/upstream/HEAD
      | each {
	      str trim | try { git rebase $in }
      }
	}
}

def commit [] {
	$env.PWD + '/' + $in | save -f /tmp/mine/github-directory
}

def expand-me [url: string] {
	$url
	| path split
	| each {
		if $in == '@' {
			'Axlefublr'
		} else if $in ends-with ':' {
			$in + '/'
		} else { $in }
	}
	| str join /
	| tee { print -ne ($in + "\n") }
}

def 'shallow include' [shallow: bool]: list<string> -> list<string> {
		if $shallow {
			if ($in | where $it == '--' | length | $in > 0) {
				$in | append ['--depth=1']
			} else {
				$in | append ['--' '--depth=1']
			}
		} else {
			$in
		}
}

def 'shallow enqueue' [shallow: bool, dir: directory] {
	pueue add -w ($env.PWD | path join $dir) -g network -- 'git fetch --unshallow'
}
