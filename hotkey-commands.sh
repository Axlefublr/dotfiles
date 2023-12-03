uclanr -tj '' 3 | xclip -r -selection clipboard

xclip -selection clipboard -o > /tmp/bibren ; kitty -T edit-clipboard nvim -n /tmp/bibren ; test -s /tmp/bibren && cat /tmp/bibren | xclip -r -selection clipboard

truncate -s 0 /tmp/bibren ; kitty -T edit-clipboard nvim -n /tmp/bibren ; test -s /tmp/bibren && cat /tmp/bibren | xclip -r -selection clipboard

kitty --detach --hold -T infoterm printwait

kitty -T emoji-picker --start-as maximized sh -c "kitty +kitten unicode_input --tab code > /tmp/unicode_input" ; cat /tmp/unicode_input | xclip -r -selection clipboard

gromit-mpx -c ; gromit-mpx -t
gromit-mpx -c
gromit-mpx -t