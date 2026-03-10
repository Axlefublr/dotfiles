#!/usr/bin/env fish

fuzzel -dl 0 </dev/null | read -l input
test "$input" || return 1
set -l dir ~/fes/ork/hirl/content/"$(string replace ' ' '-' $input)"
mkdir -p $dir
set -l file $dir/index.md
echo "+++
title = '$input'
date = '$(date +%Y-%m-%d)'
draft = true
+++" >$file
footclient -ND ~/fes/ork/hirl helix $file:2:10
