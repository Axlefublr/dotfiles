#!/usr/bin/env fish

sudo ln -sf ~/prog/dotfiles/scripts/systemd/services/* /etc/systemd/system
sudo ln -sf ~/prog/dotfiles/scripts/systemd/timers/* /etc/systemd/system

sudo systemctl daemon-reload

sudo systemctl enable monthly.timer
sudo systemctl start monthly.timer
sudo systemctl enable saturday.timer
sudo systemctl start saturday.timer
sudo systemctl enable sunday.timer
sudo systemctl start sunday.timer