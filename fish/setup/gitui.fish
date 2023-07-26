#!/usr/bin/env fish

command -q gitui || cargo binstall -y gutui
ln -sf ~/Programming/dotfiles/gitui/theme.ron ~/.config/gitui/theme.ron
ln -sf ~/Programming/dotfiles/gitui/key_bindings.ron ~/.config/gitui/key_bindings.ron
