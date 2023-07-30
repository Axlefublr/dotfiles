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
	mkdir -p ./bin/Donsies/{linux,windows}
	rm -f "./bin/Donsies/{linux,windows}/*" 2> /dev/null
	dotnet publish -r linux-x64 --self-contained -o ./bin/Donsies/linux/
	dotnet publish -r win-x64 --self-contained -o ./bin/Donsies/windows/
	set -l binaryName (basename $PWD)
	gh release create $taggedVersion -n "" ./bin/Donsies/linux/$binaryName ./bin/Donsies/windows/$binaryName.exe
end
funcsave csharp-release > /dev/null