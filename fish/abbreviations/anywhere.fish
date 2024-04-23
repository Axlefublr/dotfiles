abbr -a ,sr --position anywhere -- '> /dev/null'
abbr -a ,er --position anywhere -- '2> /dev/null'
abbr -a ,ar --position anywhere -- '&> /dev/null'
abbr -a ,h --position anywhere -- $HOME/
abbr -a ,ds --position anywhere -- '&> /dev/null & disown'
abbr -a ,dsr --position anywhere --set-cursor -- '&> % & disown'
abbr -a ,f --position anywhere -- '&& clx'
abbr -a ,d --position anywhere -- 'clx &&'
abbr -a ,a --position anywhere -- '&& exit'
