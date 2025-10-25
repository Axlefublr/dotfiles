#[[sort on]]
abbr -a --set-cursor=% edi 'sudo -E helix /usr/share/applications/%.desktop'
abbr -a -c gh gh-depth-1 -r df -- '-- --depth 1'
abbr -a -c magick magick-webp-lossless -r loss -- '-define webp:lossless=true'
abbr -a -c systemctl systemctl-daemon-reload -r dr daemon-reload
abbr -a -c systemctl systemctl-disable -r d disable
abbr -a -c systemctl systemctl-enable -r e enable
abbr -a -c systemctl systemctl-restart -r r restart
abbr -a -c systemctl systemctl-start -r s start
abbr -a -c systemctl systemctl-status -r c status
abbr -a -c systemctl systemctl-stop -r o stop
abbr -a .. --position anywhere --regex '^\.\.+$' --function multiple_dot
abbr -a E 'sudo -E helix'
abbr -a at alien_temple
abbr -a c cargo
abbr -a ca cargo
abbr -a chx 'chmod +x'
abbr -a cp 'rsync -r'
abbr -a de 'cd ~/fes/dot && helix'
abbr -a e helix
abbr -a fC 'sudo -E helix /etc/fancontrol'
abbr -a fc 'cat ~/fes/uviw/afen/sudo | sudo -S systemctl restart fancontrol'
abbr -a gx 'glaza -g'
abbr -a gz glaza
abbr -a hime 'history merge'
abbr -a hrtrack httrack
abbr -a j just
abbr -a jf 'exec fish'
abbr -a l jobs
abbr -a la 'eza -a'
abbr -a le 'eza -l'
abbr -a ls eza
abbr -a lw 'eza -al'
abbr -a mkd 'mkdir -p'
abbr -a q qalc
abbr -a qrtool qrtool.rs
abbr -a read 'read -p rdp' # can only be an abbreviation because `read` is a builtin
abbr -a rm gomi
abbr -a rmf 'rm -fr'
abbr -a sude 'sudo -E'
abbr -a t systemctl
abbr -a trr trash-restore
abbr -a tu 'systemctl --user'
abbr -a tz 'tz -q'
abbr -a u pueue.nu
