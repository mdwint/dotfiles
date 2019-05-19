call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'simnalamburt/vim-mundo'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
Plug 'nicwest/vim-http'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
Plug 'python/black'
Plug 'fisadev/vim-isort'
Plug 'google/vim-maktaba'
Plug 'google/vim-coverage'
Plug 'google/vim-glaive', {'do': ':call glaive#Install()'}
Plug 'morhetz/gruvbox'
call plug#end()

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

syntax on
filetype plugin on
let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']
let g:NERDSpaceDelims=1
let g:NERDToggleCheckAllLines=1
let g:python3_host_prog='~/vim-python/bin/python'
let g:black_virtualenv='~/vim-python'
let g:python_highlight_all=1
let g:rustfmt_autosave=1
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:signify_sign_change='~'
let g:vim_http_split_vertically=1

set autoread mouse=a backspace=indent,eol,start
set number cursorline splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set ignorecase smartcase
set completeopt=longest,menuone
set showcmd wildmenu
set diffopt+=vertical

nmap <C-P> :FZF<CR>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <C-N><C-N> :set invnumber<CR>
nmap <C-M><C-M> :set invrelativenumber<CR>
map <F1> !pipenv run pytest %<CR>
map <F4> :NERDTreeToggle<CR>
map <F5> :MundoToggle<CR>
map <Leader>tt :Http!<CR>

nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

autocmd BufEnter,FocusGained * :checktime
autocmd BufWritePre * %s/\s\+$//e  " Strip trailing whitespace
autocmd BufWritePre *.py silent! execute ':Black'

set termguicolors
set background=dark
" let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_sign_column='bg0'
colors gruvbox
