gh auth login

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

mkdir -p ~/.local/share/magazine
mkdir -p ~/.local/share/minigun

sudo loginctl enable-linger $USER

sudo systemctl enable --now sddm

sudo systemctl enable --now bluetooth.service

sudo systemctl enable --now paccache.timer

# xdg-mime query filetype
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-matroska