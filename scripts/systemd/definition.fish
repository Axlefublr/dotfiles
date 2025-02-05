#!/usr/bin/env fish

mkdir -p ~/.config/systemd/user
ln -sf ~/r/dot/scripts/systemd/services/* ~/.config/systemd/user
ln -sf ~/r/dot/scripts/systemd/timers/* ~/.config/systemd/user

systemctl --user daemon-reload

systemctl --user enable --now daily.timer

systemctl --user enable --now ten-minutes.timer

systemctl --user enable --now minute.timer