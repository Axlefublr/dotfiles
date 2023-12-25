gh auth login

sudo systemctl enable cronie.service
sudo systemctl start cronie.service

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"