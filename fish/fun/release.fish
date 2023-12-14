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

	echo 'is Cargo.toml filled in with proper metadata?'
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
	cargo fmt

	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes.txt &&
	git push origin $taggedVersion
	truncate -s 0 release-notes.txt
	cargo publish
end
funcsave rust-release > /dev/null

function rust-publish
	echo 'is Cargo.toml filled in with proper metadata?'
	echo 'did you commit your unstaged changes?'
	read -ln 1 should_continue
	if not test $should_continue
		return 1
	end
	cargo publish
end
funcsave rust-publish > /dev/null

function rust-fmt --description 'Bring in format config and format with it'
	if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
		echo "you're not in repo root"
		return 1
	end
	cp -f ~/prog/dotfiles/rustfmt.toml ./rustfmt.toml &&
	cargo fmt
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
	cargo build -r &&
	cp -f ./target/release/(basename $PWD) ~/prog/binaries
end
funcsave rust-bin > /dev/null

function rust-init
	cargo init
	touch README.md
	touch release-notes.txt
	indeed .gitignore release-notes.txt
	rust-ci
	git add . &&
	git commit -m "first commit"
end
funcsave rust-init > /dev/null