#!/usr/bin/env fish

mkdir -p ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/services/* ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/timers/* ~/.config/systemd/user

systemctl --user daemon-reload

systemctl --user enable --now daily.timer

systemctl --user enable --now monthly.timer

systemctl --user enable --now monday.timer

systemctl --user enable --now thursday.timer

systemctl --user enable --now saturday.timer

systemctl --user enable --now sunday.timer

systemctl --user enable --now 27.timer

systemctl --user enable --now 18.timer

systemctl --user enable --now ten-minutes.timer

systemctl --user enable --now minute.timer