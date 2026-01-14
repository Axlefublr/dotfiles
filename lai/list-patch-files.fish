#!/usr/bin/env fish

set -l parent_dir ~/fes/talia/(pwdb)
mkdir -p $parent_dir
cd $parent_dir
fd -E '*.md' -t file
