set shell := ['fish', '-c']

[no-exit-message]
default:
    #!/usr/bin/env fish
    set -l filter .
    while true
        read -c $filter -P filter: filter || break
        sttr yaml-json ~/.local/share/glaza/current.yml | jq -C $filter &| ov -F
    end

hooks:
    -rm -f ./.git/hooks/pre-commit
    echo '{{'''
        #!/usr/bin/env fish
    '''}}' >./.git/hooks/pre-commit
    chmod +x ./.git/hooks/pre-commit

systemd: systemd-setup
    #!/usr/bin/env fish
    set -l user_units ~/r/dot/systemd/minute.{service,timer} \
        ~/r/dot/systemd/daily.{service,timer} \
        ~/r/dot/systemd/ten-minutes.{service,timer} \
        ~/r/dot/systemd/wake.{path,service} \
        ~/r/dot/systemd/flipboard.service \
        ~/r/dot/systemd/frizz.{path,service} \
        ~/r/dot/systemd/axleizer.service
    for unit in $user_units
        ln -sf $unit ~/.config/systemd/user/
    end

    not test -f /usr/lib/systemd/system-sleep/suspend-handler.fish && sudo ln -f ~/r/dot/systemd/suspend-handler.fish /usr/lib/systemd/system-sleep/suspend-handler.fish

    systemctl --user daemon-reload
    systemctl --user enable --now daily.timer
    systemctl --user enable --now ten-minutes.timer
    systemctl --user enable --now minute.timer
    systemctl --user enable --now axleizer.service
    systemctl --user enable --now wake.path
    systemctl --user enable --now flipboard.service
    systemctl --user enable --now frizz.path

systemd-setup:
    mkdir -p ~/.config/systemd/user
