call plug#begin(stdpath('data') . '/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mbbill/undotree'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rizzatti/dash.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

syntax enable
colors mdwint
filetype plugin on

set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set hidden
set mouse=a
set scrolloff=8
set shell=/bin/bash
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set wildmenu wildmode=longest:full,full
map <space> <leader>

" Reload config
noremap <leader>v :source $MYVIMRC<cr>

" Quick save
noremap <leader>w :update<cr>

" Fix annoyances
map q: <nop>
nnoremap Q <nop>
command Q :q
command W :w

" Persistent undo history
set undofile
nnoremap <leader>u :UndotreeToggle<cr>

" Split windows
set splitbelow splitright
nnoremap <leader>- :sp<cr>
nnoremap <leader>\ :vsp<cr>
nnoremap <leader>o :only<cr>

" Search
set ignorecase smartcase
set inccommand=nosplit
nnoremap <cr> :noh<cr><cr>
nnoremap <c-p> :Telescope find_files hidden=true theme=get_ivy<cr>
nnoremap <leader>a :Telescope live_grep theme=get_ivy<cr>
nnoremap <leader>8 :Telescope grep_string theme=get_ivy<cr>
nnoremap <leader>b :Telescope buffers theme=get_ivy<cr>
nnoremap <leader>h :Telescope help_tags theme=get_ivy<cr>
nmap <silent> <leader>f <plug>DashSearch

lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      ".git/",
      ".tox/",
      "node_modules/",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  extensions = {
    fzf = {},
  }
}
require('telescope').load_extension('fzf')

require('Comment').setup()
EOF

" Quickfix list
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else | cclose | endif
endfunction
nnoremap <c-q> :call ToggleQuickFix()<cr>
nnoremap <leader>j :cnext<cr>
nnoremap <leader>k :cprev<cr>
nnoremap <leader>1 :cfirst<cr>
nnoremap gj :lnext<cr>
nnoremap gk :lprev<cr>
nnoremap g1 :lfirst<cr>

" Yank until end of line
nnoremap Y y$

" Keep cursor centered when jumping
nnoremap n nzzzv
nnoremap N Nzzzv

" Move lines up/down and reformat (alt-k/j)
nnoremap ∆ :m .+1<cr>==
nnoremap ˚ :m .-2<cr>==
inoremap ∆ <esc>:m .+1<cr>==gi
inoremap ˚ <esc>:m .-2<cr>==gi
vnoremap ∆ :m '>+1<cr>gv=gv
vnoremap ˚ :m '<-2<cr>gv=gv

" Insert undo checkpoints on punctuation
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ( (<c-g>u
inoremap [ [<c-g>u
inoremap { {<c-g>u

" Configure netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_winsize=20
nnoremap <silent> <leader>e :Lexplore<cr>

" Highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank()

" Toggle comments
nmap <c-_> gcc
vmap <c-_> gccgv

" Python
let g:python3_host_prog='~/.pyenv/versions/3.7.4/bin/python'
let g:loaded_python_provider=0

" Disable automatic popups
let g:jedi#popup_on_dot=0
let g:jedi#show_call_signatures='2'

" Linting
let g:ale_fix_on_save=1
let g:ale_fixers={
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['black'],
\ 'go': ['goimports'],
\ 'rust': ['rustfmt'],
\ 'c': ['clang-format'],
\ 'cpp': ['clang-format'],
\ 'terraform': ['terraform'],
\ 'javascript': ['prettier'],
\ 'css': ['prettier'],
\ 'json': ['jq'],
\ 'xml': ['xmllint'],
\}
let g:ale_sign_error='✘'
let g:ale_sign_warning='?'
let g:ale_virtualtext_cursor=1
let g:ale_virtualtext_prefix=' # '

" Git plugins config
let g:fugitive_dynamic_colors=0
lua << EOF
require('gitsigns').setup{
  signs = {
    add = {text = '+'},
    change = {text = '~'},
  },
}
EOF

" For documentation files, enable text wrapping and spell checking
augroup docs_config
  autocmd!
  autocmd BufRead,BufNewFile *.md,*.rst setlocal textwidth=80 spell spelllang=en
augroup END

" Toggle relative line numbers
set number relativenumber
nnoremap <c-n><c-n> :set invrelativenumber<cr>
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Show syntax group of text under cursor
function! SynGroup()
  let l:s=synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
nnoremap <leader>i :call SynGroup()<cr>
