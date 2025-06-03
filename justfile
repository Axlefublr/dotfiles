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
    not test -f /usr/lib/systemd/system-sleep/suspend-handler.fish && sudo ln -f ~/fes/dot/systemd/suspend-handler.fish /usr/lib/systemd/system-sleep/suspend-handler.fish

    systemctl --user link ~/fes/dot/systemd/minute.service
    systemctl --user enable --now ~/fes/dot/systemd/minute.timer

    systemctl --user link ~/fes/dot/systemd/daily.service
    systemctl --user enable --now ~/fes/dot/systemd/daily.timer

    systemctl --user link ~/fes/dot/systemd/ten-minutes.service
    systemctl --user enable --now ~/fes/dot/systemd/ten-minutes.timer

    systemctl --user link ~/fes/dot/systemd/wake.service
    systemctl --user enable --now ~/fes/dot/systemd/wake.path

    systemctl --user link ~/fes/dot/systemd/frizz.service
    systemctl --user enable --now ~/fes/dot/systemd/frizz.path

    systemctl --user link ~/fes/dot/systemd/flipboard.service
    systemctl --user enable --now ~/fes/dot/systemd/flipboard.path

    systemctl --user enable --now ~/fes/dot/systemd/axleizer.service

systemd-setup:
    mkdir -p ~/.config/systemd/user
