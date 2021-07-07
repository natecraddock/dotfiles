# Hide greeting
set fish_greeting

# Gruvbox theme for fish and tide
set fish_color_error cc241d   # dimmed red for errors
set fish_color_command 458588 # nice blue for commands
set fish_color_param 83a598   # light blue for params
set fish_color_quote 689d6a   # aqua green for quotes
set fish_color_comment 928374 # gray for comments

set tide_pwd_color_anchors 83a598
set tide_pwd_color_dirs 458588
set tide_pwd_color_truncated_dirs 689d6a

# Aliases
alias rm="rm -I"
alias ls="ls --color -h --group-directories-first"
alias up="cd .."
alias dots="git --git-dir=$HOME/.dots/ --work-tree=$HOME"

# Abbreviations
abbr --add d dots
abbr --add t tmux
abbr --add v nvim

# Bindings
bind \cs 'clear; commandline -f repaint'

# Variables
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx EDITOR nvim
set -gx NINJA_STATUS "[%s/%t %p]"
set -gx LSAN_OPTIONS "print_suppressions=false:suppressions=/home/nathan/dev/blender/lsan-suppressions.txt"
set -gx PATH "$PATH:$HOME/.local/bin"

set -gx LUA_PATH "/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/nathan/.luarocks/share/lua/5.4/?.lua;/home/nathan/.luarocks/share/lua/5.4/?/init.lua"
set -gx LUA_CPATH "/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/nathan/.luarocks/lib/lua/5.4/?.so"
set -gx PATH "$PATH:$HOME/.luarocks/bin"

# Functions
function mkdirc -a path --description "Create and enter a new directory"
    mkdir $path
    cd $path
end
