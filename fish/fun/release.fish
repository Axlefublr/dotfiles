#!/usr/bin/env fish

function rust-release
	if not set -q argv[1]
		echo 'set the version'
		return 1
	end
	set -l taggedVersion $argv[1]

	if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
		echo "you're not in repo root"
		return 1
	end

	if not test -f README.md
		echo 'no readme'
		return 1
	end
	if not test -s README.md
		echo 'readme is empty'
		return 1
	end

	if not test -f release-notes.txt
		echo 'no release notes'
		return 1
	end
	if not test -s release-notes.txt
		echo 'release notes empty'
		return 1
	end

	if test (rg '^description \= ""$' Cargo.toml)
		echo 'no description in Cargo.toml'
		return 1
	end

	echo 'did you update the README?'
	echo 'did you update --help?'
	echo 'your ci pipeline is going to get updated if necessary'
	read -ln 1 should_continue
	if not test $should_continue
		return 1
	end

	if not test (rg -e "^version = \"$taggedVersion\"" Cargo.toml)
		echo "you didn't update the version in Cargo.toml"
		return 1
	end

	rust-ci
	indeed .gitignore release-notes.txt
	cargo mommy +nightly fmt

	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes.txt &&
	git push origin $taggedVersion
	truncate -s 0 release-notes.txt
	cargo mommy publish
end
funcsave rust-release > /dev/null

function rust-publish
	if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
		echo "you're not in repo root"
		return 1
	end
	if test (rg '^description \= ""$' Cargo.toml | count) -ge 1
		echo 'no description in Cargo.toml'
		return 1
	end
	if test (git status -s | count) -ge 1
		echo 'you have unstaged changes'
		return 1
	end
	cargo mommy publish
end
funcsave rust-publish > /dev/null

function rust-fmt --description 'Bring in format config and format with it'
	if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
		echo "you're not in repo root"
		return 1
	end
	cp -f ~/prog/dotfiles/rust/rustfmt.toml ./.rustfmt.toml &&
	cargo mommy +nightly fmt
end
funcsave rust-fmt > /dev/null

function rust-ci --description 'Bring in on tag push github action'
	if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
		echo "you're not in repo root"
		return 1
	end
	mkdir -p ./.github/workflows &&
	cp -f ~/prog/dotfiles/ghactions/rust.yml ./.github/workflows/ci.yml &&
	sd your-project-name (basename $PWD) ./.github/workflows/ci.yml
end
funcsave rust-ci > /dev/null

function rust-bin
	if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
		echo "you're not in repo root"
		return 1
	end
	set -l name (basename $PWD)
	cargo mommy build -r &&
	cp -f ./target/release/$name ~/prog/binaries
	if set -q argv[1]
		set -l newVersion $argv[1]
		set -l prevdir (pwd)
		cd ~/prog/binaries
		git add $name && git commit -m "$name: $newVersion"
		cd $prevdir
	end
end
funcsave rust-bin > /dev/null

function rust-init
	cargo mommy init
	cp -f ~/prog/dotfiles/rust/metadata.toml ./Cargo.toml
	sd '%project_name%' (basename $PWD) Cargo.toml
	touch README.md
	touch release-notes.txt
	indeed .gitignore release-notes.txt
	rust-ci
	git add . &&
	git commit -m "first commit"
end
funcsave rust-init > /dev/null