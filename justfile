set shell := ['fish', '-c']

# [[sort on]]
alias xr := xremap
alias xrp := xremap-stop
alias xrs := xremap-start
# [[sort off]]

default:
    echo {{CLEAR}}

helix:
    ./helix/generator.py

hooks:
    -rm -f ./.git/hooks/pre-commit
    echo '{{'''
        #!/usr/bin/env fish
        ibsort.fish (git diff --name-only --cached)
    '''}}' >./.git/hooks/pre-commit
    chmod +x ./.git/hooks/pre-commit

update:
    -paru -Sua
    loago do update

xremap: xremap-stop xremap-start

xremap-start:
    xremap ./xremap.yml &>/dev/null & disown

xremap-stop:
    -killall xremap
