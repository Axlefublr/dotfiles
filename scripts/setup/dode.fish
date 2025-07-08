#!/usr/bin/env fish

# ---------------8bitdo---------------
echo 'ACTION=="add", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="81HD", RUN+="/sbin/modprobe xpad", RUN+="/bin/sh -c \'echo 2dc8 81HD > /sys/bus/usb/drivers/xpad/new_id\'"' | sudo tee /etc/udev/rules.d/99-8bitdo-xinput.rules
sudo udevadm control --reload

# ---------------aichat---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout aichat

# ----------------aichat!----------------
paru -Rns aichat
rm -fr ~/.config/aichat

# ---------------alacritty---------------
sudo pacman -S alacritty
mkdir -p ~/.config/alacritty
ln -sf ~/fes/dot/alacritty.toml ~/.config/alacritty.toml

# ---------------anki---------------
paru -Sa --needed --disable-download-timeout anki
# paru -Sa --needed --disable-download-timeout anki-bin

# ---------------antimicrox---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout antimicrox

# ---------------ascii-image-converter---------------
paru -Sa --needed --disable-download-timeout ascii-image-converter-bin

# ---------------asciinema---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout asciinema

# ---------------awm---------------
sudo pacman -S awesome
mkdir -p ~/.config/awesome
rm -fr ~/.config/awesome
ln -sf ~/fes/dot/awesome ~/.config/
ln -sf ~/fes/dot/awesome/awesome.lua ~/.config/awesome/rc.lua

# ---------------bacon---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout bacon
bacon --prefs
ln -sf ~/fes/dot/bacon.toml ~/.config/bacon/prefs.toml

# ---------------bat---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout bat
set -Ux BAT_THEME ansi
set -Ux BAT_STYLE plain

# ---------------bluetui---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout bluetui
mkdir -p ~/.config/bluetui
ln -sf ~/fes/dot/bluetui.toml ~/.config/bluetui/config.toml

# ---------------brillo---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout brillo
begin
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"'
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"'
end | sudo tee /etc/udev/rules.d/backlight.rules

# ---------------boomer---------------
cd ~/fes/ork
git clone https://github.com/Axlefublr/boomer
cd boomer
nimble build
ln -sf ~/fes/dot/boomer.conf ~/.config/boomer/config

# ---------------bottles---------------
flatpak install com.usebottles.bottles

# ---------------bottom---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout bottom
ln -sf ~/fes/dot/bottom.toml ~/.config/bottom/bottom.toml

# ---------------bubbly---------------
curl https://raw.githubusercontent.com/siduck/bubbly/buttons/install.sh | sh

# ---------------bubbly!--------------
rm -fr ~/.local/share/bubbly
rm -fr ~/.config/bubbly
rm -fr ~/.local/share/applications/bubbly.desktop

# ---------------calcure---------------
uv tool install calcure
mkdir -p ~/.config/calcure
ln -sf ~/fes/dot/calcure.ini ~/.config/calcure/config.ini
cp -fr ~/fes/eli/calcure.csv ~/.config/calcure/events.csv

# ---------------cargo-script---------------
cargo binstall -y cargo-script

# ----------------cargo-script!----------------
rm -fr ~/.cargo/binary_cache
rm -fr ~/.cargo/script_cache

# ---------------cava---------------
paru -Sa --needed --disable-download-timeout cava

# ----------------cava!----------------
paru -Rns cava
rm -fr ~/.config/cava

# ---------------cbonsai---------------
paru -Sa --needed --disable-download-timeout cbonsai

# ---------------cliphist---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout cliphist
systemctl --user enable --now ~/fes/dot/systemd/cliphist-text.service
systemctl --user enable --now ~/fes/dot/systemd/cliphist-image.service

# ---------------countryfetch---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout countryfetch

# ---------------cowsay---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout cowsay

# ---------------cursors---------------
# Lighted Pixel Butter — https://www.gnome-look.org/p/2103612
sudo cp -fr ~/iwm/dls/cursors/Lighted-Pixel-Butter /usr/share/icons
# this is only needed because firefox is stupid and reverts to Adwaita for some reason
sudo ln -sn /usr/share/icons/Lighted-Pixel-Butter /usr/share/icons/mine
sudo cp -fr /usr/share/icons/Adwaita/cursors{,.bak}
for file in /usr/share/icons/Adwaita/cursors/*
    sudo ln -sf /usr/share/icons/mine/cursors/(path basename $file) $file
end

# ---------------discord---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout discord

# ---------------dns---------------
begin
    echo 'nameserver 1.1.1.1' # cloudflare DNS server
    echo 'nameserver 8.8.8.8' # google DNS server
    sudo cat /etc/resolv.conf
end | sponge | sudo tee /etc/resolv.conf

# keep lowering this until it's okay
ping -c 4 -M do -s 1472 google.com
sudo ip link set dev wlan0 mtu $optimal_value

# ---------------enter-the-gungeon-mod---------------
~/fes/ack/bepinx.sh # https://github.com/pcrain/gungeon-modding-tools/blob/master/steamdeck-installer.md
# add "/home/axlefublr/.local/share/Steam/steamapps/common/Enter the Gungeon/start_game_bepinex.sh" to steam as non-steam game

# ---------------etcher---------------
paru -Sa --needed --disable-download-timeout etcher-cli-bin

# ---------------exrex---------------
uv tool install exrex

# ---------------eww---------------
cd ~/fes/ork
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features x11
ln $PWD/target/release/eww ~/fes/bin
mkdir -p ~/.config/eww
touch ~/.config/eww/eww.yuck

# ----------------eww!----------------
rm -fr ~/fes/ork/eww
rm -fr ~/.config/eww
rm -fr ~/fes/bin/eww

# ---------------fancontrol---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout lm_sensors
sudo sensors-detect
sudo pwmconfig
sudo -E helix /etc/fancontrol
sudo mkdir -p /etc/systemd/system/fancontrol.service.d
sudo ln -f ~/fes/dot/systemd/fancontrol.systemd /etc/systemd/system/fancontrol.service.d/mine.conf
sudo systemctl enable --now fancontrol

# ---------------fifc---------------
fisher install gazorby/fifc
set -Ux fifc_editor helix
# set -Ux fifc_fd_opts -u
set -Ux fifc_keybinding \cn

# ---------------figlet---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout figlet

# ---------------firefox---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout firefox
set -Ux MOZ_ENABLE_WAYLAND 1
set -Ux GTK_THEME Adwaita:dark
set -l prof_dir ~/.mozilla/firefox/fqigcjz6.default-release
mkdir $prof_dir/chrome
ln -sf ~/fes/dot/firefox/userChrome.css $prof_dir/chrome
ln -sf ~/fes/dot/firefox/userContent.css $prof_dir/chrome

# version 133.0
# /etc/pacman.conf
# IgnorePkg=firefox

# ---------------floorp---------------
paru -Sa --needed --disable-download-timeout floorp-bin

# in the alt menu, CSS -> CSS -> Create browser CSS file
# then Open CSS folder; you'll arrive around here
# ~/.floorp/zxvqwt0m.default-release/chrome/CSS
rm -fr ~/.floorp/zxvqwt0m.default-release/chrome
ln -sf ~/fes/dot/floorp ~/.floorp/zxvqwt0m.default-release/chrome

# devtools.debugger.prompt-connection
# devtools.inspector.remote
# ui.key.menuAccessKeyFocuses
# ui.key.menuAccessKey to -1
# mousewheel.default.delta_multiplier_y
# floorp.newtab.overrides.newtaburl file:///home/axlefublr/fes/lai/annabirch/index.html

# enable shortcuts in address bar

# custom shortcut on ^!' to focus main page after focusing address bar
# document.querySelector("browser[primary='true']").focus()

# custom shortcut for moving the current tab to the next / previous workspace
# (async () => {
#     const currentTab = window.gBrowser.selectedTab;
#     const workspaces = await gWorkspaces.getAllWorkspacesId();
#     const current = await gWorkspaces.getCurrentWorkspaceId();
#     const currentIndex = workspaces.indexOf(current);
#     let destinationIndex = currentIndex - 1;
#     if (destinationIndex >= workspaces.length) {
#         destinationIndex = 0;
#     }
#     const destination = workspaces.at(destinationIndex);
#     await gWorkspaces.changeWorkspace(destination, null, false, true);
# })();

# (async () => {
#     const workspaces = await gWorkspaces.getAllWorkspacesId();
#     const current = await gWorkspaces.getCurrentWorkspaceId();
#     const currentIndex = workspaces.indexOf(current);
#     let destinationIndex = currentIndex - 1;
#     if (destinationIndex >= workspaces.length) {
#         destinationIndex = 0;
#     }
#     const destination = workspaces.at(destinationIndex);
#     await gWorkspaces.changeWorkspace(destination, null, false, true);
# })();

# ---------------fnott---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout fnott
mkdir -p ~/.config/fnott
ln -sf ~/fes/dot/fnott.ini ~/.config/fnott/fnott.ini

# ---------------fstab---------------
# automounting setup
sudo blkid # take UUIDs for the partitions here
sudo -E helix /etc/fstab
id -u # user_id
id -g # group_id
# UUID=the_uuid /mnt/usb ext4 defaults 0 2
# UUID=the_uuid /mnt/fatusb exfat defaults,uid=user_id,gid=group_id,dmask=0222,fmask=0111 0 0

# ---------------fonts---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout ttf-jetbrains-mono-nerd ttf-input ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono papirus-icon-theme
paru -Sa --needed --disable-download-timeout ttf-comfortaa

# ---------------foot---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout foot
mkdir -p ~/.config/foot
ln -sf ~/fes/dot/foot.ini ~/.config/foot/foot.ini
systemctl --user enable --now ~/fes/dot/systemd/foot.service

# ---------------fuck---------------
sudo pacman -Rns --noconfirm eos-update-notifier
sudo pacman -Rns --noconfirm nano-syntax-highlighting
sudo pacman -Rns --noconfirm htop
sudo pacman -Rns --noconfirm meld

# ---------------fuzzel---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout fuzzel
mkdir -p ~/.config/fuzzel
ln -sf ~/fes/dot/fuzzel.ini ~/.config/fuzzel/fuzzel.ini

# ---------------gamescope---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout gamescope

# ---------------gh---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout github-cli
gh auth login
gh auth refresh -h github.com -s delete_repo

# ---------------ghostty---------------
cd ~/fes/ork
git clone --depth=1 https://github.com/ghostty-org/ghostty
cd ghostty
zig build -p $HOME/.local -Doptimize=ReleaseFast -Dapp-runtime=gtk
mkdir -p ~/.config/ghostty
ln -sf ~/fes/dot/ghostty.conf ~/.config/ghostty/config

# ---------------git---------------
sudo pacman -Syyu git diff-so-fancy
# [[sort on]]
git config --global branch.sort -committerdate
git config --global checkout.defaultRemote origin
git config --global commit.verbose true
git config --global core.editor helix
git config --global core.pager "diff-so-fancy | ov"
git config --global credential.helper store
git config --global diff.colormoved default
git config --global diff.colormovedws allow-indentation-change
git config --global init.defaultBranch main
git config --global interactive.singleKey true
git config --global pull.ff only
git config --global push.autoSetupRemote true
git config --global rebase.updateRefs false
git config --global rerere.enabled false
git config --global user.email 101342105+Axlefublr@users.noreply.github.com
git config --global user.name Axlefublr
# [[sort off]]

# ---------------gitu---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout gitu
mkdir -p ~/.config/gitu
ln -sf ~/fes/dot/gitu.toml ~/.config/gitu/config.toml

# ---------------git-who---------------
stew install sinclairtarget/git-who

# ---------------gomi---------------
stew install babarot/gomi
ln -sf ~/fes/dot/gomi.yaml ~/.config/gomi/config.yaml

# ---------------gromit-mpx---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout gromit-mpx
ln -sf ~/fes/dot/gromit.cfg ~/.config/gromit-mpx.cfg
sudo ln -sf ~/fes/dot/desktop/gromit-mpx.desktop /usr/share/applications/net.christianbeier.Gromit-MPX.desktop

# ---------------grub---------------
sudo -E helix /etc/default/grub
# GRUB_TIMEOUT=5 -> GRUB_TIMEOUT=1
sudo grub-mkconfig -o /boot/grub/grub.cfg
# this breaks radeon gpu fix, don't forget to do that after!

# ---------------gtk-theme---------------
cd ~/fes/lai
gh repo clone Axlefublr/gruvbox-material-gtk-theme
sudo rm -fr /usr/share/themes/gruvbox-material
sudo ln -sf ~/fes/lai/gruvbox-material-gtk-theme /usr/share/themes/gruvbox-material
set -Ux GTK_THEME gruvbox-material

# ---------------helix---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout marksman taplo-cli lua lua-language-server vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver yaml-language-server prettier stylua python-toml
paru -Sa --needed --disable-download-timeout prettierd
cd ~/fes/ork
git clone --depth=1 https://github.com/Axlefublr/helix hx
cd hx
cargo install --path helix-term --locked
ln -sf ~/fes/dot/helix ~/.config
mkdir -p ~/.cargo/bin
rm -fr ~/.cargo/bin/runtime
ln -sf ~/fes/ork/hx/runtime ~/.cargo/bin
sudo ln -f ~/fes/bin/helix /usr/bin/helix

# ---------------httrack---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout httrack

# ---------------hyperfine---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout hyperfine

# ---------------jj---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout jj lazyjj
jj util completion fish | source
ln -sf ~/fes/dot/jj.toml ~/.config/jj/config.toml

# ---------------jpeg2png---------------
paru -Sa --needed --disable-download-timeout jpeg2png

# ---------------jq---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout jq jaq

# ---------------just---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout just
mkdir -p ~/.config/just
ln -sf ~/fes/dot/globaljustfile ~/.config/just/justfile

# ---------------kanata---------------
indeed.rs -u ~/.local/share/magazine/W -- '-a cmd_allowed -a ^exe -a ^macos https://github.com/jtroo/kanata'
eget (string split ' ' -- (tail -n 1 ~/.local/share/magazine/W))
systemctl --user enable --now ~/fes/dot/kanata/kanata.service

# ---------------kbt---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout kbt

# ---------------kitty---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout kitty
mkdir -p ~/.config/kitty
ln -sf ~/fes/dot/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/fes/dot/kitty/theme.conf ~/.config/kitty/current-theme.conf

# ---------------kondo---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout kondo
kondo --completions fish

# ---------------krita---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout krita
mkdir -p ~/.local/share/krita/color-schemes
ln -f ~/fes/dot/krita/gruvbox.colors ~/.local/share/krita/color-schemes/gruvbox.colors

# ---------------kruler---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout kruler

# ---------------lazygit---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout lazygit
mkdir -p ~/.config/lazygit
ln -sf ~/fes/dot/lazygit.yml ~/.config/lazygit/config.yml

# ---------------less---------------
sudo ln -sf ~/fes/dot/lesskey /opt/lesskey
set -Ux LESSKEYIN /opt/lesskey

# ---------------libreoffice---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout libreoffice-still

# ---------------locale---------------
# edit /etc/locale.conf to set what locale you want to use for what
# edit /etc/locale.gen to make that locale generate
sudo locale-gen # generate locales
reboot
locale # check locale health

# ---------------lolcat---------------
sudo pacman -S lolcat

# ---------------lxappearance---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout lxappearance gtk-engine-murrine qt5ct

# ---------------mapscii---------------
paru -Sa --needed --disable-download-timeout nodejs-mapscii

# ----------------mapscii!----------------
paru -Rns nodejs-mapscii
rm -fr ~/.mapscii

# ---------------mpv---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout mpv
sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps mpv-mpris
mkdir -p ~/.config/mpv
ln -sf ~/fes/dot/mpv/* ~/.config/mpv
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-matroska

# ---------------neovide---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout neovide
set -Ux NEOVIDE_FORK false

# ---------------niri---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout niri
sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring
sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps clang # for building from source
ln -sf ~/fes/dot/niri.kdl ~/.config/niri/config.kdl
mkdir -p ~/.config/systemd/user/niri.service.wants
niri completions fish >~/.config/fish/completions/niri.fish

# ---------------nom---------------
# paru -Sa --needed --disable-download-timeout nom
stew install guyfedwards/nom
mkdir -p ~/.config/nom
ln -sf ~/fes/dot/nom.yml ~/.config/nom/config.yml
cp -f ~/fes/eli/nom.db ~/.config/nom/nom.db
ln -sf ~/fes/dot/desktop/nom.desktop ~/.local/share/applications/nom.desktop

# -------------nushell-------------
sudo pacman -S --needed --noconfirm --disable-download-timeout nushell
ln -sf ~/fes/dot/nu/nonf.nu ~/.config/nushell/config.nu
rm -fr ~/.config/nushell/scripts
ln -s ~/fes/dot/nu/blue ~/.config/nushell/scripts
# in nushell
plugin add /usr/bin/nu_plugin_formats
plugin add /usr/bin/nu_plugin_gstat

# ---------------nvim---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout neovim luarock
trash-put ~/.config/nvim
mkdir -p ~/.config/nvim
for file in ~/fes/dot/!nvim/*
    ln -sf $file ~/.config/nvim
end
for file in ~/fes/dot/!nvim/.*
    ln -sf $file ~/.config/nvim
end

# ---------------other---------------
sudo loginctl enable-linger $USER
sudo systemctl enable --now paccache.timer

# ---------------ouch---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout ouch

# ---------------ov---------------
cd ~/fes/ork
gh repo clone Axlefublr/ov
cd ov
make
sudo install ov ~/.local/bin
# stew install noborus/ov
sudo ln -f ~/.local/bin/ov /usr/bin/ov
ov --completion fish >~/.config/fish/completions/ov.fish
mkdir -p ~/.config/ov
ln -sf ~/fes/dot/ov.yaml ~/.config/ov/config.yaml
set -Ux PAGER ov
set -Ux SYSTEMD_PAGERSECURE true
set -Ux SYSTEMD_PAGER ov

# ---------------paru---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout paru
mkdir -p ~/.config/paru
ln -sf ~/fes/dot/paru.conf ~/.config/paru/paru.conf

# ---------------picom---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout picom
mkdir -p ~/.config/picom
ln -sf ~/fes/dot/picom.conf ~/.config/picom/picom.conf

# ---------------pik---------------
cargo binstall -y pik
mkdir -p ~/.config/pik
ln -sf ~/fes/dot/pik.toml ~/.config/pik/config.toml

# ---------------pipes---------------
# visual lines going all over the screen
paru -Sa --needed --disable-download-timeout bash-pipes

# ---------------postgresql---------------
sudo pacman -S postgresql
ln -sf ~/fes/dot/psqlrc ~/.psqlrc
sudo -iu postgres initdb -D /var/lib/postgres/data
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo usermod -aG postgres $USER
sudo setfacl -R -m u:axlefublr:rwx /var/lib/postgres/data
nvim /var/lib/postgres/data/postgresql.conf # listen_addresses = '*'
sudo sed -i '/^host/s/ident/md5/' /var/lib/postgres/data/pg_hba.conf
sudo sed -i '/^local/s/peer/trust/' /var/lib/postgres/data/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /var/lib/postgres/data/pg_hba.conf
sudo setfacl -R -x u:axlefublr /var/lib/postgres/data
sudo systemctl restart postgresql
sudo ufw allow 5432/tcp
sudo touch /var/lib/postgres/.psql_history
sudo chown postgres:postgres /var/lib/postgres/.psql_history
psql -U postgres -c "ALTER USER postgres PASSWORD '$(read -sP 'enter your password: ')'"
cd ~/Documents
curl -O https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
rm -fr dvdrental.zip
psql -U postgres -c 'CREATE DATABASE dvdrental;'
pg_restore -U postgres --dbname=dvdrental --verbose dvdrental.tar
rm -fr dvdrental.tar
psql -U postgres -d dvdrental -c 'SELECT count(*) FROM film;' -c 'SELECT version();'
# set -Ux PGDATABASE dvdrental
# set -Ux PGUSER postgres

sudo systemctl disable postgresql

# ---------------pueue---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout pueue
systemctl --user enable --now pueued
ln -sf ~/fes/dot/pueue.yml ~/.config/pueue/pueue.yml

# ---------------qalc---------------
sudo pacman -S libqalculate
# set vspace off
# set curconv off
# set update exchange rates 1
# set decimal comma off

# ---------------qbittorrent---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout qbittorrent
xdg-mime default qbittorrent.desktop application/x-bittorrent

# ---------------qrtool---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout qrtool
qrtool --generate-completion fish >~/.config/fish/completions/qrtool.fish

# ---------------radeon-gpu---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout amdvlk lib32-amdvlk
# in `lspci -k`, "kernel driver in use" should be amdgpu
# if it's not, do the following:
sudo -E helix /boot/grub/grub.cfg
# append the line that starts with `linux` (on the first entry; the one that's booted) with:
# radeon.si_support=0 amdgpu.si_support=1
# radeon.cik_support=0 amdgpu.cik_support=1
# after rebooting with these in play, `lspci -k` should now display the amdgpu driver

# ---------------ratbagd---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout libratbag
systemctl enable --now ratbagd.service
sudo pacman -S --needed --noconfirm --disable-download-timeout piper

# ---------------repgrep---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout repgrep

# ---------------rnote---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout rnote

# ---------------rofi---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout rofi-wayland
mkdir -p ~/.config/rofi
ln -sf ~/fes/dot/rofi.rasi ~/.config/rofi/config.rasi
sudo ln -sf /usr/bin/rofi /usr/bin/dmenu

# ---------------satty---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout satty
mkdir -p ~/.config/satty
ln -sf ~/fes/dot/satty.toml ~/.config/satty/config.toml

# ---------------scc---------------
stew install boyter/scc

# ---------------screenkey---------------
sudo pacman -S screenkey
sudo ln -sf ~/fes/dot/desktop/screenkey.desktop /usr/share/applications

# ---------------scriptisto---------------
cargo binstall -y scriptisto

# ---------------sd---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout sd

# ---------------sddm---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout sddm
sudo systemctl enable --now sddm

# ---------------serpl---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout serpl
paru -Sa --needed --disable-download-timeout ast-grep-bin
mkdir -p ~/.config/serpl
ln -sf ~/fes/dot/serpl.yml ~/.config/serpl/serpl.yml

# ---------------snowmachine---------------
uv tool install snowmachine

# ---------------speedtest---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout speedtest-cli

# ---------------spotify---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout spotify-launcher
# edit /usr/share/applications/spotify-launcher.desktop to have `env DISPLAY=:1.0` in exec

# ---------------ssh---------------
systemctl --user enable --now ~/fes/ack/socksproxy.service

# ---------------steam---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout steam-native-runtime
# run the thing via env to set DISPLAY and to unset http_proxy, https_proxy, all_proxy
sudo -E helix /usr/share/applications/steam-native.desktop

# ---------------sttr---------------
indeed.rs -u ~/.local/share/magazine/W -- '-a tar.gz -a ^sbom.json https://github.com/abhimanyu003/sttr'
eget (string split ' ' -- (tail -n 1 ~/.local/share/magazine/W))

# ---------------swappy---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout swappy

# ---------------swaybg---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout swaybg
ln -sf ~/fes/dot/swaybg/swaybg.service ~/.config/systemd/user/swaybg.service
mkdir -p ~/.config/systemd/user/swaybg.service.d
ln -sf ~/fes/dot/swaybg/swaybg.systemd ~/.config/systemd/user/swaybg.service.d/mine.conf
systemctl --user enable --now swaybg.service

# ---------------swayimg---------------
mkdir -p ~/.local/share/applications/
ln -sf ~/fes/dot/desktop/swayimg.desktop ~/.local/share/applications/swayimg.desktop
xdg-mime default swayimg.desktop image/svg+xml
xdg-mime default swayimg.desktop image/png
xdg-mime default swayimg.desktop image/jpeg
xdg-mime default swayimg.desktop image/gif
xdg-mime default swayimg.desktop image/webp
mkdir -p ~/.config/swayimg
ln -sf ~/fes/dot/swayimg.ini ~/.config/swayimg/config

# ---------------swww---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout swww
systemctl --user enable --now ~/fes/dot/systemd/swww.service

# -------------------systemd-------------------
mkdir -p ~/.config/systemd/user

not test -f /usr/lib/systemd/system-sleep/suspend-handler.fish && sudo ln -f ~/fes/dot/systemd/suspend-handler.fish /usr/lib/systemd/system-sleep/suspend-handler.fish

systemctl --user link ~/fes/dot/systemd/minute.service
systemctl --user enable --now ~/fes/dot/systemd/minute.timer

systemctl --user link ~/fes/dot/systemd/daily.service
systemctl --user enable --now ~/fes/dot/systemd/daily.timer

systemctl --user link ~/fes/dot/systemd/ten-minutes.service
systemctl --user enable --now ~/fes/dot/systemd/ten-minutes.timer

# systemctl --user link ~/fes/dot/systemd/wake.service
# systemctl --user enable --now ~/fes/dot/systemd/wake.path

systemctl --user link ~/fes/dot/systemd/frizz.service
systemctl --user enable --now ~/fes/dot/systemd/frizz.path

systemctl --user link ~/fes/dot/systemd/flipboard.service
systemctl --user enable --now ~/fes/dot/systemd/flipboard.path

systemctl --user enable --now ~/fes/dot/systemd/axleizer.service

systemctl --user link ~/fes/dot/systemd/wallpaper.service
systemctl --user enable --now ~/fes/dot/systemd/wallpaper.timer

# ---------------termfilechooser---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout xdg-desktop-portal-gtk
paru -Sa --needed --disable-download-timeout xdg-desktop-portal-termfilechooser-git
fish_add_path /usr/lib
set -Ux TERMCMD foot
set -Ux GDK_DEBUG portals
set -Ux GTK_USE_PORTAL 1
mkdir -p ~/.config/xdg-desktop-portal-termfilechooser
ln -sf ~/fes/dot/termfilechooser/config ~/.config/xdg-desktop-portal-termfilechooser/config
sudo mkdir -p /usr/local/share/xdg-desktop-portal-termfilechooser
sudo ln -sf ~/fes/dot/termfilechooser/yazi-wrapper.sh /usr/local/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
mkdir -p ~/.config/xdg-desktop-portal
ln -sf ~/fes/dot/termfilechooser/portals.conf ~/.config/xdg-desktop-portal/portals.conf
systemctl --user restart xdg-desktop-portal.service
systemctl --user restart xdg-desktop-portal-termfilechooser.service
# for firefox
# widget.use-xdg-desktop-portal.file-picker 1
# middlemouse.paste

# ---------------termpicker---------------
stew install ChausseBenjamin/termpicker

# ---------------tewi---------------
uv tool install tewi-transmission

# ---------------tiptop---------------
uv tool install tiptop

# ---------------traceroute---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout traceroute

# ---------------transmission---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout transmission-cli
ln -sf ~/fes/dot/transmission/transmission.json ~/.config/transmission-daemon/settings.json
systemctl --user enable --now ~/fes/dot/transmission/transmission.service

# ---------------tridactyl---------------
# :nativeinstall
# to copy the command to execute
mkdir -p ~/.config/tridactyl
ln -f ~/fes/dot/tridactyl ~/.config/tridactyl/tridactylrc

# ---------------ttyper---------------
sudo pacman -S ttyper
ln -sf ~/.local/share/magazine/U ~/.config/ttyper/language/uclanr

# ---------------tuisky---------------
cargo binstall -y tuisky

# ---------------twemoji---------------
paru -Sa --needed --disable-download-timeout ttf-twemoji
sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf

# ---------------tz---------------
indeed.rs -u ~/.local/share/magazine/W -- '-a .tar.gz https://github.com/oz/tz'
eget (string split ' ' -- (tail -n 1 ~/.local/share/magazine/W))

# ---------------unimatrix---------------
paru -Sa --needed --disable-download-timeout unimatrix-git

# ----------------vesktop----------------
indeed.rs -u ~/.local/share/magazine/W -- '-a AppImage -a ^arm https://github.com/Vencord/Vesktop'
eget (string split ' ' -- (tail -n 1 ~/.local/share/magazine/W))

# ---------------vscode---------------
mkdir -p ~/.config/Code/User
ln -sf ~/fes/dot/vscode/settings.jsonc ~/.config/Code/User/settings.json
ln -sf ~/fes/dot/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
# Needed for the CSS & JS extension
sudo chown -R $(whoami) $(which code)
sudo chown -R $(whoami) /opt/visual-studio-code

# ---------------waybar---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout waybar
sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps otf-font-awesome
mkfifo ~/.local/share/mine/waybar-screen-record
mkdir -p ~/.config/waybar
ln -sf ~/fes/dot/waybar/waybar.jsonc ~/.config/waybar/config.jsonc
ln -sf ~/fes/dot/waybar/waybar.css ~/.config/waybar/style.css
ln -sf /usr/lib/systemd/user/waybar.service ~/.config/systemd/user/niri.service.wants/waybar.service
mkdir -p ~/.config/systemd/user/waybar.service.d
ln -sf ~/fes/dot/waybar/waybar.systemd ~/.config/systemd/user/waybar.service.d/mine.conf

# ---------------waytext---------------
cd ~/fes/ork
gh repo clonef https://github.com/jeffa5/waytext
cd waytext
make build
make install

# ---------------wf-recorder---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout wf-recorder

# ---------------whois---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout whois

# ----------------wlclock----------------
cd ~/fes/ork
gh repo clone Axlefublr/wlclock
mkdir build
cd build
cmake ..
make
rsync ./wlclock ~/fes/bin

# ---------------wl-kbptr---------------
paru -Sa --needed --disable-download-timeout wl-kbptr
mkdir -p ~/.config/wl-kbptr
ln -sf ~/fes/dot/wlkbptr.ini ~/.config/wl-kbptr/config

# ---------------wob---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout wob

# ---------------woomer---------------
# dependencies are still needed for runtime, despite this being in binaries
sudo pacman -S --needed --noconfirm --disable-download-timeout glfw-wayland glfw
cd ~/fes/ork
gh repo clonef https://github.com/coffeeispower/woomer
cd woomer
rs bin message

# ---------------wooz---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout meson ninja cmake wayland-protocols
cd ~/fes/ork
gh repo clonef https://github.com/negrel/wooz
cd wooz
export CFLAGS="-O3"
meson build
ninja -C build
cp -f ./build/wooz ~/fes/bin/wooz

# ---------------wtf---------------
# “wtf is curl” — quickly explains a rRam
paru -Sa --needed --disable-download-timeout wtf

# ---------------x---------------
ln -sf ~/fes/dot/x11/xresources ~/.Xresources
ln -sf ~/fes/dot/x11/.XCompose ~/.XCompose
set -Ux XMODIFIERS @im=none

# ---------------xremap---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout xremap-wlroots-bin
sudo usermod -aG input $USER
sudo usermod -aG video $USER
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules

# ---------------xwayland-satellite---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout xwayland-satellite
set -Ux DISPLAY :0
systemctl --user enable --now ~/fes/dot/systemd/xwayland-satellite.service

# ---------------yazi---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout yazi
rm -fr ~/.config/yazi
ln -s ~/fes/dot/yazi ~/.config
# ya pkg add yazi-rs/plugins:jump-to-char
# ya pkg add Ape/open-with-cmd
ya pkg add KKV9/compress
ya pkg add yazi-rs/plugins:toggle-pane
ya pkg add yazi-rs/plugins:types
ya pack -a lpanebr/yazi-plugins:first-non-directory
ya pkg add yazi-rs/plugins:smart-enter
ln -sf ~/fes/dot/desktop/yazi-outside.desktop ~/.local/share/applications/yazi.desktop
xdg-mime default yazi.desktop inode/directory

# ---------------ydotool---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout ydotool
# now run ydotool somehow

# ---------------yt-dlp---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout yt-dlp
sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps python-mutagen
mkdir -p ~/.config/yt-dlp
ln -sf ~/fes/dot/yt-dlp.conf ~/.config/yt-dlp/config

# ---------------zathura---------------
sudo pacman -S zathura
sudo pacman -S zathura-pdf-mupdf
mkdir -p ~/.config/zathura
ln -sf ~/fes/dot/zathura ~/.config/zathura/zathurarc
xdg-mime default org.pwmt.zathura.desktop application/pdf

# ---------------zola---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout zola

# ---------------zoom---------------
paru -Sa --needed --disable-download-timeout zoom

# ---------------zoxide---------------
sudo pacman -S --needed --noconfirm --disable-download-timeout zoxide
set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
set -Ux _ZO_MAXAGE 30000
cp -fr ~/fes/eli/zoxide.db ~/.local/share/zoxide/db.zo
