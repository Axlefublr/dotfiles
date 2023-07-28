#!/usr/bin/env fish

alias --save fd 'fd --no-require-git' > /dev/null
alias --save rg 'rg --engine auto' > /dev/null
alias --save less 'less --use-color -R' > /dev/null
alias --save termdown 'termdown -W -f roman' > /dev/null
alias --save ... 'cd ../..' > /dev/null
alias --save .... 'cd ../../..' > /dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode &| tee /tmp/pagie &| less' > /dev/null
alias --save xclip 'xclip -selection clipboard' > /dev/null
alias --save tgg 'tgpt "$argv"' > /dev/null