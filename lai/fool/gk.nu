#!/usr/bin/env -S nu -n --no-std-lib

use always.nu 'path shrink'

def main [] {}

def --wrapped 'main clone' [url?: string, --dir(-d): directory, --where(-w): directory = '.', ...rest] {
	# this, repo, brath, line
	let url_data = parse_url $url
	cd $where
	let target_dir = target_dir $url_data.repo $dir $where
	let target_exists = $target_dir | path exists
	if not $target_exists {
		# it's safe to specify the target directory explicitly every time, as far as I can think
		let rest = $rest | prepend $target_dir
		^gh repo clone $url_data.this ...$rest -- --filter=blob:none
	}
	commit_cd_path $target_dir
	cd $target_dir
	if $target_exists { ^git fetch --all }
	let branch = commit_file_path $url_data.brath $url_data.line
	git_checkout $branch
}

def --wrapped 'main ork' [url?: string, --dir(-d): directory, ...rest] {
	main clone -w ~/fes/ork --dir=$dir $url ...$rest
}

def --wrapped 'main duc' [url?: string, --dir(-d): directory, ...rest] {
	main clone -w ~/fes/ork/duc --dir=$dir $url ...$rest
}

def 'main fork' [] {
	^gh repo fork --remote
	^gh repo set-default upstream
	main up
}

def 'main unfork' [] {
	main delete (git remote get-url origin)
	git remote remove origin
	git remote rename upstream origin
}

# turns this script into a different process to work around a nushell bug complaining about incorrect pwd
def 'main up' [] {
	let pwd = pwd
	if (($pwd | path dirname) == ('~/fes/ork/duc' | path expand)) {
		cd ~
		let target_dir = $'~/fes/ork/($pwd | path basename)' | path expand
		commit_cd_path $target_dir
		exec mv $pwd $target_dir
	}
}

def --wrapped 'main create' [name: string, ...rest] {
	cd ~/fes/ork
	^gh repo create --clone -l MIT $name ...$rest
	commit_cd_path ($name | path expand)
}

def --wrapped 'main public' [name: string, ...rest] {
	main create $name --public ...$rest
}

def --wrapped 'main private' [name: string, ...rest] {
	main create $name --private ...$rest
}

def --wrapped 'main mine' [...rest] {
	^gh repo list -L 1000 ...$rest
}

def 'main ..d' [] {
	let pwd = pwd
	try { main delete (^git remote get-url origin) }
	cd ..
	commit_cd_path (pwd)
	trash-put $pwd
}

def 'main delete' [name: string] {
	^gh repo delete --yes $name
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
			ensure-browser.nu
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

def parse_url [url?: string] {
	github-url-parser.rs ($url | default -e (wl-paste -n)) | from json
}

def target_dir [repo: directory, dir?: directory, where?: directory] {
	let initial_target = $dir | default $repo | path expand
	if ($initial_target | path exists) {
		return $initial_target
	}
	let target_basename = $initial_target | path basename
	# the mv -T should theoretically always work, because if `where` is specified at all, the initial target existing would quit early above
	# but using it to error out instead of doing foo/foo behavior, for if I missed something
	if ($where == ('~/fes/ork' | path expand)) {
		let existing_copy = '~/fes/ork/duc' | path join $target_basename | path expand | if ($in | path exists) {}
		if ($existing_copy | is-not-empty) {
			^mv -T $existing_copy $initial_target
		}
	} else if ($where == ('~/fes/ork/duc' | path expand)) {
		let existing_copy = '~/fes/ork' | path join $target_basename | path expand | if ($in | path exists) {}
		if ($existing_copy | is-not-empty) {
			^mv -T $existing_copy $initial_target
		}
	}
	$initial_target
}

# cds into the target directory as well
def commit_cd_path [target: directory] {
	$target | into string | save -f /tmp/mine/github-directory
}

def commit_file_path [brath?: string, line?: int] {
	# branch, path
	if ($brath | is-empty) { return }
	let the = github-brath-splitter.rs $brath | from json
	if ($the.path | is-not-empty) {
		if ($line | is-not-empty) {
			$'($the.path):($line)' | tee { save -f /tmp/mine/github-file } | print
		} else {
			$'($the.path)' | tee { save -f /tmp/mine/github-file } | print
		}
		print ''
	}
	$the.branch
}

def git_checkout [branch?: string] {
	if ($branch | is-empty) { return }
	if (^git branch --show-current) != $branch {
		^git checkout $branch
	}
}
