#!/usr/bin/env fish

ln -sf ~/prog/dotfiles/scripts/systemd/services/* ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/timers/* ~/.config/systemd/user

systemctl --user daemon-reload

systemctl --user enable monthly.timer
systemctl --user start monthly.timer
systemctl --user enable saturday.timer
systemctl --user start saturday.timer
systemctl --user enable sunday.timer
systemctl --user start sunday.timer
systemctl --user enable daily.timer
systemctl --user start daily.timer