#!usr/bin/fish
set -l choreTrackerBrokenSymlink /mnt/c/Programming/binaries/ChoreTracker.exe
set -l choreTrackerTarget /mnt/c/Programming/csproj/ChoreTracker/ChoreTracker/bin/Debug/net7.0/ChoreTracker.exe
rm -f $choreTrackerBrokenSymlink
ln -s $choreTrackerTarget $choreTrackerBrokenSymlink

set -l weldeBrokenSymlink /mnt/c/Programming/binaries/Welde.exe
set -l weldeTarget /mnt/c/Programming/csproj/Welde/Welde/bin/Debug/net7.0/Welde.exe
rm -f $weldeBrokenSymlink
ln -s $weldeTarget $weldeBrokenSymlink
