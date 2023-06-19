#!/usr/bin/env fish

alias --save grep 'grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias --save less 'less --use-color -R'
alias --save termdown 'termdown -W -f roman'
alias --save dotnet 'dotnet.exe'
alias --save gh 'gh.exe'
alias --save code 'code-insiders'
alias --save node 'node.exe'
alias --save ... 'cd ../..'
alias --save .... 'cd ../../..'
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git &| tee /tmp/pagie &| less'