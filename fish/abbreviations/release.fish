abbr --set-cursor -a rust-release 'set -l taggedVersion % &&
	test -e README.md &&
	test -e release-notes &&
	test -e ./.github/ci.yml &&
	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes &&
	git push origin $taggedVersion &&
	cargo publish'

abbr --set-cursor -a csharp-release 'set -l taggedVersion % &&
	test -e README.md &&
	test -e release-notes &&
	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes &&
	git push origin $taggedVersion &&
	dotnet publish --configuration Release --runtime linux-x64 --self-contained &&
	dotnet publish --configuration Release --runtime win-x64 --self-contained &&
	set -l binaryName (basename $PWD) &&
	gh release create $taggedVersion -t $taggedVersion -F release-notes ./bin/Release/net7.0/linux-x64/publish/$binaryName ./bin/Release/win-x64/publish/$binaryName.exe'