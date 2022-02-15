HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nathan/.zshrc'

autoload -Uz compinit
compinit

alias ls='ls --color=auto'
alias rm='rm -I'
alias dots="git --git-dir=$HOME/.dots/ --work-tree=$HOME"

setopt histignorealldups

# Dir stack
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias v=nvim

export EDITOR='vim'
export NINJA_STATUS="[%s/%t %p] "
export LSAN_OPTIONS="print_suppressions=false:suppressions=/home/nathan/dev/blender/lsan-suppressions.txt"

set -o emacs

export PATH="$PATH:$HOME/.local/bin"

setopt nolistbeep

# Use bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/nathan/.luarocks/share/lua/5.4/?.lua;/home/nathan/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/nathan/.luarocks/lib/lua/5.4/?.so'
export PATH="$PATH:$HOME/.luarocks/bin"

eval "$(starship init zsh)"
