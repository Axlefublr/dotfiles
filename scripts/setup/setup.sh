gh auth login

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

mkdir -p ~/.local/share/magazine
mkdir -p ~/.local/share/minigun

sudo loginctl enable-linger $USER

sudo systemctl enable sddm
sudo systemctl start sddm

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# xdg-mime query filetype
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/mp4