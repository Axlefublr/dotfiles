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