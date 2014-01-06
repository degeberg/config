set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'msanders/snipmate.vim'
Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'
Bundle 'L9'
Bundle 'FuzzyFinder'
"Bundle 'molok/vim-smartusline'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'Lokaltog/powerline'
Bundle 'a.vim'
Bundle 'matchit.zip'
Bundle 'taglist.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kien/ctrlp.vim'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'Shougo/vimproc'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ujihisa/neco-ghc'
Bundle 'scrooloose/syntastic'
Bundle 'adimit/prolog.vim'
Bundle 'jimenezrick/vimerl'
Bundle 'bkad/CamelCaseMotion'
Bundle 'paradigm/TextObjectify'
Bundle 'pbrisbin/html-template-syntax'


filetype plugin indent on

set lazyredraw
set ttyfast
set backspace=indent,eol,start     " backspace works as expected
set nostartofline                 " Make j/k respect the columns (after all, this is not a freaking typewriter)
set modeline                     " Respect modeline of the file (the famous "vi:noai:sw=3 ts=6" on the beginning of the files)
set hidden                         " Avoid asking to save before hiding
set enc=utf-8

set foldenable " Turn on folding
set foldmethod=marker

filetype on
filetype plugin on
filetype indent on

colorscheme molokai
syntax on

set visualbell
"set shm=atIWswxrnmlf
set ruler
set title
set titlestring=%f%(\ [%M]%)     " Show file name at the title
set numberwidth=1
set report=2
set laststatus=2
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}[%l,%v][%p%%]
set showcmd
set showmode
set winminheight=0

" auto complete
let g:neocomplcache_enable_at_startup = 0
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Command-mode completion
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.swc,*.DS_STORE,*.bkp,*.log,*.aux,*.out,*.make,*.bbl,*.blg,*.d,*.fls
set wildmode=list:full

" Insert-mode completion
set complete=.,w,b,u,U,t,i,d

" Scrolling
set scroll=5
set scrolloff=5
set sidescrolloff=5
set sidescroll=1

" Matching
set showmatch
set matchpairs=(:),{:},[:]
set matchtime=5

" Search and replace
set incsearch         " Search all instances
set hlsearch         " Highlight matched regexp
set ignorecase
set smartcase         " Intelligent case-smart searching

" Indentation
set autoindent
set smartindent
set smarttab
set expandtab
set shiftround
set nojoinspaces
set nofoldenable
set tabstop=4
set softtabstop=4
set shiftwidth=4

" History and backup
set viminfo='10,:20,\"100,%,n~/.viminfo
set history=1000
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Persistent-undo (vim 7.3)
if has("persistent_undo")
    set undofile
    set undodir=~/.vim/tmp
endif

" Tabs
set guitablabel=%N/\ %t\ %M

" Grep
set grepprg=ack
set grepformat=%f:%l:%m

" Format
set formatprg=par

" GVIM
if has("gui_running")
    colorscheme molokai
    set cursorline
    "set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
    "let g:Powerline_symbols = 'fancy'
    "set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline\ 9
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 9

    " Don't show toolbar and scrollbars
    set go-=T
    set go-=m
    set guioptions-=L
    set guioptions-=r

    " Highlight wrong spelling
    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Use system clipboard
    set clipboard=unnamed
endif

" Keyboard mapping
map <f2> :make<cr>
nnoremap j gj
nnoremap k gk
let mapleader = ","
vnoremap <tab>       >gv
vnoremap <s-tab>     <gv
vnoremap <           <gv
vnoremap >           >gv
set pastetoggle=<F10>
nnoremap <leader>ff :FufFile<CR>
nnoremap <leader>fb :FufBuffer<CR>
nnoremap <leader>fd :FufDir<CR>
nmap <Leader>bi :BundleInstall<CR>
nmap <Leader>bi! :BundleInstall!<CR>
nmap <silent> <leader>s :set spell!<CR>
command W w !sudo tee % > /dev/null
nmap <silent> <leader>n :set number!<cr>
nmap <silent> <leader>r :set relativenumber!<cr>
nmap <silent> <leader>a :A<cr>
map <silent> <f3> :TlistToggle<cr>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

au Bufenter *.hs compiler ghc

let g:haddock_browser = "/usr/bin/firefox"
let g:haddock_dir = "/usr/share/doc/ghc/html"
let g:ghc = "/usr/bin/ghc"

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
