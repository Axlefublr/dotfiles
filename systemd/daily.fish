#!/usr/bin/env fish

cd ~
if test "$(cat ~/fes/zufi/ran-daily)" = (date +%Y.%m.%d)
    warn 'already ran today, exiting'
    return
end
date +%Y.%m.%d >~/fes/zufi/ran-daily

while rg -q 8BitDo /proc/bus/input/devices &>/dev/null
    warn 'controller connected. delaying execution'
    sleep 1m
end

# ----------------------file actions-----------------------
log 1 file actions

math (cat ~/.local/share/magazine/S) + 50 | sponge ~/.local/share/magazine/S
_magazine_commit ~/.local/share/magazine/S desire
indeed.rs -u ~/fes/nak/semicolon.md -- (propose.rs -n 20% remember 50% ~/.local/share/magazine/s)
truncate -s 0 ~/.local/share/magazine/d

# -------------------------cleanup-------------------------
log 1 cleanup

log 2 pacman cache
pacclean.fish
log 2 fish functions
fn_clear
log 2 trash
trash-empty -f 1
log 2 cleaning lady
cleaning-lady.nu
log 2 kondo
kondo -ao 30d
log 2 incremental compile artifacts
fd --type dir --no-ignore --prune -pa --glob --changed-after 5d '**/target/**/incremental' -X rm -fr

# --------------------requires internet--------------------
log 1 waiting for internet
wait_for_internet

# ---------------------------git---------------------------
log 1 git actions

log 2 fetch everything
for dir in ~/fes/ork/*
    log 3 $dir
    git -C $dir fetch --all
end

log 2 autocommit
for dir in (cat ~/.local/share/magazine/O)
    log 3 $dir
    cd (path resolve $dir)
    autocommit.fish
    git push
end

log 2 autopush
for dir in (cat ~/.local/share/magazine/P)
    log 3 $dir
    cd (path resolve $dir)
    git push
end
cd ~

# --------------------------uboot--------------------------
log 1 uboot

log 2 stew
stew upgrade --all
log 2 eget
for package in (cat ~/fes/dot/egetables)
    echo $package | xargs eget --upgrade-only
end
log 2 rustup
rustup update
log 2 cargo installed binaries
cargo install-update -a
log 2 uv
uv tool upgrade --all
log 2 pacman
cat ~/fes/jiro/sudo | sudo -S pacman -Syyu --noconfirm

# -----------------------generation------------------------
log 1 generation

log 2 completions
comp.fish

log 2 frizz
# I'm writing to a file in frizz, which triggers the update. without it, I would need to call it explicitly
na -c 'config nu --doc' >~/.local/share/frizz/nushell.nu

log 2 nom refresh
http_proxy=http://127.0.0.1:8118 https_proxy=http://127.0.0.1:8118 nom refresh
