xclip -selection clipboard -t image/png -o 2>/dev/null | display

uclanr -tj '' 3 | xclip -r -selection clipboard

xclip -selection clipboard -o > /tmp/bibren ; kitty -T temporary-terminal nvim -n /tmp/bibren ; cat /tmp/bibren | xclip -r -selection clipboard

kitty --hold kitten @set-window-title timer

kitty --detach --hold -T infoterm printwait

kitty -T emoji-picker --start-as maximized sh -c "kitty +kitten unicode_input --tab name > /tmp/unicode_input" ; cat /tmp/unicode_input | xclip -r -selection clipboard

gromit-mpx -c ; gromit-mpx -t
gromit-mpx -c
gromit-mpx -t