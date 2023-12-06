function rust-release
	if not set -q argv[1]
		echo 'set the version'
		return 1
	end
	set -l taggedVersion $argv[1]

	set -l root (basename $PWD)
	echo 'is this the repo root: '$root
	read -ln 1 is_root
	if not test $is_root
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

	if not test -f release-notes
		echo 'no release notes'
		return 1
	end
	if not test -s release-notes
		echo 'release notes empty'
		return 1
	end

	if not test -f ./.github/workflows/ci.yml
		echo 'no ci pipeline'
		return 1
	end
	if not test -s ./.github/workflows/ci.yml
		echo 'ci pipeline empty'
		return 1
	end

	echo 'did you update the README?'
	echo 'did you update --help?'
	echo 'did you update the release notes?'
	read -ln 1 should_continue
	if not test $should_continue
		return 1
	end

	if not test (rg -q '^version \= "'$taggedVersion'"$' Cargo.toml)
		echo "you didn't update the version in Cargo.toml"
		return 1
	end

	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes &&
	git push origin $taggedVersion
	cargo publish
end
funcsave rust-release > /dev/null