" vim: nospell

set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'msanders/snipmate.vim'
Plug 'L9'
Plug 'FuzzyFinder'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'a.vim'
Plug 'matchit.zip'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/vimproc'
Plug 'adimit/prolog.vim'
Plug 'jimenezrick/vimerl'
Plug 'bkad/CamelCaseMotion'
Plug 'paradigm/TextObjectify'
Plug 'pbrisbin/html-template-syntax'
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp highlight-all-pragmas moose test-more try-tiny method-signatures' }
Plug 'junegunn/fzf.vim'
Plug 'yko/mojo.vim'
Plug 'tpope/vim-obsession'
Plug 'kassio/neoterm'
Plug 'rust-lang/rust.vim'
if isdirectory(expand("~/projects/dev-utils"))
    Plug '~/projects/dev-utils/conf/vim'
end
if has("python3")
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
end
call plug#end()

set lazyredraw
set ttyfast
set backspace=indent,eol,start     " backspace works as expected
set nostartofline                 " Make j/k respect the columns (after all, this is not a freaking typewriter)
set modeline                     " Respect modeline of the file (the famous "vi:noai:sw=3 ts=6" on the beginning of the files)
set hidden                         " Avoid asking to save before hiding
if !has('nvim')
    set encoding=utf-8
endif

set foldenable " Turn on folding
set foldmethod=marker

filetype on
filetype plugin on
filetype indent on

colorscheme molokai

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
"
"" auto complete
"let g:neocomplcache_enable_at_startup = 0
""autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

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
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
    "let g:Powerline_symbols = 'fancy'
    "set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline\ 9
    "set guifont=Bitstream\ Vera\ Sans\ Mono\ 11

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
command! W w !sudo tee % > /dev/null
nmap <silent> <leader>n :set number!<cr>
nmap <silent> <leader>r :set relativenumber!<cr>
nmap <silent> <leader>a :A<cr>
map <silent> <f3> :TlistToggle<cr>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

"au Bufenter *.hs compiler ghc
"
"let g:haddock_browser = "/usr/bin/firefox"
"let g:haddock_dir = "/usr/share/doc/ghc/html"
"let g:ghc = "/usr/bin/ghc"

"autocmd BufWritePost *.hs GhcModCheckAndLintAsync

let g:syntastic_cpp_compiler_options = ' -std=c++11'

if has('nvim')
    " Remember things between sessions
    "
    " '20  - remember marks for 20 previous files
    " <50 - save 50 lines for each register
    " :20  - remember 20 items in command-line history
    " %    - remember the buffer list (if vim started without a file arg)
    set shada='20,<50,:20,%,n~/.nvim/_nviminfo
else
    " Remember things between sessions
    "
    " '20  - remember marks for 20 previous files
    " \"50 - save 50 lines for each register
    " :20  - remember 20 items in command-line history
    " %    - remember the buffer list (if vim started without a file arg)
    " n    - set name of viminfo file
    set viminfo='20,\"50,:20,%,n~/.vim/_viminfo
endif

" Sessions
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

if isdirectory(expand("~/projects/dev-utils"))
    nmap <F4> :call DoTidy()<CR>
    vmap <F4> :Tidy<CR>
    nmap <silent> <leader>tt :call JIX_jump_testfile()<CR>
endif

set rtp+=~/.fzf

nnoremap <silent> <Leader>ff     :Files<CR>
nnoremap <silent> <Leader>fb     :Buffer<CR>
nnoremap <silent> <Leader>fg     :GitFiles<CR>
nnoremap <silent> <Leader>ft     :Tags<CR>

"au! BufWritePost .vimrc source %

" Neomake
autocmd! BufReadPost,BufWritePost * Neomake
if filereadable('./.ctags')
    let g:neomake_perl_ctags_maker = { 'args': ['-R'], 'append_file': 0 }
    let g:neomake_perl_enabled_makers = ['perl', 'perlcritic', 'ctags']
else
    let g:neomake_perl_enabled_makers = ['perl', 'perlcritic']
endif
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_less_enabled_makers = ['lessc']

" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
if has('nvim')
    let test#strategy = "neoterm"
endif

" airline
let g:airline_theme="powerlineish"

" vim-perl
let perl_sub_signatures = 1
let perl_include_pod = 1
let perl_pod_formatting = 1

" better splits
set splitbelow
set splitright

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" spell checking
set nospell
set spelllang=en

" neoterm
nnoremap <silent> <leader>nc :call neoterm#close()<CR>
nnoremap <silent> <leader>nl :call neoterm#clear()<CR>
nnoremap <silent> <leader>nk :call neoterm#kill()<CR>
nnoremap <silent> <leader>no :Topen<CR>
nnoremap <silent> <leader>nt :Ttoggle<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
