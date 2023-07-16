vim.api.nvim_set_keymap("", "<space>", "<leader>", {})

vim.cmd([[
" Fix annoyances
map q: <nop>
nnoremap Q <nop>
command Q :q
command W :w

" Toggle relative line numbers
nnoremap <c-n><c-n> :set invrelativenumber<cr>

" Split windows
nnoremap <leader>- :sp<cr>
nnoremap <leader>\ :vsp<cr>
nnoremap <leader>o :only<cr>

" Search
nnoremap <cr> :noh<cr><cr>
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

" Toggle netrw file explorer
nnoremap <silent> <leader>e :Lexplore<cr>

" Toggle undo tree
nnoremap <leader>u :UndotreeToggle<cr>

" Send visual selection to origin shell script
function Origin()
  silent execute '!origin % ' . string(getpos('v')[1]) . ' ' . string(getpos('.')[1])
endfunction
vnoremap o <cmd>:call Origin()<cr>
]])