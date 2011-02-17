set nocompatible

autocmd FileType php setlocal keywordprg=pman

map <f2> :make<cr>

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set encoding=utf-8
set modeline

set modeline

set number
nmap <F3> :set invnumber<CR>

set ignorecase
set smartcase

nmap <F7> :set invspell<CR>
nmap <F4> za

set foldmethod=marker

set formatprg=par\ -w78

cmap w!! w !sudo tee % >/dev/null

syntax on
colorscheme wombat256i
if has('gui_running')
    set background=dark
endif
