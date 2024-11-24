#!/usr/bin/env fish

gh auth login
gh auth refresh -h github.com -s delete_repo

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

sudo loginctl enable-linger $USER

sudo systemctl enable --now sddm

sudo systemctl enable --now bluetooth.service

sudo systemctl enable --now paccache.timer

begin
    echo 'nameserver 1.1.1.1' # cloudflare DNS server
    echo 'nameserver 8.8.8.8' # google DNS server
    sudo cat /etc/resolv.conf
end | sponge | sudo tee /etc/resolv.conf

# keep lowering this until it's okay
ping -c 4 -M do -s 1472 google.com
sudo ip link set dev wlan0 mtu $optimal_value

# Lighted Pixel Butter — https://www.gnome-look.org/p/2103612
# Gruvbox Dark BL — https://www.gnome-look.org/p/1681313
