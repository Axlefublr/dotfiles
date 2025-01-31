#!/usr/bin/env fish

alias paccy 'sudo pacman -S --needed --noconfirm --disable-download-timeout'
alias aurie 'paru -Sa --needed --noconfirm --disable-download-timeout'

function dode-aichat
    paccy aichat
end
function edod-aichat
    paru -Rns aichat
    rm -fr ~/.config/aichat
end

function dode-alacritty
    sudo pacman -S alacritty
    mkdir -p ~/.config/alacritty
    ln -sf ~/prog/dotfiles/alacritty.toml ~/.config/alacritty.toml
end

function dode-anki
    aurie anki
    # aurie anki-bin
end

function dode-ascii-image-converter
    aurie ascii-image-converter-bin
end

function dode-asciinema
    paccy asciinema
end

function dode-awm
    sudo pacman -S awesome
    mkdir -p ~/.config/awesome
    rm -fr ~/.config/awesome
    ln -sf ~/prog/dotfiles/awesome ~/.config/
    ln -sf ~/prog/dotfiles/awesome/awesome.lua ~/.config/awesome/rc.lua
end

function dode-bat
    paccy bat
    set -Ux BAT_THEME ansi
    set -Ux BAT_STYLE plain
end

function dode-bluetui
    paccy bluetui
    mkdir -p ~/.config/bluetui
    ln -sf ~/prog/dotfiles/bluetui.toml ~/.config/bluetui/config.toml
end

function dode-brillo
    paccy brillo
    begin
        echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"'
        echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"'
    end | sudo tee /etc/udev/rules.d/backlight.rules
end

function dode-boomer
    cd ~/prog/forks
    git clone https://github.com/Axlefublr/boomer
    cd boomer
    nimble build
    ln -sf ~/prog/dotfiles/boomer.conf ~/.config/boomer/config
end

function dode-bottom
    paccy bottom
    ln -sf ~/prog/dotfiles/bottom.toml ~/.config/bottom/bottom.toml
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
    aurie calcure
    mkdir -p ~/.config/calcure
    ln -sf ~/prog/dotfiles/calcure.ini ~/.config/calcure/config.ini
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
    aurie cava
end
function edod-cava
    paru -Rns cava
    rm -fr ~/.config/cava
end

function dode-cbonsai
    aurie cbonsai
end

function dode-copyq
    paccy copyq
    pipx install git+https://github.com/cjbassi/rofi-copyq
end

function dode-cowsay
    paccy cowsay
end

function dode-display
    ln -sf ~/prog/dotfiles/desktop/display.desktop ~/.local/share/applications/display.desktop
    xdg-mime default display.desktop image/svg+xml
    xdg-mime default display.desktop image/png
    xdg-mime default display.desktop image/jpeg
    xdg-mime default display.desktop image/gif
    xdg-mime default display.desktop image/webp
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
    aurie etcher-cli-bin
end

function dode-exrex
    pipx install exrex
end

function dode-eww
    cd ~/prog/stored
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release --no-default-features --features x11
    ln $PWD/target/release/eww ~/prog/binaries
    mkdir -p ~/.config/eww
    touch ~/.config/eww/eww.yuck
end
function edod-eww
    rm -fr ~/prog/stored/eww
    rm -fr ~/.config/eww
    rm -fr ~/prog/binaries/eww
end

function dode-fifc
    fisher install gazorby/fifc
    set -Ux fifc_editor helix
    # set -Ux fifc_fd_opts -u
    set -Ux fifc_keybinding \ej
end

function dode-figlet
    paccy figlet
end

function dode-firefox
    sudo pacman -S firefox
    # version 133.0
    # /etc/pacman.conf
    # IgnorePkg=firefox
    # widget.use-xdg-desktop-portal.file-picker 1
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
    paccy ttf-jetbrains-mono-nerd ttf-input ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
    aurie ttf-comfortaa
end

function dode-fuck
    sudo pacman -Rns --noconfirm eos-update-notifier
    sudo pacman -Rns --noconfirm nano-syntax-highlighting
    sudo pacman -Rns --noconfirm htop
    sudo pacman -Rns --noconfirm meld
end

function dode-gh
    paccy github-cli
    gh auth login
    gh auth refresh -h github.com -s delete_repo
end

function dode-ghostty
    cd ~/prog/stored
    git clone --depth=1 https://github.com/ghostty-org/ghostty
    cd ghostty
    zig build -p $HOME/.local -Doptimize=ReleaseFast -Dapp-runtime=gtk
    mkdir -p ~/.config/ghostty
    ln -sf ~/prog/dotfiles/ghostty.conf ~/.config/ghostty/config
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
    paccy gromit-mpx
    ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg
    sudo ln -sf ~/prog/dotfiles/desktop/gromit-mpx.desktop /usr/share/applications/net.christianbeier.Gromit-MPX.desktop
end

function dode-gtk-theme
    # Lighted Pixel Butter — https://www.gnome-look.org/p/2103612
    paccy gtk3-demo
    sudo ln -sf ~/prog/proj/gruvbox-material-gtk-theme /usr/share/themes/gruvbox-material
end

function dode-helix
    paccy marksman taplo-cli lua lua-language-server vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver yaml-language-server prettier stylua
    aurie prettierd
    cd ~/prog/forks
    git clone --depth=1 https://github.com/Axlefublr/helix
    cd ~/prog/forks/helix
    cargo install --path helix-term --locked
    ln -sf ~/prog/dotfiles/helix ~/.config
    mkdir -p ~/.cargo/bin
    rm -fr ~/.cargo/bin/runtime
    ln -sf ~/prog/forks/helix/runtime ~/.cargo/bin
end

function dode-httrack
    paccy httrack
end

function dode-jj
    paccy jj lazyjj
    jj util completion fish | source
    ln -sf ~/prog/dotfiles/jj.toml ~/.config/jj/config.toml
end

function dode-jpeg2png
    aurie jpeg2png
end

function dode-kbt
    paccy kbt
end

function dode-kitty
    sudo pacman -S kitty
    mkdir -p ~/.config/kitty
    ln -sf ~/prog/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -sf ~/prog/dotfiles/kitty/theme.conf ~/.config/kitty/current-theme.conf
end

function dode-kondo
    paccy kondo
    kondo --completions fish
end

function dode-krita
    paccy krita
    mkdir -p ~/.local/share/color-schemes
    ln -f ~/prog/dotfiles/krita/gruvbox.colors ~/.local/share/krita/color-schemes
end

function dode-kruler
    paccy kruler
end

function dode-lazygit
    sudo pacman -S lazygit
    mkdir -p ~/.config/lazygit
    ln -sf ~/prog/dotfiles/lazygit.yml ~/.config/lazygit/config.yml
end

function dode-less
    sudo ln -sf ~/prog/dotfiles/lesskey /opt/lesskey
end

function dode-libreoffice
    paccy libreoffice-still
end

function dode-lolcat
    sudo pacman -S lolcat
end

function dode-lxappearance
    paccy lxappearance gtk-engine-murrine qt5ct
end

function dode-mapscii
    aurie nodejs-mapscii
end
function edod-mapscii
    paru -Rns nodejs-mapscii
    rm -fr ~/.mapscii
end

function dode-mpv
    paccy mpv
    paccy --asdeps mpv-mpris
    mkdir -p ~/.config/mpv
    ln -sf ~/prog/dotfiles/mpv/* ~/.config/mpv
    xdg-mime default mpv.desktop video/webm
    xdg-mime default mpv.desktop video/mp4
    xdg-mime default mpv.desktop video/x-matroska
end

function dode-neovide
    paccy neovide
    set -Ux NEOVIDE_FORK false
end

function dode-nom
    # aurie nom
    eget https://github.com/guyfedwards/nom
    indeed -nu ~/.local/share/magazine/W https://github.com/guyfedwards/nom
    mkdir -p ~/.config/nom
    ln -sf ~/prog/dotfiles/nom.yml ~/.config/nom/config.yml
    ln -sf ~/auto/nom.db ~/.config/nom/nom.db
end

function dode-nvim
    sudo pacman -S neovim luarocks
    trash-put ~/.config/nvim
    mkdir -p ~/.config/nvim
    for file in ~/prog/dotfiles/!nvim/*
        ln -sf $file ~/.config/nvim
    end
    for file in ~/prog/dotfiles/!nvim/.*
        ln -sf $file ~/.config/nvim
    end
end

function dode-other
    sudo loginctl enable-linger $USER
    sudo systemctl enable --now sddm
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now paccache.timer
end

function dode-ov
    # aurie ov-bin
    cd ~/prog/forks
    gh repo clonef Axlefublr/ov
    make
    sudo install ov ~/.local/bin
    ov --completion fish >~/.config/fish/completions/ov.fish
    mkdir -p ~/.config/ov
    ln -sf ~/prog/dotfiles/ov.yaml ~/.config/ov/config.yaml
end

function dode-paru
    paccy paru
    mkdir -p ~/.config/paru
    ln -sf ~/prog/dotfiles/paru.conf ~/.config/paru/paru.conf
end

function dode-picom
    paccy picom
    mkdir -p ~/.config/picom
    ln -sf ~/prog/dotfiles/picom.conf ~/.config/picom/picom.conf
end

function dode-pipes
    # visual lines going all over the screen
    aurie bash-pipes
end

function dode-postgresql
    sudo pacman -S postgresql
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
    # set -Ux PGDATABASE dvdrental
    # set -Ux PGUSER postgres
end
function dode-postgresql
    sudo systemctl disable postgresql
end

function dode-pueue
    paccy pueue
    systemctl --user start pueued
    systemctl --user enable pueued
    systemctl --user status pueued
    ln -sf ~/prog/dotfiles/pueue.yml ~/.config/pueue/pueue.yml
    pueue group add k
    pueue group add K
    pueue group add i
    pueue group add c
    pueue group add s
    pueue parallel -g s 99
end

function dode-qalc
    sudo pacman -S libqalculate
    # set vspace off
    # set curconv off
    # set update exchange rates 1
end

function dode-qbittorrent
    paccy qbittorrent
end

function dode-qrtool
    paccy qrtool
    qrtool --generate-completion
    qrtool --generate-completion fish >~/.config/fish/completions/qrtool.fish
end

function dode-repgrep
    # paccy repgrep
    # you forked this
end

function dode-rofi
    sudo pacman -S rofi
    mkdir -p ~/.config/rofi
    ln -sf ~/prog/dotfiles/rofi.rasi ~/.config/rofi/config.rasi
    sudo ln -sf /usr/bin/rofi /usr/bin/dmenu
end

function dode-rofi-calc
    paccy rofi-calc
end
function edod-rofi-calc
    sudo pacman -Rns rofi-calc
    rm -fr ~/.local/share/rofi/rofi_calc_history
end

function dode-sd
    paccy sd
end

function dode-serpl
    paccy serpl
    aurie ast-grep-bin
    mkdir -p ~/.config/serpl
    ln -sf ~/prog/dotfiles/serpl.yml ~/.config/serpl/serpl.yml
end

function dode-scc
    eget https://github.com/boyter/scc
    indeed -nu ~/.local/share/magazine/W https://github.com/boyter/scc
end

function dode-screenkey
    sudo pacman -S screenkey
    sudo ln -sf ~/prog/dotfiles/desktop/screenkey.desktop /usr/share/applications
end

function dode-scriptisto
    cargo binstall -y scriptisto
end

function dode-speedtest
    paccy speedtest-cli
end

function dode-steam
    paccy steam
end

function dode-sttr
    eget -a tar.gz -a '^sbom.json' https://github.com/abhimanyu003/sttr
    indeed -nu ~/.local/share/magazine/W '-a tar.gz -a ^sbom.json https://github.com/abhimanyu003/sttr'
end

function dode-termfilechooser
    sudo pacman -S xdg-desktop-portal-gtk
    aurie xdg-desktop-portal-termfilechooser-git
    fish_add_path /usr/lib
    set -Ux TERMCMD kitty
    set -Ux GDK_DEBUG portals
    set -Ux GTK_USE_PORTAL 1
    mkdir -p ~/.config/xdg-desktop-portal-termfilechooser
    ln -sf ~/prog/dotfiles/termfilechooser/config ~/.config/xdg-desktop-portal-termfilechooser/config
    sudo mkdir -p /usr/local/share/xdg-desktop-portal-termfilechooser
    sudo ln -sf ~/prog/dotfiles/termfilechooser/yazi-wrapper.sh /usr/local/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    mkdir -p ~/.config/xdg-desktop-portal
    ln -sf ~/prog/dotfiles/termfilechooser/portals.conf ~/.config/xdg-desktop-portal/portals.conf
    systemctl --user restart xdg-desktop-portal.service
    systemctl --user restart xdg-desktop-portal-termfilechooser.service
end

function dode-tiptop
    pipx install tiptop
end

function dode-traceroute
    paccy traceroute
end

function dode-tridactyl
    # :nativeinstall
    # to copy the command to execute
    mkdir -p ~/.config/tridactyl
    ln -f ~/prog/dotfiles/tridactyl ~/.config/tridactyl/tridactylrc
end

function dode-ttyper
    sudo pacman -S ttyper
    ln -sf ~/.local/share/magazine/U ~/.config/ttyper/language/uclanr
end

function dode-tuisky
    cargo binstall -y tuisky
end

function dode-twemoji
    aurie ttf-twemoji
    sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf
end

function dode-tz
    eget https://github.com/oz/tz
    indeed -nu ~/.local/share/magazine/W https://github.com/oz/tz
end

function dode-unimatrix
    aurie unimatrix-git
end
function edod-unimatrix
    paru -Rns unimatrix-git
end

function dode-vscode
    mkdir -p ~/.config/Code/User
    ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
    ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
    Needed for the CSS & JS extension
    sudo chown -R $(whoami) $(which code)
    sudo chown -R $(whoami) /opt/visual-studio-code
end

function dode-whois
    paccy whois
end

function dode-wtf
    # “wtf is curl” — quickly explains a program
    aurie wtf
end

function dode-x
    ln -sf ~/prog/dotfiles/x11/xresources ~/.Xresources
    ln -sf ~/prog/dotfiles/x11/.XCompose ~/.XCompose
    set -Ux XMODIFIERS @im=none
end

function dode-xremap
    paccy xremap-x11-bin
    sudo usermod -aG input $USER
    sudo usermod -aG video $USER
    echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules
end

function dode-yazi
    sudo pacman -S yazi
    rm -fr ~/.config/yazi
    ln -s ~/prog/dotfiles/yazi ~/.config
    ya pack -a yazi-rs/plugins:hide-preview
    ya pack -a yazi-rs/plugins:jump-to-char
    ya pack -a Ape/open-with-cmd
    ya pack -a KKV9/compress
end

function dode-ydotool
    paccy ydotool
    pueue add -g s ydotoold
end

function dode-yt-dlp
    paccy yt-dlp
    paccy --asdeps python-mutagen
    mkdir -p ~/.config/yt-dlp
    ln -sf ~/prog/dotfiles/yt-dlp.conf ~/.config/yt-dlp/config
end

function dode-zathura
    sudo pacman -S zathura
    sudo pacman -S zathura-pdf-mupdf
    mkdir -p ~/.config/zathura
    ln -sf ~/prog/dotfiles/zathura ~/.config/zathura/zathurarc
    xdg-mime default org.pwmt.zathura.desktop application/pdf
end

function dode-zola
    paccy zola
end

function dode-zoom
    aurie zoom
end

function dode-zoxide
    paccy zoxide
    set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
    set -Ux _ZO_MAXAGE 30000
end
