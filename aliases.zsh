# Programs
alias gh="gh.exe"
alias dotnet="dotnet.exe"
alias exp="explorer.exe"
alias lua="lua.exe"
alias ffmpeg="ffmpeg.exe"
alias v="nvim"

# Commands
alias prog="cd /mnt/c/Programming"
alias libv2="cd /mnt/c/Users/serge/Documents/AutoHotkey/Lib"
alias del="rm -rf"

# Aliases
alias gitcreate="git add . && git commit -m \"first commit\" && git push -u origin main"

# Paths
nvim_windows=/mnt/c/Programming/dotfiles/init.vim
nvim_linux=~/.config/nvim/init.vim
aliases_windows=/mnt/c/Programming/dotfiles/aliases.zsh
aliases_linux=$ZSH/custom/aliases.zsh
lua_windows=/mnt/c/Programming/dotfiles/basic.lua
lua_lunux=~/.config/nvim/lua/basic.lua

syncFrom() {
   cp -u $nvim_windows $nvim_linux
   cp -u $aliases_windows $aliases_linux
   cp -u $lua_windows $lua_lunux
}
syncTo() {
   cp -u $nvim_linux $nvim_windows
   cp -u $aliases_linux $aliases_windows
   cp -u $lua_lunux $lua_windows
}

# Files
alias n="syncFrom && nvim $nvim_linux && syncTo"
alias m="syncFrom && nvim $lua_lunux && syncTo"
alias alis="syncFrom && nvim $aliases_linux && syncTo"
alias zshConf="nvim ~/.zshrc"
alias p10kConf="nvim ~/.p10k.zsh"
