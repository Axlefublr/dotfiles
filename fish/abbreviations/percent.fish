abbr -a .. --regex '^\.\.+$' --function multiple_dot

abbr --set-cursor -a f 'nvim -c Young % && clx'
abbr --set-cursor -a ytv 'yt-dlp -o \'%.%(ext)s\' \'\''
abbr --set-cursor -a yta 'yt-dlp -x --audio-format mp3 -o \'%.%(ext)s\' \'\''
abbr --set-cursor -a diff 'diff -u % | diff-so-fancy'
