xclip -selection clipboard -t image/png -o 2>/dev/null | display

uclanr -tj '' 3 | xclip -r -selection clipboard

xclip -selection clipboard -o > /tmp/bibren ; kitty -T temporary-terminal nvim -n /tmp/bibren ; cat /tmp/bibren | xclip -r -selection clipboard

kitty paru ; ChoreTracker do update ; reboot

kitty -T temporary-terminal