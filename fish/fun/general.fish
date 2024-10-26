#!/usr/bin/env fish

function smdn
    set -l name $argv[1]

    set -l executable /home/axlefublr/prog/dotfiles/scripts/systemd/executables/$name.fish
    printf '#!/usr/bin/env fish' >$executable
    chmod +x $executable
    code $executable

    set -l service ~/prog/dotfiles/scripts/systemd/services/$name.service
    printf "[Service]
    ExecStartPre=/home/axlefublr/prog/dotfiles/scripts/processwait.fish
    ExecStart=$executable" >$service

    set -l timer ~/prog/dotfiles/scripts/systemd/timers/$name.timer
    printf '[Timer]
    OnCalendar=*-*-8 05:00:00
    Persistent=true

    [Install]
    WantedBy=timers.target' >$timer
    code $timer

    printf "

    systemctl --user enable --now $name.timer" >>~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave smdn >/dev/null

function smdr
    set -l name $argv[1]
    rm -fr ~/prog/dotfiles/scripts/systemd/{services,timers,executables}/$name.*
    sd "

    systemctl --user enable --now $name.timer" '' ~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave smdr >/dev/null

function uboot
    sudo -v
    for package in (cat ~/.local/share/magazine/C)
        paru -Rns --noconfirm $package
    end
    truncate -s 0 ~/.local/share/magazine/C
    clorange docs increment
    set -l doc_dirs (eza -aD ~/docs)
    set -l count_doc_dirs (count $doc_dirs)
    set -l current_doc_dir (math "$(clorange doc_dirs increment) % $count_doc_dirs + 1")
    kitten @ launch --type os-window --os-window-title link-download --cwd ~/docs/$doc_dirs[$current_doc_dir] httrack --update
    sudo -v
    if test (math (clorange updates show) % 5) -eq 0
        rustup update
    end
    sudo -v
    if test (math (clorange updates show) % 3) -eq 0
        cargo install-update -a
    end
    sudo -v
    paru
    pacclean
    clorange updates increment
    loago do update
    notify-send 'finished updating, what to do now?'
    read -p rdp -ln 1 response
    if test $response = r
        reboot
    else if test $response = l
        logout
    else if test $response = s
        poweroff
    end
end
funcsave uboot >/dev/null

function loopuntil
    set -l counter 0
    while true
        set output (eval $argv[1])
        if test $status -eq 0
            if set -q argv[3] && test $argv[3] -ne 0
                sleep $argv[3]
                set argv[3] 0
                continue
            end
            break
        end
        set counter (math $counter + 1)
        if set -q argv[2]
            sleep $argv[2]
        end
        if set -q argv[4]
            if test $counter -ge $argv[4]
                return 1
            end
        end
    end
    for line in $output
        echo $line
    end
end
funcsave loopuntil >/dev/null

function fn-clear
    set list (cat ~/prog/dotfiles/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
    for file in ~/.config/fish/functions/*.fish
        set function_name (basename $file '.fish')
        if not contains $function_name $list
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn-clear >/dev/null

function pacclean --description 'clean pacman and paru cache' # based on https://gist.github.com/ericmurphyxyz/37baa4c9da9d3b057a522f20a9ad6eba (cool youtuber btw)
    set aur_cache_dir "$HOME/.cache/paru/clone"
    function aur_cache_dirs_fmt
        fd . $HOME/.cache/paru/clone -d 1 -t d | awk '{ print "-c" $1 }'
    end
    set uninstalled_target (aur_cache_dirs_fmt)
    echo $uninstalled_target[1]
    paccache -ruvk0 $uninstalled_target
    set installed_target (aur_cache_dirs_fmt) # we do this twice because uninstalled package directories got removed
    paccache -qruk1
    paccache -qrk2 -c /var/cache/pacman/pkg $installed_target
end
funcsave pacclean >/dev/null

function ni
    if status is-interactive
        helix "/tmp/ni-output$argv[1]" >&2
    else
        neoline_hold "/tmp/ni-output$argv[1]" >&2
    end
    cat "/tmp/ni-output$argv[1]" | string collect
end
funcsave ni >/dev/null

function autocommit
    if not git status --porcelain
        return
    end
    set -l new_files
    set -l deleted_files
    set -l modified_files
    set -l renamed_from
    set -l renamed_to
    git add .
    for change in (git status --porcelain)
        set -l bits (string split -n ' ' $change)
        set type $bits[1]
        set path "$(echo $bits[2..])"
        if test $type = A
            set new_files $new_files (string trim -c '"' $path)
        else if test $type = D
            set deleted_files $deleted_files (string trim -c '"' $path)
        else if test $type = M
            set modified_files $modified_files (string trim -c '"' $path)
        else if test $type = R
            set two_paths (string split ' -> ' -- $path)
            set renamed_from $renamed_from (string trim -c '"' $two_paths[1])
            set renamed_to $renamed_to (string trim -c '"' $two_paths[2])
        end
    end
    git restore --staged .
    for deletion in $deleted_files
        git add $deletion
        and git commit -m "remove $deletion"
    end
    for addition in $new_files
        git add $addition
        and git commit -m "add $addition"
    end
    for modification in $modified_files
        git add $modification
        and git commit -m "change $modification"
    end
    for index in (seq (count $renamed_from))
        git add $renamed_from[$index] $renamed_to[$index]
        and git commit -m "move $renamed_from[$index] -> $renamed_to[$index]"
    end
end
funcsave autocommit >/dev/null
