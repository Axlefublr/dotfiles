#!/usr/bin/env fish

mkdir -p ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/services/* ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/timers/* ~/.config/systemd/user

systemctl --user daemon-reload

systemctl --user enable --now daily.timer

systemctl --user enable --now ten-minutes.timer

systemctl --user enable --now minute.timer