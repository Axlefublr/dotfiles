#!/usr/bin/env fish

set -l size 20

set -l main '#ffafd7'
set -l shift '#ffd75f'
set -l below '#87ff5f'
set -l combined '#ff2930'

# qwert
gromit-mpx --line 128  120 128  120 $main $size
gromit-mpx --line 544  120 544  120 $main $size
gromit-mpx --line 960  120 960  120 $main $size
gromit-mpx --line 1376 120 1376 120 $main $size
gromit-mpx --line 1792 120 1792 120 $main $size

# asdfg
gromit-mpx --line 128  540 128  540 $main $size
gromit-mpx --line 544  540 544  540 $main $size
gromit-mpx --line 960  540 960  540 $main $size
gromit-mpx --line 1376 540 1376 540 $main $size
gromit-mpx --line 1792 540 1792 540 $main $size

# zxcvb
gromit-mpx --line 128  960 128  960 $main $size
gromit-mpx --line 544  960 544  960 $main $size
gromit-mpx --line 960  960 960  960 $main $size
gromit-mpx --line 1376 960 1376 960 $main $size
gromit-mpx --line 1792 960 1792 960 $main $size

# + qwer
gromit-mpx --line 336  120 336  120 $shift $size
gromit-mpx --line 752  120 752  120 $shift $size
gromit-mpx --line 1168 120 1168 120 $shift $size
gromit-mpx --line 1584 120 1584 120 $shift $size

# + asdf
gromit-mpx --line 336  540 336  540 $shift $size
gromit-mpx --line 752  540 752  540 $shift $size
gromit-mpx --line 1168 540 1168 540 $shift $size
gromit-mpx --line 1584 540 1584 540 $shift $size

# + zxcv
gromit-mpx --line 336  960 336  960 $shift $size
gromit-mpx --line 752  960 752  960 $shift $size
gromit-mpx --line 1168 960 1168 960 $shift $size
gromit-mpx --line 1584 960 1584 960 $shift $size

# ^ qwert
gromit-mpx --line 128  330 128  330 $below $size
gromit-mpx --line 544  330 544  330 $below $size
gromit-mpx --line 960  330 960  330 $below $size
gromit-mpx --line 1376 330 1376 330 $below $size
gromit-mpx --line 1792 330 1792 330 $below $size

# ^ asdfg
gromit-mpx --line 128  750 128  750 $below $size
gromit-mpx --line 544  750 544  750 $below $size
gromit-mpx --line 960  750 960  750 $below $size
gromit-mpx --line 1376 750 1376 750 $below $size
gromit-mpx --line 1792 750 1792 750 $below $size

# ^+ qwer
gromit-mpx --line 336  330 336  330 $combined $size
gromit-mpx --line 752  330 752  330 $combined $size
gromit-mpx --line 1168 330 1168 330 $combined $size
gromit-mpx --line 1584 330 1584 330 $combined $size

# ^+ asdf
gromit-mpx --line 336  750 336  750 $combined $size
gromit-mpx --line 752  750 752  750 $combined $size
gromit-mpx --line 1168 750 1168 750 $combined $size
gromit-mpx --line 1584 750 1584 750 $combined $size