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

" Clear highlights and messages
nnoremap <silent> <cr> :noh<cr>:echo ''<cr>

" Search
nnoremap <silent> <leader>f <plug>DashSearch

" Quickfix list
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]w :lnext<cr>
nnoremap [w :lprev<cr>

" Keep cursor centered when jumping
nnoremap n nzzzv
nnoremap N Nzzzv

" Sort visual selection
vnoremap gs :sort<cr>
vnoremap gS :sort u<cr>

" Format paragraphs
nnoremap <leader>q gqip<cr>
vnoremap <leader>q gq<cr>

" Insert undo checkpoints on punctuation
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ( (<c-g>u
inoremap [ [<c-g>u
inoremap { {<c-g>u

" Toggle spell checking
nnoremap <c-s> :setlocal spell!<cr>

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
