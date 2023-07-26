#!/usr/bin/env fish

command -q yt-dlp || pipx install yt-dlp
ln -s ~/Programming/dotfiles/yt-dlp.conf ~/yt-dlp.conf