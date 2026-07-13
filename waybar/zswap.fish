#!/usr/bin/env fish

set -l meminfo "$(cat /proc/meminfo)"
set -l compressed (echo $meminfo | string match -gr '^Zswap:\\s+(\\d+)')
set -l compressed_gb (math -s 1 -m round $compressed / 1024 / 1024)
set -l original (echo $meminfo | string match -gr '^Zswapped:\\s+(\\d+)')
set -l original_gb (math -s 1 -m round $original / 1024 / 1024)
echo "$original_gb → $compressed_gb"
