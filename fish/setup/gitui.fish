#!/usr/bin/env fish

command -q gitui || cargo install gutui
ln -sf /mnt/c/Programming/dotfiles/gitui/theme.ron ~/.config/gitui/theme.ron
ln -sf /mnt/c/Programming/dotfiles/gitui/key_bindings.ron ~/.config/gitui/key_bindings.ron
