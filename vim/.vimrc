let g:python3_host_prog='~/vim-python/bin/python'

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

let g:black_virtualenv = '~/vim-python'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

syntax on
let g:python_highlight_all = 0
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

set backspace=indent,eol,start
set number
set splitbelow
set splitright

set t_Co=256
color grb24bit

highlight clear SignColumn
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEError ctermbg=red ctermfg=233
highlight DiffAdd cterm=bold ctermbg=none ctermfg=green
highlight DiffDelete cterm=bold ctermbg=none ctermfg=red
highlight DiffChange cterm=bold ctermbg=none ctermfg=yellow
let g:signify_sign_change = '~'

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

map <C-P> :FZF<CR>
map <C-B> :NERDTreeToggle<CR>

autocmd BufWritePre * %s/\s\+$//e  " Strip trailing whitespace
autocmd BufWritePre *.py execute ':Black'
