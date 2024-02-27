abbr --set-cursor -a z 'z %'
abbr --set-cursor -a gmm 'git commit -m "%" && clx'
abbr --set-cursor -a tgg 'clx && tgpt "%"'
abbr --set-cursor -a ytv 'yt-dlp -o \'%.%(ext)s\' \'\''
abbr --set-cursor -a ytvy 'yt-dlp -o \'/home/axlefublr/Videos/content/youtube/%.%(ext)s\' \'\''
abbr --set-cursor -a yta 'yt-dlp -x --audio-format mp3 -o \'%.%(ext)s\' \'\''
abbr --set-cursor -a ghic 'gh issue create -t "%"'
abbr --set-cursor -a diff 'diff -u % | diff-so-fancy'
abbr --set-cursor -a math 'math \'%\''
abbr --set-cursor -a rmfn 'rm -fr ~/.config/fish/functions/%.fish'
abbr --set-cursor -a dnrp 'dotnet run --project % --'
abbr --set-cursor -a awl 'awesome-client \'%\''

abbr --set-cursor -a gamm 'git add . &&
	git commit -am "%" &&
	clx'
abbr --set-cursor -a gammp 'git add . &&
	git commit -am "%" &&
	git push &&
	clx'

abbr --set-cursor -a slurr 'systemctl --user daemon-reload
	systemctl --user restart %.timer'