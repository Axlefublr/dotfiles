#!/usr/bin/env fish

mkdir -p ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/services/* ~/.config/systemd/user
ln -sf ~/prog/dotfiles/scripts/systemd/timers/* ~/.config/systemd/user

systemctl --user daemon-reload

systemctl --user enable daily.timer
systemctl --user start daily.timer

systemctl --user enable monthly.timer
systemctl --user start monthly.timer

systemctl --user enable monday.timer
systemctl --user start monday.timer

systemctl --user enable thursday.timer
systemctl --user start thursday.timer

systemctl --user enable saturday.timer
systemctl --user start saturday.timer

systemctl --user enable sunday.timer
systemctl --user start sunday.timer

systemctl --user enable 27.timer
systemctl --user start 27.timer

systemctl --user enable 18.timer
systemctl --user start 18.timer