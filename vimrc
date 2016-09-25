" vim: nospell foldmethod=marker foldlevel=99

" Sections are organized by the sections defined in `:options`

" 00) Plugins {{{
" 00.01) Pre-setup {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin('~/.vim/bundle')
" }}}
" 00.02) Plugin includes {{{
Plug 'L9'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/vimproc'
Plug 'a.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bkad/CamelCaseMotion'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'matchit.zip'
Plug 'msanders/snipmate.vim'
Plug 'neomake/neomake'
Plug 'nfnty/vim-nftables'
Plug 'paradigm/TextObjectify'
Plug 'pbrisbin/html-template-syntax'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp highlight-all-pragmas moose test-more try-tiny method-signatures' }
Plug 'yko/mojo.vim'
if isdirectory(expand("~/projects/dev-utils"))
    Plug '~/projects/dev-utils/conf/vim'
end
if has("python3")
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
end
" }}}
" 00.03) Post-setup {{{
call plug#end()
" }}}
" }}}

" 01) Important {{{
set nocompatible
set nostartofline                   " make j/k respect the columns
set pastetoggle=<F10>
let mapleader = ","
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
colorscheme molokai
" }}}

" 02) Moving around, searching and patterns {{{
set incsearch                       " Search all instances
set ignorecase
set smartcase                       " override 'ignorecase' when pattern has upper case characters
nnoremap j gj
nnoremap k gk
" }}}

" 03) Tags {{{
" }}}

" 04) Diplaying text {{{
set lazyredraw                      " don't redraw while executing macros
set numberwidth=1                   " number of columns to use for the line number
set scroll=5
set scrolloff=5
set sidescroll=1
set sidescrolloff=5
nmap <silent> <leader>n :set number!<cr>
nmap <silent> <leader>r :set relativenumber!<cr>
" }}}

" 05) Syntax, highlighting and spelling {{{
filetype on
filetype plugin on
filetype indent on
set nospell
set spelllang=en
set hlsearch                        " Highlight matched regexp
nmap <silent> <leader>s :set spell!<CR>

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" }}}

" 06) Multiple windows {{{
set hidden                          " avoid asking to save before hiding
set laststatus=2
set winminheight=0
set splitbelow
set splitright
" }}}

" 07) Multiple tab pages {{{
set guitablabel=%N/\ %t\ %M
" }}}

" 08) Terminal {{{
set ttyfast                         " terminal connection is fast (vim only)
set title
set titlestring=%f%(\ [%M]%)        " Show file name at the title
" }}}

" 09) Using the mouse {{{
" }}}

" 10) Printing {{{
" }}}

" 11) Messages and info {{{
set visualbell
set ruler
set report=2
set showcmd                         " show (partial) command keys in the status line
set showmode                        " display the current mode in the status line
" }}}

" 12) Selecting text {{{
" }}}

" 13) Editing text {{{
set backspace=indent,eol,start      " backspace works as expected
set complete=.,w,b,u,U,t,i,d
set showmatch
set matchpairs=(:),{:},[:]
set matchtime=5
set nojoinspaces
" }}}

" 14) Tabs and indenting {{{
set autoindent
set smartindent
set smarttab
set expandtab
set shiftround
set tabstop=4
set softtabstop=4
set shiftwidth=4
vnoremap <tab>       >gv
vnoremap <s-tab>     <gv
vnoremap <           <gv
vnoremap >           >gv
" }}}

" 15) Folding {{{
set foldenable
set foldmethod=marker
" }}}

" 16) Diff mode {{{
" }}}

" 17) Mapping {{{
" }}}

" 18) Reading and writing files {{{
set modeline                        " respect modeline of the file
set backupdir=~/.vim/backup
command! W w !sudo tee % > /dev/null
"nnoremap <leader>ff :FufFile<CR>
"nnoremap <leader>fb :FufBuffer<CR>
"nnoremap <leader>fd :FufDir<CR>
nnoremap <silent> <Leader>ff     :Files<CR>
nnoremap <silent> <Leader>fb     :Buffer<CR>
nnoremap <silent> <Leader>fg     :GitFiles<CR>
nnoremap <silent> <Leader>ft     :Tags<CR>
" }}}

" 19) The swap file {{{
set directory=~/.vim/tmp
if has("persistent_undo")
    set undofile
    set undodir=~/.vim/tmp
endif
" }}}

" 20) Command line editing {{{
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.swc,*.DS_STORE,*.bkp,*.log,*.aux,*.out,*.make,*.bbl,*.blg,*.d,*.fls
set wildmode=list:full
set history=1000
" }}}

" 21) Executing external commands {{{
set formatprg=par
map <F2> :make<CR>
" }}}

" 22) Running make and jumping to errors {{{
set grepprg=ack
set grepformat=%f:%l:%m
" }}}

" 23) Language specific {{{

" C++ {{{
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" }}}

" Perl {{{
let perl_sub_signatures = 1
let perl_include_pod = 1
let perl_pod_formatting = 1
" }}}

" Neomake {{{
autocmd! BufReadPost,BufWritePost * Neomake
if filereadable('./.ctags')
    let g:neomake_perl_ctags_maker = { 'args': ['-R'], 'append_file': 0 }
    let g:neomake_perl_enabled_makers = ['perl', 'perlcritic', 'ctags']
else
    let g:neomake_perl_enabled_makers = ['perl', 'perlcritic']
endif
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_less_enabled_makers = ['lessc']
" }}}

" }}}

" 24) Multi-byte characters {{{
if !has('nvim')
    set encoding=utf-8
endif
" }}}

" 25) Various {{{
" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
if has('nvim')
    set shada='20,<50,:20,%,n~/.nvim/_nviminfo
else
    set viminfo='20,\"50,:20,%,n~/.vim/_viminfo
endif
set sessionoptions-=options    " do not store global and local values in a session
set sessionoptions-=folds      " do not store folds
let g:airline_theme="powerlineish"
let g:deoplete#enable_at_startup = 1

" GVIM {{{
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
" }}}

" vim-test {{{
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
if has('nvim')
    let test#strategy = "neoterm"
endif
" }}}

" neoterm {{{
nnoremap <silent> <leader>nc :call neoterm#close()<CR>
nnoremap <silent> <leader>nl :call neoterm#clear()<CR>
nnoremap <silent> <leader>nk :call neoterm#kill()<CR>
nnoremap <silent> <leader>no :Topen<CR>
nnoremap <silent> <leader>nt :Ttoggle<CR>
" }}}

" }}}

" 25) Jobindex {{{
if isdirectory(expand("~/projects/dev-utils"))
    nmap <F4> :call DoTidy()<CR>
    vmap <F4> :Tidy<CR>
    nmap <silent> <leader>tt :call JIX_jump_testfile()<CR>
endif
" }}}
