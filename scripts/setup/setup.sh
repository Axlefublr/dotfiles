gh auth login
gh auth refresh -h github.com -s delete_repo

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

sudo loginctl enable-linger $USER

sudo systemctl enable --now sddm

sudo systemctl enable --now bluetooth.service

sudo systemctl enable --now paccache.timer