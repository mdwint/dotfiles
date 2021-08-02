call plug#begin(stdpath('data') . '/plugged')
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

syntax on
filetype plugin on

set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set hidden
set mouse=a
set scrolloff=8
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set wildmenu wildmode=longest:full,full

" Reload config
noremap <leader>r :source $MYVIMRC<cr>

" Quick save
noremap <leader>w :update<cr>

" Persistent undo history
set undofile
nnoremap <leader>u :UndotreeToggle<cr>

" Split windows
set splitbelow splitright
nnoremap <leader>- :sp<cr>
nnoremap <leader>\| :vsp<cr>
nnoremap <leader>o :only<cr>

" Search
set ignorecase smartcase
set inccommand=nosplit
nnoremap <cr> :noh<cr><cr>
nnoremap <c-p> :Telescope find_files theme=get_ivy<cr>
nnoremap <leader>t :Telescope git_files theme=get_ivy<cr>
nnoremap <leader>a :Telescope live_grep theme=get_ivy<cr>
nnoremap <leader>* :Telescope grep_string theme=get_ivy<cr>
nnoremap <leader>b :Telescope buffers theme=get_ivy<cr>
nnoremap <leader>h :Telescope help_tags theme=get_ivy<cr>
nmap <silent> <leader>f <plug>DashSearch

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

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

" Insert undo break points
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
let g:jedi#show_call_signatures="2"

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

" Color scheme
function! s:base16_customize() abort
  call Base16hi("LineNr", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")
  call Base16hi("SignColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")
  call Base16hi("SignifySignAdd", g:base16_gui0B, g:base16_gui00, g:base16_cterm0B, g:base16_cterm00, "", "")
  call Base16hi("SignifySignChange", g:base16_gui0D, g:base16_gui00, g:base16_cterm0D, g:base16_cterm00, "", "")
  call Base16hi("SignifySignDelete", g:base16_gui08, g:base16_gui00, g:base16_cterm08, g:base16_cterm00, "", "")
  call Base16hi("VertSplit", g:base16_gui01, g:base16_gui00, g:base16_cterm01, g:base16_cterm00, "none", "")
  call Base16hi("TelescopeBorder", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")
  call Base16hi("TelescopePromptPrefix", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")

  hi Normal guibg=none ctermbg=none
  hi LineNr guibg=none ctermbg=none
  hi SignColumn guibg=none ctermbg=none
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

set termguicolors
set background=dark

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
