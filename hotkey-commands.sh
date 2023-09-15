xclip -selection clipboard -t image/png -o 2>/dev/null > /tmp/recent-screenshot.png && display /tmp/recent-screenshot.png

uclanr -tj '' 3 | xclip -r -selection clipboard

kitty nvim -n /tmp/bibren ; cat /tmp/bibren | xclip -r -selection clipboard

kitty paru ; ChoreTracker do update ; reboot

kitty -T temporary-terminal