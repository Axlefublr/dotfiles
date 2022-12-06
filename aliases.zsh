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

importDotfiles() {
   cp /mnt/c/Programming/dotfiles/init.vim ~/.config/nvim/init.vim
   cp /mnt/c/Programming/dotfiles/aliases.zsh $ZSH/custom/aliases.zsh
   cp /mnt/c/Programming/dotfiles/basic.lua ~/.config/nvim/lua/basic.lua
}

# Files
alias n="importDotfiles && nvim $nvim_linux"
alias m="importDotfiles && nvim $lua_lunux"
alias alis="importDotfiles && nvim $aliases_linux"
alias zshConf="nvim ~/.zshrc"
alias p10kConf="nvim ~/.p10k.zsh"
