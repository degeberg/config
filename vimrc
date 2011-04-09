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

nmap <F5> :NERDTreeToggle<CR>
nmap <F6> :TlistToggle<CR>

set ignorecase
set smartcase

nmap <F7> :set invspell<CR>
nmap <F4> za

set foldmethod=marker

set formatprg=par\ -w78

cmap w!! w !sudo tee % >/dev/null

syntax on
if $HOSTNAME == "daniel-laptop"
    colorscheme wombat
else
    colorscheme wombat256
endif

if has('gui_running')
    set background=dark
endif

set wildignore=*.o,*.pyc,*~
set tags=tags;/

set cul
set splitright
set splitbelow
set ttyfast
