set shell := ['fish', '-c']

# [[sort on]]
alias xr := xremap
alias xrp := xremap-stop
alias xrs := xremap-start
# [[sort off]]

default:
    @just --choose

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
    #!/usr/bin/env fish
    set -l user_units ~/r/dot/systemd/minute.{service,timer} ~/r/dot/systemd/daily.{service,timer} ~/r/dot/systemd/ten-minutes.{service,timer} ~/r/dot/systemd/axleizer.service ~/r/dot/systemd/xwayland-satellite.service
    for unit in $user_units
        ln -sf $unit ~/.config/systemd/user/
    end

    mkdir -p ~/.config/systemd/user/swaybg.service.d
    ln -sf ~/r/dot/systemd/swayimg.systemd ~/.config/systemd/user/swaybg.service.d/mine.conf

    not test -d /etc/systemd/system/fancontrol.service.d && sudo mkdir -p /etc/systemd/system/fancontrol.service.d
    not test -f /etc/systemd/system/fancontrol.service.d/mine.conf && sudo ln -f ~/r/dot/systemd/fancontrol.systemd /etc/systemd/system/fancontrol.service.d/mine.conf

    # not test -f /etc/systemd/system/wake.service && sudo ln -f ~/r/dot/systemd/wake.service /etc/systemd/system/wake.service

    # sudo systemctl daemon-reload
    # sudo systemctl enable wake.service

    systemctl --user daemon-reload
    systemctl --user enable --now daily.timer
    systemctl --user enable --now ten-minutes.timer
    systemctl --user enable --now minute.timer
    systemctl --user enable --now axleizer.service
    systemctl --user enable --now xwayland-satellite.service

systemd-setup:
    mkdir -p ~/.config/systemd/user

xremap: xremap-stop xremap-start

xremap-start:
    xremap ./xremap.yml &>/dev/null & disown

xremap-stop:
    -killall xremap
