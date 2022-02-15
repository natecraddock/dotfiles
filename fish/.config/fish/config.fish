# Hide greeting
set fish_greeting

# Aliases
alias rm="rm -iv"
alias ls="ls --color -h --group-directories-first"
alias up="cd .."
alias lstar="tar -ztvf"
alias untar="tar -zxvf"
alias mktar="tar -cvzf"
alias stow="stow -v --dotfiles"

# Abbreviations
abbr --add g git
abbr --add v nvim
abbr --add t tmux

# Completions

# completion for `git pick` cherry pick helper
complete -k -f -c git -n '__fish_seen_subcommand_from pick' -a '(__fish_git_unique_remote_branches)' -d 'Unique Remote Branch'
complete -k -f -c git -n '__fish_seen_subcommand_from pick' -a '(__fish_git_local_branches)'

# Bindings
function fish_hybrid_key_bindings --description "vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end

set -g fish_key_bindings fish_hybrid_key_bindings

bind --mode insert \ch backward-kill-word
bind --mode insert \cr "zf-history (commandline -b)"
bind --mode insert \ed zf-dir
bind --mode insert \cg zf-file
bind --mode insert \cr "zf-history (commandline -b)"
bind \ed zf-dir
bind \cg zf-file

# Variables
set -gx EDITOR nvim
set -gx NINJA_STATUS "[%s/%t %p]"
set -gx LSAN_OPTIONS "print_suppressions=false:suppressions=/home/nathan/dev/blender/lsan-suppressions.txt"

set -gx LUA_PATH "/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/nathan/.luarocks/share/lua/5.4/?.lua;/home/nathan/.luarocks/share/lua/5.4/?/init.lua"
set -gx LUA_CPATH "/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/nathan/.luarocks/lib/lua/5.4/?.so"

# Path
fish_add_path "$PATH:$HOME/.local/bin"
fish_add_path "$PATH:$HOME/.luarocks/bin"

# Functions
function mkdirc -a path --description "Create and enter a new directory"
    mkdir $path
    cd $path
end

# Theme
source ~/.config/fish/themes/$COLORSCHEME.fish

# Starship must be at the end
starship init fish | source
