#!/usr/bin/env fish

function prli
    printf '%s\n' $argv
end
funcsave prli >/dev/null

function tg
    $EDITOR /dev/shm/tg
    set -l tempText (cat /tmp/gi)
    if test -z "$tempText"
        return 1
    end
    tgpt "$tempText"
end
funcsave tg >/dev/null

function new --description='Creates new files or directories and all required parent directories'
    for arg in $argv
        if string match -rq '/$' -- "$arg"
            mkdir -p "$arg"
        else
            set -l dir (string match -rg '(.*)/.+?$' -- "$arg")
            and mkdir -p "$dir"

            touch "$arg"
        end

        echo (realpath "$arg")
    end
end
funcsave new >/dev/null

function abbrad
    abbr -a $argv
    echo "abbr -a $argv[1] '$argv[2..]'" >>~/prog/dotfiles/fish/abbreviations/abbreviations.fish
    echo "alias --save $argv[1] '$argv[2..]' > /dev/null" >>~/prog/dotfiles/fish/fun/fallbacks.fish
end
funcsave abbrad >/dev/null

function abbrap
    abbr -a :"$argv[1]" --position anywhere -- $argv[2..]
    echo "abbr -a ,$argv[1] --position anywhere -- '$argv[2..]'" >>~/prog/dotfiles/fish/abbreviations/positional.fish
end
funcsave abbrap >/dev/null

function asmra
    set -l prevdir (pwd)
    cd ~/prog/info/socials
    printf '\n'$argv[1]
    git add asmr.txt
    git commit -m 'asmr: '$argv[1]
    cd $prevdir
end
funcsave asmra >/dev/null

function ats
    set -l shark (alien_temple shark)
    prli $shark
    echo $shark[1] | xclip -r -selection clipboard
end
funcsave ats >/dev/null

function atc
    alien_temple consent | tee /dev/tty | xclip -r -selection clipboard
end
funcsave atc >/dev/null

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
    paru
    if test (math (clorange updates show) % 5) -eq 0
        rustup update
    end
    if test (math (clorange updates show) % 3) -eq 0
        cargo mommy install-update -a
    end
    clorange updates increment
    loago do update
    bell
    read -ln 1 response
    if test $response = r
        reboot
    else if test $response = l
        logout
    else if test $response = s
        poweroff
    end
end
funcsave uboot >/dev/null

function take
    set -l total 0
    for arg in $argv[2..]
        set total (math $total + $arg)
    end
    math "$argv[1] + ($total / 20) + $total"
end
funcsave take >/dev/null

function bak
    set -l full_path $argv[1]
    set -l file_name (basename $full_path)
    set -l extension (path extension $full_path)
    mkdir -p $full_path.bak
    clorange $file_name increment
    set -l current (clorange $file_name show)
    cp -f $full_path $full_path.bak/$current$extension
    set -l cutoff (math $current - 50)
    if test $cutoff -ge 1
        rm -fr $full_path.bak/$cutoff$extension
    end
end
funcsave bak >/dev/null

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

function fn_clear
    set list (cat ~/prog/dotfiles/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
    for file in ~/.config/fish/functions/*.fish
        set function_name (basename $file '.fish')
        if not contains $function_name $list
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn_clear >/dev/null

function s
    set -g s (realpath $argv)
end
funcsave s >/dev/null

function runner
    set cmd (rofi -input ~/prog/dotfiles/data/likely.txt -dmenu 2> /dev/null | string collect)
    if set -q argv[1]
        notify-send -t 0 (eval $cmd | string collect)
    else
        eval $cmd
    end
    if string match -rq '^loago do ' $cmd
        awesome-client 'Loago_wu()'
    end
end
funcsave runner >/dev/null

function runner_kill
    set selected (ps -eo pid,command | zat --start 2 | string trim --left | rofi-multi-select 2> /dev/null)
    for line in $selected
        kill (string match -gr '^(\\d+)' $line)
    end
end
funcsave runner_kill >/dev/null

function runner_note
    set input (rofi -dmenu 2> /dev/null | string collect)
    indeed -- ~/prog/noties/notes.txt $input
end
funcsave runner_note >/dev/null

function runner_wote
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    if set -q argv[1]
        indeed -- ~/prog/noties/notes.txt (cat ~/.local/share/notie)
    end
    set -e result[-1]
    set result (string collect $result)
    truncate -s 0 ~/.local/share/notie
    if test -n $result
        indeed -- ~/.local/share/notie $result
    end
    awesome-client 'Note_wu()'
end
funcsave runner_wote >/dev/null

function runner_math
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    set result (string collect $result)
    if test -n $result
        indeed -- ~/prog/noties/notes.txt (cat ~/.local/share/notie)
        math "$result" 2>/dev/null >~/.local/share/notie
        awesome-client 'Note_wu()'
    end
end
funcsave runner_math >/dev/null

function wote_edit
    neoline ~/.local/share/notie
    awesome-client 'Note_wu()'
end
funcsave wote_edit >/dev/null

function wote_steal
    cat ~/.local/share/notie | xclip -r -selection clipboard
    truncate -s 0 ~/.local/share/notie
    awesome-client 'Note_wu()'
end
funcsave wote_steal >/dev/null

function runner_symbol
    set result (rofi -dmenu 2> /dev/null ; echo $status)
    if test $result[-1] -ne 0
        return 1
    end
    set -e result[-1]
    if test -z $result
        return 1
    end
    set output ''
    for code in (string split ' ' $result)
        set output $output'\U'(string pad --char 0 --width 8 $code)
    end
    printf $output 2>/dev/null | xclip -r -selection clipboard
end
funcsave runner_symbol >/dev/null

function fbp
    floral_barrel show list | string match -gr '(.*?)\\s+-\\s+ep\\d+\\s+-\\s+dn\\d+' | fzf
end
funcsave fbp >/dev/null

function edit_commandline
    set temp '/dev/shm/fish_edit_commandline.fish'
    truncate -s 0 $temp || touch $temp
    set cursor_location '/dev/shm/fish_edit_commandline_cursor'
    truncate -s 0 $cursor_location || touch $cursor_location
    commandline >$temp

    set -l offset (commandline --cursor)
    set -l lines (commandline)\n
    set -l line 1
    while test $offset -ge (string length -- $lines[1])
        set offset (math $offset - (string length -- $lines[1]))
        set line (math $line + 1)
        set -e lines[1]
    end
    set column (math $offset + 1)

    neomax -- +$line -c "norm! $column|" -c 'lua Write_cursor_position_on_leave("'$cursor_location'")' $temp &>/dev/null
    set -l editor_status $status
    cat $cursor_location

    if test $editor_status -eq 0
        if test -s $temp # this shouldn't be needed, but strangely is
            commandline -r -- (command cat $temp)
        else
            commandline ''
        end
        set -l position (cat $cursor_location | string split ' ')
        set -l line $position[1]
        set -l column $position[2]
        commandline -C 0
        for _line in (seq $line)[2..]
            commandline -f down-line
        end
        commandline -f beginning-of-line
        for _column in (seq $column)[2..]
            commandline -f forward-single-char
        end
    end
    commandline -f repaint
end
funcsave edit_commandline >/dev/null