#!/usr/bin/env -S nu -n --no-std-lib

use always.nu 'path shrink'

def main [] {}

def --wrapped 'main clone' [url?: string, --dir(-d): directory, --where(-w): directory = '.', ...rest] {
	# this, repo, brath, line
	let url_data = parse_url $url
	cd $where
	let rest = if ($dir | is-not-empty) { $rest | prepend $dir }
	gh repo clone $url_data.this ...$rest -- --filter=blob:none
	commit_cd_path $url_data.repo $dir
	let branch = commit_file_path $url_data.brath $url_data.line
	git_checkout $branch
}

def --wrapped 'main ork' [url?: string, --dir(-d): directory, ...rest] {
	if ($dir | is-not-empty) {
		main clone -w ~/fes/ork --dir $dir $url ...$rest
	} else {
		main clone -w ~/fes/ork $url ...$rest
	}
}

def --wrapped 'main duc' [url?: string, --dir(-d): directory, ...rest] {
	if ($dir | is-not-empty) {
		main clone -w ~/fes/ork/duc --dir $dir $url ...$rest
	} else {
		main clone -w ~/fes/ork/duc $url ...$rest
	}
}

def parse_url [url?: string] {
	github-url-parser.rs ($url | default -e (wl-paste -n)) | from json
}

# cds into the target directory as well
def --env commit_cd_path [repo: directory, dir?: directory] {
	let dir = $dir | default $repo
	let target = $dir | path expand
	$target | into string | save -f /tmp/mine/github-directory
	cd $target
}

def commit_file_path [brath?: string, line?: int] {
	# branch, path
	if ($brath | is-empty) { return }
	let the = github-brath-splitter.rs $brath | from json
	if ($the.path | is-not-empty) {
		if ($line | is-not-empty) {
			$'($the.path):($line)' | save -f /tmp/mine/github-file
		} else {
			$'($the.path)' | save -f /tmp/mine/github-file
		}
	}
	$the.branch
}

def git_checkout [branch?: string] {
	if ($branch | is-empty) { return }
	if (git branch --show-current) != $branch {
		git checkout $branch
	}
}
