#!/usr/bin/bash

sudo pacman -Syyu git
# [[sort on]]
git config --global branch.sort -committerdate
git config --global checkout.defaultRemote origin
git config --global commit.verbose true
git config --global core.editor helix
git config --global credential.helper store
git config --global diff.colormoved default
git config --global diff.colormovedws allow-indentation-change
git config --global init.defaultBranch main
git config --global interactive.singleKey true
git config --global pull.ff only
git config --global push.autoSetupRemote true
git config --global rerere.enabled true
git config --global user.email 101342105+Axlefublr@users.noreply.github.com
git config --global user.name Axlefublr
