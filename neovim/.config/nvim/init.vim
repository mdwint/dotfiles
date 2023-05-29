lua require("cfg")

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
set completeopt+=longest
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
nmap <silent> <leader>f <plug>DashSearch

" Completion
let g:SuperTabClosePreviewOnPopupClose=1

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

" Send visual selection to origin shell script
function Origin()
  silent execute "!origin % " . string(getpos("v")[1]) . " " . string(getpos(".")[1])
endfunction
vnoremap o <cmd>:call Origin()<cr>
