gh auth login

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

mkdir -p ~/.local/share/magazine
mkdir -p ~/.local/share/minigun

sudo loginctl enable-linger $USER

sudo systemctl enable --now sddm

sudo systemctl enable --now bluetooth.service

sudo systemctl enable --now paccache.timer