call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'jparise/vim-graphql'
Plug 'nicwest/vim-http'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'rizzatti/dash.vim'
Plug 'davidhalter/jedi-vim'
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
let g:NERDDefaultAlign='left'
let g:NERDSpaceDelims=1
let g:NERDToggleCheckAllLines=1
let g:python3_host_prog='~/vim-python/bin/python'
let g:ale_completion_enabled=1
let g:ale_fix_on_save=1
let g:ale_fixers={
\ 'python': ['black'],
\ 'rust': ['rustfmt'],
\ 'terraform': ['terraform'],
\ 'javascript': ['prettier'],
\ 'css': ['prettier'],
\}
let g:signify_vcs_list=['git']
let g:signify_sign_change='~'
let g:vim_http_split_vertically=1

set autoread mouse=a backspace=indent,eol,start
set number relativenumber cursorline splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set ignorecase smartcase
set completeopt=longest,menuone
set showcmd wildmenu
set diffopt+=vertical
set clipboard=unnamed

nmap <C-P> :FZF<CR>
nnoremap <Leader>a :Ack!<Space>
nnoremap <CR> :noh<CR><CR>
nmap <silent> <leader>f <Plug>DashSearch
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <C-N><C-N> :set invrelativenumber<CR>
map <Leader>tt :Http!<CR>

nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

augroup default
  autocmd!
  autocmd BufEnter,FocusGained * checktime | SignifyRefresh
  autocmd BufWritePre * %s/\s\+$//e  " Strip trailing whitespace
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set termguicolors
set background=dark
" let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_sign_column='bg0'
colors gruvbox
