#!/usr/bin/env fish

cd ~/pic/twemoji-svg
if not git status -s
    exit 1
end
set renamed (git status -s | string match -gr '^\\?\\? (.*).svg')
set deleted (git status -s | string match -gr '^ D (.*).svg')
for unnamed in $deleted
    for named in $renamed
        if string match -e "$unnamed" "$named" >/dev/null
            git add "$unnamed.svg"
            git add "$named.svg"
            git commit -m "$unnamed -> $named"
        end
    end
end
