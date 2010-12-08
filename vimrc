set nocompatible

autocmd FileType php setlocal keywordprg=pman

map <f2> :make<cr>

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

set modeline

set number
nmap <F3> :set invnumber<CR>

nmap <F7> :set invspell<CR>
nmap <F4> za

set foldmethod=marker

:command! -range=% -nargs=0 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
:command! -range=% -nargs=0 Space2Tab execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"

set formatprg=par\ -w78
nnoremap <C-f> {V}gq

"set mouse=a

colorscheme wombat256i
