" This is my first custom color scheme.
"
" It inherits all colors from the terminal, and is meant to be used together
" with base16-shell (https://github.com/chriskempson/base16-shell), allowing
" for easy switching between dark and light modes throughout the day without
" having to restart the editor.
"
" The colors red (1), green (2), and yellow (3) are reserved for errors,
" warnings, search highlights, diffs, and other important aspects of the
" editing experience. They have been omitted from syntax highlighting to avoid
" distractions. This is a little unusual, but it allows me to use a grayscale
" color scheme for syntax highlighting without missing any important details.

hi clear
syntax reset
let g:colors_name = "mdwint"

hi Boolean        ctermfg=16
hi Character      ctermfg=7
hi ColorColumn    ctermbg=18 cterm=none
hi Comment        ctermfg=8
hi Conceal        ctermfg=4 ctermbg=0
hi Conditional    ctermfg=5
hi Constant       ctermfg=16
hi Cursor         ctermfg=0 ctermbg=7
hi CursorColumn   ctermbg=18 cterm=none
hi CursorLine     ctermbg=18 cterm=none
hi CursorLineNr   ctermfg=20 ctermbg=18
hi Debug          ctermfg=7
hi Define         ctermfg=5
hi Delimiter      ctermfg=17
hi DiffAdd        ctermfg=2 ctermbg=0
hi DiffChange     ctermfg=8 ctermbg=0
hi DiffDelete     ctermfg=1 ctermbg=0
hi DiffFile       ctermfg=5 ctermbg=0
hi DiffLine       ctermfg=4 ctermbg=0
hi DiffNewFile    ctermfg=2 ctermbg=0
hi DiffRemoved    ctermfg=1 ctermbg=0
hi DiffText       ctermfg=4 ctermbg=0 cterm=bold
hi Directory      ctermfg=4
hi Error          ctermfg=0 ctermbg=1
hi ErrorMsg       ctermfg=1 ctermbg=0
hi Exception      ctermfg=7
hi Float          ctermfg=16
hi FoldColumn     ctermfg=6 ctermbg=18
hi Folded         ctermfg=8 ctermbg=18
hi Function       ctermfg=4
hi Identifier     ctermfg=7 cterm=none
hi Ignore         ctermfg=0
hi IncSearch      ctermfg=18 ctermbg=16 cterm=none
hi Include        ctermfg=4
hi Keyword        ctermfg=5
hi Label          ctermfg=4
hi LineNr         ctermfg=8 ctermbg=none
hi Macro          ctermfg=7
hi MatchParen     ctermbg=8
hi ModeMsg        cterm=bold ctermfg=3
hi MoreMsg        ctermfg=5
hi NonText        ctermfg=8
hi Normal         ctermfg=7 ctermbg=none
hi Number         ctermfg=16
hi Operator       ctermfg=7
hi Pmenu          ctermfg=7 ctermbg=18 cterm=none
hi PmenuSbar      ctermbg=16
hi PmenuSel       ctermfg=18 ctermbg=7 cterm=none
hi PmenuThumb     ctermbg=15
hi PreProc        ctermfg=4
hi Question       ctermfg=4
hi QuickFixLine   ctermbg=18
hi Repeat         ctermfg=5
hi Search         ctermfg=18 ctermbg=3
hi SignColumn     ctermfg=8 ctermbg=none
hi Special        ctermfg=6
hi SpecialChar    ctermfg=17
hi SpecialKey     ctermfg=8
hi SpellBad       cterm=undercurl ctermbg=none
hi SpellCap       cterm=undercurl ctermbg=none
hi SpellLocal     cterm=undercurl ctermbg=none
hi SpellRare      cterm=undercurl ctermbg=none
hi Statement      ctermfg=4
hi StatusLine     ctermfg=20 ctermbg=19 cterm=none
hi StatusLineNC   ctermfg=8 ctermbg=18 cterm=none
hi StorageClass   ctermfg=4
hi String         ctermfg=16
hi Structure      ctermfg=5
hi Substitute     ctermfg=18 ctermbg=3 cterm=none
hi TabLine        ctermfg=8 ctermbg=18 cterm=none
hi TabLineFill    ctermfg=8 ctermbg=18 cterm=none
hi TabLineSel     ctermfg=7 ctermbg=18 cterm=none
hi Tag            ctermfg=4
hi TermCursor     cterm=reverse
hi Title          ctermfg=4 cterm=none
hi Todo           ctermfg=3 ctermbg=18
hi TooLong        ctermfg=1
hi Type           ctermfg=4
hi Typedef        ctermfg=4
hi Underlined     cterm=underline ctermfg=7
hi VertSplit      ctermfg=18 ctermbg=0 cterm=none
hi Visual         ctermbg=19
hi VisualNOS      ctermfg=1
hi WarningMsg     ctermfg=1
hi WildMenu       ctermfg=7 ctermbg=11

hi link diffAdded DiffAdd
hi link diffOldFile DiffRemoved
hi link pythonSpaceError Normal

hi ALEErrorSign          ctermfg=1 ctermbg=none
hi ALEWarningSign        ctermfg=3 ctermbg=none
hi ALEVirtualTextError   ctermfg=1
hi ALEVirtualTextWarning ctermfg=3
hi link ALEVirtualTextInfo Comment

hi SignifySignAdd    ctermfg=2 ctermbg=none
hi SignifySignChange ctermfg=4 ctermbg=none
hi SignifySignDelete ctermfg=1 ctermbg=none

hi TelescopeBorder       ctermfg=8 ctermbg=0
hi TelescopePromptPrefix ctermfg=8 ctermbg=0
