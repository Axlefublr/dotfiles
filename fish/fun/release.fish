#!/usr/bin/env fish

function csharp-release
	if not set -q argv[1]
		echo "you didn't set the version!"
		return 1
	end
	if not command -q gh
		echo "you don't have gh!"
		return 1
	end
	set -l taggedVersion v$argv[1]
	git tag $taggedVersion
	git push origin $taggedVersion
	dotnet publish --configuration Release --runtime linux-x64 --self-contained
	dotnet publish --configuration Release --runtime win-x64 --self-contained
	set -l binaryName (basename $PWD)
	gh release create $taggedVersion -n "" ./bin/Release/net7.0/linux-x64/publish/$binaryName ./bin/Release/win-x64/publish/$binaryName.exe
end
funcsave csharp-release > /dev/null

function rust-release-publish
	if not set -q argv[1]
		echo "you didn't set the version!"
		return 1
	end
	if not command -q gh
		echo "you don't have gh!"
		return 1
	end
	set -l taggedVersion v$argv[1]
	git add Cargo.toml
	git commit -m $taggedVersion
	git push
	git tag $taggedVersion
	git push origin $taggedVersion
	cargo build --release
	set -l binaryName (basename $PWD)
	gh release create $taggedVersion -n "" ./target/release/$binaryName
	cargo publish
end
funcsave rust-release-publish > /dev/null