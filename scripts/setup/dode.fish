#!/usr/bin/env fish

function dode-aichat
    sudo pacman -S --needed --noconfirm --disable-download-timeout aichat
end
function edod-aichat
    paru -Rns aichat
    rm -fr ~/.config/aichat
end

function dode-alacritty
    sudo pacman -S alacritty
    mkdir -p ~/.config/alacritty
    ln -sf ~/r/dot/alacritty.toml ~/.config/alacritty.toml
end

function dode-anki
    paru -Sa --needed --disable-download-timeout anki
    # paru -Sa --needed --disable-download-timeout anki-bin
end

function dode-ascii-image-converter
    paru -Sa --needed --disable-download-timeout ascii-image-converter-bin
end

function dode-asciinema
    sudo pacman -S --needed --noconfirm --disable-download-timeout asciinema
end

function dode-awm
    sudo pacman -S awesome
    mkdir -p ~/.config/awesome
    rm -fr ~/.config/awesome
    ln -sf ~/r/dot/awesome ~/.config/
    ln -sf ~/r/dot/awesome/awesome.lua ~/.config/awesome/rc.lua
end

function dode-bat
    sudo pacman -S --needed --noconfirm --disable-download-timeout bat
    set -Ux BAT_THEME ansi
    set -Ux BAT_STYLE plain
end

function dode-bluetui
    sudo pacman -S --needed --noconfirm --disable-download-timeout bluetui
    mkdir -p ~/.config/bluetui
    ln -sf ~/r/dot/bluetui.toml ~/.config/bluetui/config.toml
end

function dode-brillo
    sudo pacman -S --needed --noconfirm --disable-download-timeout brillo
    begin
        echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"'
        echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"'
    end | sudo tee /etc/udev/rules.d/backlight.rules
end

function dode-boomer
    cd ~/r/forks
    git clone https://github.com/Axlefublr/boomer
    cd boomer
    nimble build
    ln -sf ~/r/dot/boomer.conf ~/.config/boomer/config
end

function dode-bottles
    flatpak install com.usebottles.bottles
end

function dode-bottom
    sudo pacman -S --needed --noconfirm --disable-download-timeout bottom
    ln -sf ~/r/dot/bottom.toml ~/.config/bottom/bottom.toml
end

function dode-bubbly
    curl https://raw.githubusercontent.com/siduck/bubbly/buttons/install.sh | sh
end
function edod-bubbly
    rm -fr ~/.local/share/bubbly
    rm -fr ~/.config/bubbly
    rm -fr ~/.local/share/applications/bubbly.desktop
end

function dode-calcure
    paru -Sa --needed --disable-download-timeout calcure
    mkdir -p ~/.config/calcure
    ln -sf ~/r/dot/calcure.ini ~/.config/calcure/config.ini
    cp -fr ~/auto/calcure.csv ~/.config/calcure/events.csv
end

function dode-cargo-script
    cargo binstall -y cargo-script
end
function edod-cargo-script
    rm -fr ~/.cargo/binary_cache
    rm -fr ~/.cargo/script_cache
end

function dode-cava
    paru -Sa --needed --disable-download-timeout cava
end
function edod-cava
    paru -Rns cava
    rm -fr ~/.config/cava
end

function dode-cbonsai
    paru -Sa --needed --disable-download-timeout cbonsai
end

function dode-cliphist
    sudo pacman -S --needed --noconfirm --disable-download-timeout cliphist
end

function dode-cowsay
    sudo pacman -S --needed --noconfirm --disable-download-timeout cowsay
end

function dode-cursors
    # Lighted Pixel Butter — https://www.gnome-look.org/p/2103612
    sudo cp -fr ~/auto/cursors/Lighted-Pixel-Butter /usr/share/icons
    # this is only needed because firefox is stupid and reverts to Adwaita for some reason
    sudo ln -sn /usr/share/icons/Lighted-Pixel-Butter /usr/share/icons/mine
    sudo cp -fr /usr/share/icons/Adwaita/cursors{,.bak}
    for file in /usr/share/icons/Adwaita/cursors/*
        sudo ln -sf /usr/share/icons/mine/cursors/(path basename $file) $file
    end
end

function dode-dns
    begin
        echo 'nameserver 1.1.1.1' # cloudflare DNS server
        echo 'nameserver 8.8.8.8' # google DNS server
        sudo cat /etc/resolv.conf
    end | sponge | sudo tee /etc/resolv.conf

    # keep lowering this until it's okay
    ping -c 4 -M do -s 1472 google.com
    sudo ip link set dev wlan0 mtu $optimal_value
end

function dode-etcher
    paru -Sa --needed --disable-download-timeout etcher-cli-bin
end

function dode-exrex
    pipx install exrex
end

function dode-eww
    cd ~/r/stored
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release --no-default-features --features x11
    ln $PWD/target/release/eww ~/r/binaries
    mkdir -p ~/.config/eww
    touch ~/.config/eww/eww.yuck
end
function edod-eww
    rm -fr ~/r/stored/eww
    rm -fr ~/.config/eww
    rm -fr ~/r/binaries/eww
end

function dode-fifc
    fisher install gazorby/fifc
    set -Ux fifc_editor helix
    # set -Ux fifc_fd_opts -u
    set -Ux fifc_keybinding \cn
end

function dode-figlet
    sudo pacman -S --needed --noconfirm --disable-download-timeout figlet
end

function dode-firefox
    sudo pacman -S --needed --noconfirm --disable-download-timeout firefox
    set -Ux MOZ_ENABLE_WAYLAND 1
    set -Ux GTK_THEME Adwaita:dark
    set -l prof_dir ~/.mozilla/firefox/fqigcjz6.default-release
    mkdir $prof_dir/chrome
    ln -sf ~/r/dot/firefox/userChrome.css $prof_dir/chrome
    ln -sf ~/r/dot/firefox/userContent.css $prof_dir/chrome
    # devtools.debugger.prompt-connection
    # devtools.inspector.remote

    # version 133.0
    # /etc/pacman.conf
    # IgnorePkg=firefox

    # enable shortcuts in address bar
end

function dode-fnott
    sudo pacman -S --needed --noconfirm --disable-download-timeout fnott
    mkdir -p ~/.config/fnott
    ln -sf ~/r/dot/fnott.ini ~/.config/fnott/fnott.ini
end

function dode-fstab
    # automounting setup
    sudo blkid # take UUIDs for the partitions here
    sudo -E helix /etc/fstab
    id -u # user_id
    id -g # group_id
    # UUID=the_uuid /mnt/usb ext4 defaults 0 2
    # UUID=the_uuid /mnt/fatusb exfat defaults,uid=user_id,gid=group_id,dmask=0222,fmask=0111 0 0
end

function dode-fonts
    sudo pacman -S --needed --noconfirm --disable-download-timeout ttf-jetbrains-mono-nerd ttf-input ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono papirus-icon-theme
    paru -Sa --needed --disable-download-timeout ttf-comfortaa
end

function dode-fuck
    sudo pacman -Rns --noconfirm eos-update-notifier
    sudo pacman -Rns --noconfirm nano-syntax-highlighting
    sudo pacman -Rns --noconfirm htop
    sudo pacman -Rns --noconfirm meld
end

function dode-fuzzel
    sudo pacman -S --needed --noconfirm --disable-download-timeout fuzzel
    mkdir -p ~/.config/fuzzel
    ln -sf ~/r/dot/fuzzel.ini ~/.config/fuzzel/fuzzel.ini
end

function dode-gamescope
    sudo pacman -S --needed --noconfirm --disable-download-timeout gamescope
end

function dode-gh
    sudo pacman -S --needed --noconfirm --disable-download-timeout github-cli
    gh auth login
    gh auth refresh -h github.com -s delete_repo
end

function dode-ghostty
    cd ~/r/stored
    git clone --depth=1 https://github.com/ghostty-org/ghostty
    cd ghostty
    zig build -p $HOME/.local -Doptimize=ReleaseFast -Dapp-runtime=gtk
    mkdir -p ~/.config/ghostty
    ln -sf ~/r/dot/ghostty.conf ~/.config/ghostty/config
end

function dode-git
    sudo pacman -Syyu git diff-so-fancy
    # [[sort on]]
    git config --global branch.sort -committerdate
    git config --global checkout.defaultRemote origin
    git config --global commit.verbose true
    git config --global core.editor helix
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global credential.helper store
    git config --global diff.colormoved default
    git config --global diff.colormovedws allow-indentation-change
    git config --global init.defaultBranch main
    git config --global interactive.singleKey true
    git config --global pull.ff only
    git config --global push.autoSetupRemote true
    git config --global rebase.updateRefs true
    git config --global rerere.enabled false
    git config --global user.email 101342105+Axlefublr@users.noreply.github.com
    git config --global user.name Axlefublr
    # [[sort off]]
end

function dode-gromit-mpx
    sudo pacman -S --needed --noconfirm --disable-download-timeout gromit-mpx
    ln -sf ~/r/dot/gromit.cfg ~/.config/gromit-mpx.cfg
    sudo ln -sf ~/r/dot/desktop/gromit-mpx.desktop /usr/share/applications/net.christianbeier.Gromit-MPX.desktop
end

function dode-gtk-theme
    gh repo clonef Axlefublr/gruvbox-material-gtk-theme
    sudo ln -sf ~/r/proj/gruvbox-material-gtk-theme /usr/share/themes/gruvbox-material
    set -Ux GTK_THEME gruvbox-material
end

function dode-helix
    sudo pacman -S --needed --noconfirm --disable-download-timeout marksman taplo-cli lua lua-language-server vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver yaml-language-server prettier stylua python-toml
    paru -Sa --needed --disable-download-timeout prettierd
    cd ~/r/forks
    git clone --depth=1 https://github.com/Axlefublr/helix
    cd ~/r/forks/helix
    cargo install --path helix-term --locked
    ln -sf ~/r/dot/helix ~/.config
    mkdir -p ~/.cargo/bin
    rm -fr ~/.cargo/bin/runtime
    ln -sf ~/r/forks/helix/runtime ~/.cargo/bin
end

function dode-httrack
    sudo pacman -S --needed --noconfirm --disable-download-timeout httrack
end

function dode-jj
    sudo pacman -S --needed --noconfirm --disable-download-timeout jj lazyjj
    jj util completion fish | source
    ln -sf ~/r/dot/jj.toml ~/.config/jj/config.toml
end

function dode-jpeg2png
    paru -Sa --needed --disable-download-timeout jpeg2png
end

function dode-kbt
    sudo pacman -S --needed --noconfirm --disable-download-timeout kbt
end

function dode-kitty
    sudo pacman -S kitty
    mkdir -p ~/.config/kitty
    ln -sf ~/r/dot/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -sf ~/r/dot/kitty/theme.conf ~/.config/kitty/current-theme.conf
end

function dode-kondo
    sudo pacman -S --needed --noconfirm --disable-download-timeout kondo
    kondo --completions fish
end

function dode-krita
    sudo pacman -S --needed --noconfirm --disable-download-timeout krita
    mkdir -p ~/.local/share/color-schemes
    ln -f ~/r/dot/krita/gruvbox.colors ~/.local/share/krita/color-schemes
end

function dode-kruler
    sudo pacman -S --needed --noconfirm --disable-download-timeout kruler
end

function dode-lazygit
    sudo pacman -S --needed --noconfirm --disable-download-timeout lazygit
    mkdir -p ~/.config/lazygit
    ln -sf ~/r/dot/lazygit.yml ~/.config/lazygit/config.yml
end

function dode-less
    sudo ln -sf ~/r/dot/lesskey /opt/lesskey
end

function dode-libreoffice
    sudo pacman -S --needed --noconfirm --disable-download-timeout libreoffice-still
end

function dode-lolcat
    sudo pacman -S lolcat
end

function dode-lxappearance
    sudo pacman -S --needed --noconfirm --disable-download-timeout lxappearance gtk-engine-murrine qt5ct
end

function dode-mapscii
    paru -Sa --needed --disable-download-timeout nodejs-mapscii
end
function edod-mapscii
    paru -Rns nodejs-mapscii
    rm -fr ~/.mapscii
end

function dode-mpv
    sudo pacman -S --needed --noconfirm --disable-download-timeout mpv
    sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps mpv-mpris
    mkdir -p ~/.config/mpv
    ln -sf ~/r/dot/mpv/* ~/.config/mpv
    xdg-mime default mpv.desktop video/webm
    xdg-mime default mpv.desktop video/mp4
    xdg-mime default mpv.desktop video/x-matroska
end

function dode-neovide
    sudo pacman -S --needed --noconfirm --disable-download-timeout neovide
    set -Ux NEOVIDE_FORK false
end

function dode-niri
    sudo pacman -S --needed --noconfirm --disable-download-timeout niri
    sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring
    sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps clang # for building from source
    ln -sf ~/r/dot/niri.kdl ~/.config/niri/config.kdl
    mkdir -p ~/.config/systemd/user/niri.service.wants
end

function dode-nom
    # paru -Sa --needed --disable-download-timeout nom
    eget https://github.com/guyfedwards/nom
    indeed -nu ~/.local/share/magazine/W https://github.com/guyfedwards/nom
    mkdir -p ~/.config/nom
    ln -sf ~/r/dot/nom.yml ~/.config/nom/config.yml
    ln -sf ~/auto/nom.db ~/.config/nom/nom.db
end

function dode-nvim
    sudo pacman -S neovim luarocks
    trash-put ~/.config/nvim
    mkdir -p ~/.config/nvim
    for file in ~/r/dot/!nvim/*
        ln -sf $file ~/.config/nvim
    end
    for file in ~/r/dot/!nvim/.*
        ln -sf $file ~/.config/nvim
    end
end

function dode-other
    sudo loginctl enable-linger $USER
    sudo systemctl enable --now paccache.timer
end

function dode-ouch
    sudo pacman -S --needed --noconfirm --disable-download-timeout ouch
end

function dode-ov
    # paru -Sa --needed --disable-download-timeout ov-bin
    cd ~/r/forks
    gh repo clonef Axlefublr/ov
    cd ov
    make
    sudo install ov ~/.local/bin
    ov --completion fish >~/.config/fish/completions/ov.fish
    mkdir -p ~/.config/ov
    ln -sf ~/r/dot/ov.yaml ~/.config/ov/config.yaml
end

function dode-paru
    sudo pacman -S --needed --noconfirm --disable-download-timeout paru
    mkdir -p ~/.config/paru
    ln -sf ~/r/dot/paru.conf ~/.config/paru/paru.conf
end

function dode-picom
    sudo pacman -S --needed --noconfirm --disable-download-timeout picom
    mkdir -p ~/.config/picom
    ln -sf ~/r/dot/picom.conf ~/.config/picom/picom.conf
end

function dode-pipes
    # visual lines going all over the screen
    paru -Sa --needed --disable-download-timeout bash-pipes
end

function dode-postgresql
    sudo pacman -S postgresql
    ln -sf ~/r/dot/psqlrc ~/.psqlrc
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
end
function dode-postgresql
    sudo systemctl disable postgresql
end

function dode-pueue
    sudo pacman -S --needed --noconfirm --disable-download-timeout pueue
    systemctl --user start pueued
    systemctl --user enable pueued
    systemctl --user status pueued
    ln -sf ~/r/dot/pueue.yml ~/.config/pueue/pueue.yml
    pueue group add k
    pueue group add s
    pueue parallel -g s 0
end

function dode-qalc
    sudo pacman -S libqalculate
    # set vspace off
    # set curconv off
    # set update exchange rates 1
end

function dode-qbittorrent
    sudo pacman -S --needed --noconfirm --disable-download-timeout qbittorrent
end

function dode-qrtool
    sudo pacman -S --needed --noconfirm --disable-download-timeout qrtool
    qrtool --generate-completion fish >~/.config/fish/completions/qrtool.fish
end

function dode-radeon-gpu
    paru -Sa --needed --disable-download-timeout radeon-profile-git radeon-profile-daemon-git
    sudo systemctl enable --now radeon-profile-daemon
end

function dode-repgrep
    # sudo pacman -S --needed --noconfirm --disable-download-timeout repgrep
end

function dode-rofi
    sudo pacman -S rofi-wayland
    mkdir -p ~/.config/rofi
    ln -sf ~/r/dot/rofi.rasi ~/.config/rofi/config.rasi
    sudo ln -sf /usr/bin/rofi /usr/bin/dmenu
end

function dode-sd
    sudo pacman -S --needed --noconfirm --disable-download-timeout sd
end

function dode-sddm
    sudo pacman -S --needed --noconfirm --disable-download-timeout sddm
    sudo systemctl enable --now sddm
end

function dode-serpl
    sudo pacman -S --needed --noconfirm --disable-download-timeout serpl
    paru -Sa --needed --disable-download-timeout ast-grep-bin
    mkdir -p ~/.config/serpl
    ln -sf ~/r/dot/serpl.yml ~/.config/serpl/serpl.yml
end

function dode-scc
    eget https://github.com/boyter/scc
    indeed -nu ~/.local/share/magazine/W https://github.com/boyter/scc
end

function dode-screenkey
    sudo pacman -S screenkey
    sudo ln -sf ~/r/dot/desktop/screenkey.desktop /usr/share/applications
end

function dode-scriptisto
    cargo binstall -y scriptisto
end

function dode-speedtest
    sudo pacman -S --needed --noconfirm --disable-download-timeout speedtest-cli
end

function dode-spotify
    sudo pacman -S --needed --noconfirm --disable-download-timeout spotify-launcher
    # edit /usr/share/applications/spotify-launcher.desktop to have `env DISPLAY=:1.0` in exec
end

function dode-steam
    sudo pacman -S --needed --noconfirm --disable-download-timeout steam-native-runtime
end

function dode-sttr
    eget -a tar.gz -a '^sbom.json' https://github.com/abhimanyu003/sttr
    indeed -nu ~/.local/share/magazine/W -- '-a tar.gz -a ^sbom.json https://github.com/abhimanyu003/sttr'
end

function dode-swaybg
    sudo pacman -S --needed --noconfirm --disable-download-timeout swaybg
    ln -sf ~/i/e/themes/fall.jpg ~/bs/background-image
    ln -sf ~/r/dot/swaybg/swaybg.service ~/.config/systemd/user/swaybg.service
    systemctl --user daemon-reload
    ln -s ~/.config/systemd/user/swaybg.service ~/.config/systemd/user/niri.service.wants/
    systemctl --user restart swaybg.service # reload swaybg
end

function dode-swayimg
    mkdir -p ~/.local/share/applications/
    ln -sf ~/r/dot/desktop/swayimg.desktop ~/.local/share/applications/swayimg.desktop
    xdg-mime default swayimg.desktop image/svg+xml
    xdg-mime default swayimg.desktop image/png
    xdg-mime default swayimg.desktop image/jpeg
    xdg-mime default swayimg.desktop image/gif
    xdg-mime default swayimg.desktop image/webp
end

function dode-termfilechooser
    sudo pacman -S xdg-desktop-portal-gtk
    paru -Sa --needed --disable-download-timeout xdg-desktop-portal-termfilechooser-git
    fish_add_path /usr/lib
    set -Ux TERMCMD kitty
    set -Ux GDK_DEBUG portals
    set -Ux GTK_USE_PORTAL 1
    mkdir -p ~/.config/xdg-desktop-portal-termfilechooser
    ln -sf ~/r/dot/termfilechooser/config ~/.config/xdg-desktop-portal-termfilechooser/config
    sudo mkdir -p /usr/local/share/xdg-desktop-portal-termfilechooser
    sudo ln -sf ~/r/dot/termfilechooser/yazi-wrapper.sh /usr/local/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    mkdir -p ~/.config/xdg-desktop-portal
    ln -sf ~/r/dot/termfilechooser/portals.conf ~/.config/xdg-desktop-portal/portals.conf
    systemctl --user restart xdg-desktop-portal.service
    systemctl --user restart xdg-desktop-portal-termfilechooser.service
    # for firefox
    # widget.use-xdg-desktop-portal.file-picker 1
end

function dode-tiptop
    pipx install tiptop
end

function dode-traceroute
    sudo pacman -S --needed --noconfirm --disable-download-timeout traceroute
end

function dode-tridactyl
    # :nativeinstall
    # to copy the command to execute
    mkdir -p ~/.config/tridactyl
    ln -f ~/r/dot/tridactyl ~/.config/tridactyl/tridactylrc
end

function dode-ttyper
    sudo pacman -S ttyper
    ln -sf ~/.local/share/magazine/U ~/.config/ttyper/language/uclanr
end

function dode-tuisky
    cargo binstall -y tuisky
end

function dode-twemoji
    paru -Sa --needed --disable-download-timeout ttf-twemoji
    sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf
end

function dode-tz
    eget https://github.com/oz/tz
    indeed -nu ~/.local/share/magazine/W https://github.com/oz/tz
end

function dode-unimatrix
    paru -Sa --needed --disable-download-timeout unimatrix-git
end
function edod-unimatrix
    paru -Rns unimatrix-git
end

function dode-vscode
    mkdir -p ~/.config/Code/User
    ln -sf ~/r/dot/vscode/settings.jsonc ~/.config/Code/User/settings.json
    ln -sf ~/r/dot/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
    Needed for the CSS & JS extension
    sudo chown -R $(whoami) $(which code)
    sudo chown -R $(whoami) /opt/visual-studio-code
end

function dode-waybar
    sudo pacman -S --needed --noconfirm --disable-download-timeout waybar
    sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps otf-font-awesome
    mkdir -p ~/.config/waybar
    ln -sf ~/r/dot/waybar/waybar.jsonc ~/.config/waybar/config.jsonc
    ln -sf ~/r/dot/waybar/waybar.css ~/.config/waybar/style.css
    ln -sf /usr/lib/systemd/user/waybar.service ~/.config/systemd/user/niri.service.wants/waybar.service
end

function dode-whois
    sudo pacman -S --needed --noconfirm --disable-download-timeout whois
end

function dode-wf-recorder
    sudo pacman -S --needed --noconfirm --disable-download-timeout wf-recorder
end

function dode-wooz
    sudo pacman -S --needed --noconfirm --disable-download-timeout meson ninja cmake wayland-protocols
    cd ~/r/stored
    gh repo clonef https://github.com/negrel/wooz
    cd wooz
    export CFLAGS="-O3"
    meson build
    ninja -C build
    cp -f ./build/wooz ~/r/binaries/wooz
end

function dode-wtf
    # “wtf is curl” — quickly explains a rRam
    paru -Sa --needed --disable-download-timeout wtf
end

function dode-x
    ln -sf ~/r/dot/x11/xresources ~/.Xresources
    ln -sf ~/r/dot/x11/.XCompose ~/.XCompose
    set -Ux XMODIFIERS @im=none
end

function dode-xremap
    sudo pacman -S --needed --noconfirm --disable-download-timeout xremap-x11-bin
    sudo usermod -aG input $USER
    sudo usermod -aG video $USER
    echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules
end

function dode-xwayland-satellite
    sudo pacman -S --needed --noconfirm --disable-download-timeout xwayland-satellite
    set -Ux DISPLAY :0
end

function dode-yazi
    sudo pacman -S yazi
    rm -fr ~/.config/yazi
    ln -s ~/r/dot/yazi ~/.config
    ya pack -a yazi-rs/plugins:hide-preview
    ya pack -a yazi-rs/plugins:jump-to-char
    ya pack -a Ape/open-with-cmd
    ya pack -a KKV9/compress
end

function dode-ydotool
    sudo pacman -S --needed --noconfirm --disable-download-timeout ydotool
    pueue add -g s ydotoold
end

function dode-yt-dlp
    sudo pacman -S --needed --noconfirm --disable-download-timeout yt-dlp
    sudo pacman -S --needed --noconfirm --disable-download-timeout --asdeps python-mutagen
    mkdir -p ~/.config/yt-dlp
    ln -sf ~/r/dot/yt-dlp.conf ~/.config/yt-dlp/config
end

function dode-zathura
    sudo pacman -S zathura
    sudo pacman -S zathura-pdf-mupdf
    mkdir -p ~/.config/zathura
    ln -sf ~/r/dot/zathura ~/.config/zathura/zathurarc
    xdg-mime default org.pwmt.zathura.desktop application/pdf
end

function dode-zola
    sudo pacman -S --needed --noconfirm --disable-download-timeout zola
end

function dode-zoom
    paru -Sa --needed --disable-download-timeout zoom
end

function dode-zoxide
    sudo pacman -S --needed --noconfirm --disable-download-timeout zoxide
    set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
    set -Ux _ZO_MAXAGE 30000
end
