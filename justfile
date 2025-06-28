set shell := ['fish', '-c']

[no-exit-message]
default:

hooks:
    -rm -f ./.git/hooks/pre-commit
    echo '{{'''
        #!/usr/bin/env fish
    '''}}' >./.git/hooks/pre-commit
    chmod +x ./.git/hooks/pre-commit
