abbr --set-cursor -a gmm 'git commit -m "%"'
abbr --set-cursor -a tgg 'tgpt "%"'
abbr --set-cursor -a ytv 'yt-dlp -o \'%.%(ext)s\' \'\''
abbr --set-cursor -a yta 'yt-dlp -x --audio-format mp3 -o \'%.%(ext)s\' \'\''
abbr --set-cursor -a ghic 'gh issue create -t "%"'

abbr --set-cursor -a gamm 'git add . &&
	git commit -am "%"'
abbr --set-cursor -a gammp 'git add . &&
	git commit -am "%" &&
	git push'

abbr --set-cursor -a alarmb 'alarm %
	bell'

abbr --set-cursor -a care 'set -l taggedVersion %
	test -e README.md &&
	test -e release-notes &&
	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes.txt &&
	git push origin $taggedVersion &&
	cargo publish'

abbr --set-cursor -a dnre 'set -l taggedVersion %
	test -e README.md &&
	test -e release-notes.txt &&
	git add . &&
	git commit -m $taggedVersion &&
	git push &&
	git tag $taggedVersion -F release-notes.txt &&
	git push origin $taggedVersion &&
	dotnet publish --configuration Release --runtime linux-x64 --self-contained &&
	dotnet publish --configuration Release --runtime win-x64 --self-contained &&
	set -l binaryName (basename $PWD) &&
	gh release create $taggedVersion -t $taggedVersion -F release-notes.txt ./bin/Release/net7.0/linux-x64/publish/$binaryName ./bin/Release/win-x64/publish/$binaryName.exe'