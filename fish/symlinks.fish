#!usr/bin/fish
mkdir -p ~/.config/fish
rm -f ~/.config/fish/config.fish
ln -s /mnt/c/Programming/dotfiles/fish/config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.lua
ln -s /mnt/c/Programming/dotfiles/init.lua ~/.config/nvim/init.lua

set -l choreTrackerBrokenSymlink /mnt/c/Programming/binaries/ChoreTracker.exe
set -l choreTrackerTarget /mnt/c/Programming/csproj/ChoreTracker/ChoreTracker/bin/Debug/net7.0/ChoreTracker.exe
rm -f $choreTrackerBrokenSymlink
ln -s $choreTrackerTarget $choreTrackerBrokenSymlink

set -l weldeBrokenSymlink /mnt/c/Programming/binaries/Welde.exe
set -l weldeTarget /mnt/c/Programming/csproj/Welde/Welde/bin/Debug/net7.0/Welde.exe
rm -f $weldeBrokenSymlink
ln -s $weldeTarget $weldeBrokenSymlink