#!/usr/bin/env fish

set -l choreTrackerBrokenSymlink /mnt/c/Programming/binaries/ChoreTracker.exe
set -l choreTrackerTarget /mnt/c/Programming/csproj/ChoreTracker/ChoreTracker/bin/Debug/net7.0/ChoreTracker.exe
if test -e $choreTrackerTarget
	ln -sf $choreTrackerTarget $choreTrackerBrokenSymlink
else
	echo 'the target "'$choreTrackerTarget '" doesn\'t exist!'
end

set -l weldeBrokenSymlink /mnt/c/Programming/binaries/Welde.exe
set -l weldeTarget /mnt/c/Programming/csproj/Welde/Welde/bin/Debug/net7.0/Welde.exe
if test -e $weldeTarget
	ln -sf $weldeTarget $weldeBrokenSymlink
else
	echo 'the target "'$weldeTarget'" doesn\'t exist!'
end