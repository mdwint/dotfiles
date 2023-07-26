vim.cmd([[
" Rebuild spell file from word list on startup
for p in glob(stdpath("config") . '/spell/*.add', 1, 1)
  if filereadable(p) && (!filereadable(p . '.spl') || getftime(p) > getftime(p . '.spl'))
    exec 'silent mkspell! ' . fnameescape(p)
  endif
endfor

" Highlight yanked text
augroup yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

" For documentation files, enable text wrapping and spell checking
augroup docs_config
  autocmd!
  autocmd BufRead,BufNewFile *.md,*.rst setlocal textwidth=80 spell
augroup END

" For git commit messages, enable spell checking
augroup gitcommit_config
  autocmd!
  autocmd FileType gitcommit setlocal spell
augroup END

" Toggle relative line numbers
augroup number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]])
