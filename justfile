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

systemd: systemd-setup
    ln -sf ~/r/dot/systemd/minute.service ~/.config/systemd/user/minute.service
    ln -sf ~/r/dot/systemd/minute.timer ~/.config/systemd/user/minute.timer

    ln -sf ~/r/dot/systemd/daily.service ~/.config/systemd/user/daily.service
    ln -sf ~/r/dot/systemd/daily.timer ~/.config/systemd/user/daily.timer

    ln -sf ~/r/dot/systemd/ten-minutes.service ~/.config/systemd/user/ten-minutes.service
    ln -sf ~/r/dot/systemd/ten-minutes.timer ~/.config/systemd/user/ten-minutes.timer

    systemctl --user daemon-reload
    systemctl --user enable --now daily.timer
    systemctl --user enable --now ten-minutes.timer
    systemctl --user enable --now minute.timer

systemd-setup:
    mkdir -p ~/.config/systemd/user

update:
    -paru -Sua
    loago do update

xremap: xremap-stop xremap-start

xremap-start:
    xremap ./xremap.yml &>/dev/null & disown

xremap-stop:
    -killall xremap
