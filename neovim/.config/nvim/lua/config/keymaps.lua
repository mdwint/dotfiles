vim.api.nvim_set_keymap("", "<space>", "<leader>", {})

vim.cmd([[
" Fix annoyances
map q: <nop>
nnoremap Q <nop>
command Q :q
command W :w

" Toggle relative line numbers
nnoremap <c-n> :set invrelativenumber<cr>

" Split windows
nnoremap <leader>- :sp<cr>
nnoremap <leader>\ :vsp<cr>
nnoremap <leader>o :only<cr>

" Search
nnoremap <silent> <cr> :noh<cr>:echo ''<cr><cr>
nnoremap <silent> <leader>f <plug>DashSearch

" Quickfix list
nnoremap <leader>j :cnext<cr>
nnoremap <leader>k :cprev<cr>
nnoremap <leader>1 :cfirst<cr>
nnoremap gj :lnext<cr>
nnoremap gk :lprev<cr>
nnoremap g1 :lfirst<cr>

" Keep cursor centered when jumping
nnoremap n nzzzv
nnoremap N Nzzzv

" Sort visual selection
vnoremap gs :sort<cr>
vnoremap gS :sort u<cr>

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

" Toggle spell checking
nnoremap <c-s> :setlocal spell!<cr>

" Toggle netrw file explorer
nnoremap <silent> <leader>e :Lexplore<cr>

" Toggle undo tree
nnoremap <silent> <leader>u :UndotreeToggle<cr>

" Send visual selection to origin shell script
function Origin()
  silent execute '!origin % ' . string(getpos('v')[1]) . ' ' . string(getpos('.')[1])
endfunction
vnoremap o <cmd>:call Origin()<cr>

" Add a line to the start of the current buffer (useful for imports)
function PrependLine()
  let l:line = input("Prepend line: ")
  if len(l:line)
    call nvim_buf_set_lines(0, 0, 0, 0, [l:line])
  endif
endfunction
nnoremap <leader>i <cmd>:call PrependLine()<cr>
]])
