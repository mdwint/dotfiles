call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'hashivim/vim-terraform'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
Plug 'python/black'
Plug 'fisadev/vim-isort'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'google/vim-maktaba'
Plug 'google/vim-coverage'
Plug 'google/vim-glaive', {'do': ':call glaive#Install()'}
call plug#end()

let g:python3_host_prog='~/vim-python/bin/python'
let g:black_virtualenv = '~/vim-python'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

syntax on
let g:python_highlight_all = 0
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
let g:signify_sign_change = '~'

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set backspace=indent,eol,start
set number
set cursorline
set splitbelow
set splitright

map <C-P> :FZF<CR>
map <C-B> :NERDTreeToggle<CR>

nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

autocmd BufWritePre * %s/\s\+$//e  " Strip trailing whitespace
autocmd BufWritePre *.py execute ':Black'

set t_Co=256
color grb24bit
hi clear SignColumn
hi LineNr ctermfg=darkgray
hi EndOfBuffer ctermfg=darkgray
hi CursorLine ctermbg=233
hi ALEErrorSign ctermbg=none ctermfg=red
hi ALEError ctermbg=red ctermfg=233
hi DiffAdd cterm=bold ctermbg=none ctermfg=green
hi DiffDelete cterm=bold ctermbg=none ctermfg=red
hi DiffChange cterm=bold ctermbg=none ctermfg=yellow
