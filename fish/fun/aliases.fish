#!/usr/bin/env fish

alias --save grep 'grep --color=auto --exclude-dir={target,.bzr,CVS,.git,.hg,.svn,.idea,.tox}' > /dev/null
alias --save fd 'fd --no-require-git' > /dev/null
alias --save rg 'rg --engine auto' > /dev/null
alias --save less 'less --use-color -R' > /dev/null
alias --save termdown 'termdown -W -f roman' > /dev/null
alias --save dotnet 'dotnet.exe' > /dev/null
alias --save gh 'gh.exe' > /dev/null
alias --save code 'code-insiders' > /dev/null
alias --save node 'node.exe' > /dev/null
alias --save ... 'cd ../..' > /dev/null
alias --save .... 'cd ../../..' > /dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode &| tee /tmp/pagie &| less' > /dev/null
alias --save tgg 'tgpt "$argv"' > /dev/null