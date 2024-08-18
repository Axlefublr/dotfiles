#!/usr/bin/bash

sudo pacman -Syu --noconfirm git
git config --global user.email 101342105+Axlefublr@users.noreply.github.com
git config --global user.name Axlefublr
git config --global init.defaultBranch main
git config --global credential.helper store
git config --global push.autoSetupRemote true
git config --global interactive.singleKey true
git config --global pull.ff only
git config --global commit.verbose true
git config --global checkout.defaultRemote origin
git config --global rerere.enabled true
git config --global branch.sort -committerdate
git config --global core.editor helix