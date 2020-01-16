call plug#begin(stdpath('data') . '/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-highlightedyank'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'jparise/vim-graphql'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'rizzatti/dash.vim'
Plug 'davidhalter/jedi-vim'
Plug 'fisadev/vim-isort'
Plug 'morhetz/gruvbox'
call plug#end()

syntax on
filetype plugin on

set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set mouse=a
set cursorline
set wildmenu wildmode=longest:full,full
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" Escape and save
inoremap jk <esc>:update<cr>

" Persistent undo history
if !isdirectory($HOME . '/.vimdid')
  call mkdir($HOME . '/.vimdid', '', 0700)
endif
set undodir=~/.vimdid
set undofile

" Split windows
set splitbelow splitright
nnoremap <leader>- :sp<cr>
nnoremap <leader>\| :vsp<cr>
nnoremap <leader>o :only<cr>

" Search
set ignorecase smartcase
set inccommand=nosplit
nnoremap <c-p> :Files<cr>
nnoremap <leader>a :Rg<cr>
nnoremap <cr> :noh<cr><cr>
nmap <silent> <leader>f <plug>DashSearch
autocmd VimEnter * delcommand Windows

" Move lines up and down
nnoremap ∆ :m .+1<cr>==
nnoremap ˚ :m .-2<cr>==
inoremap ∆ <esc>:m .+1<cr>==gi
inoremap ˚ <esc>:m .-2<cr>==gi
vnoremap ∆ :m '>+1<cr>gv=gv
vnoremap ˚ :m '<-2<cr>gv=gv

" Highlight yanked text
let g:highlightedyank_highlight_duration=200

" Toggle comments
let g:NERDDefaultAlign='left'
let g:NERDToggleCheckAllLines=1
nmap <c-_> <plug>NERDCommenterToggle
vmap <c-_> <plug>NERDCommenterToggle<cr>gv

" Python
let g:python3_host_prog='~/vim-python/bin/python'

" Editor config
let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']

" Disable automatic popups
let g:jedi#popup_on_dot=0

" Linting
let g:ale_fix_on_save=1
let g:ale_fixers={
\ 'python': ['black'],
\ 'rust': ['rustfmt'],
\ 'terraform': ['terraform'],
\ 'javascript': ['prettier'],
\ 'css': ['prettier'],
\}
nnoremap gj :ALENextWrap<cr>
nnoremap gk :ALEPreviousWrap<cr>
nnoremap g1 :ALEFirst<cr>

" Git signs
let g:signify_vcs_list=['git']
let g:signify_sign_change='~'
augroup gitsigns
  autocmd!
  autocmd BufEnter,FocusGained * checktime | SignifyRefresh
augroup END

" Strip trailing whitespace on save
augroup stripwhitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END

" Toggle relative line numbers
set number relativenumber
nnoremap <c-n><c-n> :set invrelativenumber<cr>
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Color theme
set termguicolors
set background=dark
"let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_sign_column='bg0'
colors gruvbox
