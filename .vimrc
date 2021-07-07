set nocompatible
syntax on

set showcmd
set wildmenu

set autoindent
set nostartofline

set ruler
set laststatus=2

set confirm
set mouse=a

set number

set background=dark

autocmd FileType gitcommit call OptionsFTypeGitCommit()

function OptionsFTypeGitCommit()
	setlocal spell
	setlocal indentexpr=""
	setlocal expandtab shiftwidth=4 tabstop=4
	setlocal textwidth=72
	highlight ColorColumn ctermbg=0 guibg=lightgrey
endfun

