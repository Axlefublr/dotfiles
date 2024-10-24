#!/usr/bin/env fish

# X
ln -sf ~/prog/dotfiles/x11/xresources ~/.Xresources
ln -sf ~/prog/dotfiles/x11/.XCompose ~/.XCompose

# Paru
mkdir -p ~/.config/paru
ln -sf ~/prog/dotfiles/paru.conf ~/.config/paru/paru.conf

# Xremap
sudo usermod -aG input $USER
sudo usermod -aG video $USER
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules

# Awesome wm
mkdir -p ~/.config/awesome
rm -fr ~/.config/awesome
ln -sf ~/prog/dotfiles/awesome ~/.config/
ln -sf ~/prog/dotfiles/awesome/awesome.lua ~/.config/awesome/rc.lua

# Helix
cd ~/prog/forks
gh-repo-clone Axlefublr/helix
cd ~/prog/forks/helix
cargo install --path helix-term --locked
ln -sf ~/prog/dotfiles/helix ~/.config
mkdir -p ~/.cargo/bin/
rm -fr ~/.cargo/bin/runtime
ln -sf ~/prog/forks/helix/runtime ~/.cargo/bin/

# Fish shell
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
ln -sf ~/prog/dotfiles/fish/config.fish ~/.config/fish/config.fish

# Kitty terminal
mkdir -p ~/.config/kitty
ln -sf ~/prog/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/prog/dotfiles/kitty/theme.conf ~/.config/kitty/current-theme.conf

# Lazygit
mkdir -p ~/.config/lazygit
ln -sf ~/prog/dotfiles/lazygit.yml ~/.config/lazygit/config.yml

# Yazi
rm -fr ~/.config/yazi
ln -s ~/prog/dotfiles/yazi ~/.config
ya pack -a yazi-rs/plugins:hide-preview
ya pack -a yazi-rs/plugins:jump-to-char
ya pack -a Ape/open-with-cmd
ya pack -a KKV9/compress

# Brillo
begin
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"'
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"'
end | sudo tee /etc/udev/rules.d/backlight.rules

# Ttyper
ln -sf ~/.local/share/magazine/U ~/.config/ttyper/language/uclanr

# Neovim
# trash-put ~/.config/nvim
# mkdir -p ~/.config/nvim
# for file in ~/prog/dotfiles/!nvim/*
#     ln -sf $file ~/.config/nvim
# end
# for file in ~/prog/dotfiles/!nvim/.*
#     ln -sf $file ~/.config/nvim
# end

# Alacritty
# mkdir -p ~/.config/alacritty
# ln -sf ~/prog/dotfiles/alacritty.toml ~/.config/alacritty.toml

# Vscode
# mkdir -p ~/.config/Code/User
# ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
# ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
# Needed for the CSS & JS extension
# sudo chown -R $(whoami) $(which code)
# sudo chown -R $(whoami) /opt/visual-studio-code

# Picom
mkdir -p ~/.config/picom
ln -sf ~/prog/dotfiles/picom.conf ~/.config/picom/picom.conf

# Gromit-mpx
ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg
sudo ln -sf ~/prog/dotfiles/desktop/gromit-mpx.desktop /usr/share/applications/net.christianbeier.Gromit-MPX.desktop

# Rust formatting
mkdir -p ~/.config/rustfmt
ln -sf ~/prog/dotfiles/defconf/rustfmt.toml ~/.config/rustfmt/rustfmt.toml

# Bacon
mkdir -p ~/.config/bacon
ln -sf ~/prog/dotfiles/bacon/prefs.toml ~/.config/bacon/prefs.toml

# Yt-dlp
ln -sf ~/prog/dotfiles/yt-dlp.conf ~/yt-dlp.conf

# Less
sudo ln -sf ~/prog/dotfiles/lesskey /opt/lesskey

# Twemoji
sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf

# Mpv
mkdir -p ~/.config/mpv
ln -sf ~/prog/dotfiles/mpv/* ~/.config/mpv
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-matroska

# Rofi
mkdir -p ~/.config/rofi
ln -sf ~/prog/dotfiles/rofi.rasi ~/.config/rofi/config.rasi
sudo ln -sf /usr/bin/rofi /usr/bin/dmenu

# Screenkey
sudo ln -sf ~/prog/dotfiles/desktop/screenkey.desktop /usr/share/applications

# Tsoding/boomer
cd ~/prog
git clone https://github.com/tsoding/boomer
cd boomer
nimble build
ln -sf ~/prog/dotfiles/boomer.conf ~/.config/boomer/config

# Ghostty
cd ~/prog/stored
gh repo clone https://github.com/ghostty-org/ghostty -- --depth 1
cd ghostty
zig build -p $HOME/.local -Doptimize=ReleaseFast -Dapp-runtime=gtk
mkdir -p ~/.config/ghostty
ln -sf ~/prog/dotfiles/ghostty.conf ~/.config/ghostty/config

# Zathura
mkdir -p ~/.config/zathura
ln -sf ~/prog/dotfiles/zathura ~/.config/zathura/zathurarc
xdg-mime default org.pwmt.zathura.desktop application/pdf

# Display
ln -sf ~/prog/dotfiles/desktop/display.desktop ~/.local/share/applications/display.desktop
xdg-mime default display.desktop image/svg+xml
xdg-mime default display.desktop image/png
xdg-mime default display.desktop image/jpeg
xdg-mime default display.desktop image/gif
xdg-mime default display.desktop image/webp

# Ruff
mkdir -p ~/.config/ruff
ln -sf ~/prog/dotfiles/defconf/pyproject.toml ~/.config/ruff/pyproject.toml

# Krita
mkdir -p ~/.local/share/color-schemes
ln -f ~/prog/dotfiles/krita/gruvbox.colors ~/.local/share/krita/color-schemes

# Eww
cd ~/prog/stored
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features x11
ln $PWD/target/release/eww ~/prog/binaries
mkdir -p ~/.config/eww
touch ~/.config/eww/eww.yuck

# !Eww
rm -fr ~/prog/stored/eww
rm -fr ~/.config/eww
rm -fr ~/prog/binaries/eww

# Bubbly
curl https://raw.githubusercontent.com/siduck/bubbly/buttons/install.sh | sh

# !Bubbly
# rm -fr ~/.local/share/bubbly
# rm -fr ~/.config/bubbly
# rm -fr ~/.local/share/applications/bubbly.desktop

# Tridactyl
# :nativeinstall
# to copy the command to execute
mkdir -p ~/.config/tridactyl
ln -f ~/prog/dotfiles/tridactyl ~/.config/tridactyl/tridactylrc

# Postgresql
ln -sf ~/prog/dotfiles/psqlrc ~/.psqlrc
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
