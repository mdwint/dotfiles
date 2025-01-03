" This is my first custom color scheme.
"
" It inherits all colors from the terminal, and is meant to be used together
" with my ~/bin/colors script, allowing for easy switching between dark and
" light modes throughout the day without having to restart the editor.
"
" The colors red (1), green (2), and yellow (3) are reserved for errors,
" warnings, search highlights, diffs, and other important aspects of the
" editing experience. They have been omitted from syntax highlighting to avoid
" distractions. This is a little unusual, but it allows me to use a grayscale
" color scheme for syntax highlighting without missing any important details.

hi clear
syntax reset
set notermguicolors
let g:colors_name = 'mdwint'

hi Boolean        ctermfg=6
hi Character      ctermfg=7
hi ColorColumn    ctermbg=18 cterm=none
hi Comment        ctermfg=8
hi Conceal        ctermfg=4 ctermbg=0
hi Conditional    ctermfg=5
hi Constant       ctermfg=7
hi Cursor         ctermfg=0 ctermbg=7
hi CursorColumn   ctermbg=18 cterm=none
hi CursorLine     ctermbg=18 cterm=none
hi CursorLineNr   ctermfg=20 ctermbg=18 cterm=none
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
hi Exception      ctermfg=5
hi Float          ctermfg=6
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
hi MatchParen     ctermbg=8 cterm=bold
hi ModeMsg        cterm=bold ctermfg=7
hi MoreMsg        ctermfg=5
hi NonText        ctermfg=18
hi Normal         ctermfg=7 ctermbg=none
hi Number         ctermfg=6
hi Operator       ctermfg=5
hi Pmenu          ctermfg=7 ctermbg=18 cterm=none
hi PmenuSbar      ctermbg=19
hi PmenuSel       ctermfg=18 ctermbg=7 cterm=none
hi PmenuThumb     ctermbg=20
hi PreProc        ctermfg=4
hi Question       ctermfg=4
hi QuickFixLine   ctermbg=18
hi Repeat         ctermfg=5
hi Search         ctermfg=18 ctermbg=3
hi SignColumn     ctermfg=8 ctermbg=none
hi Special        ctermfg=6
hi SpecialChar    ctermfg=17
hi SpecialKey     ctermfg=8
hi SpellBad       cterm=undercurl ctermbg=none guisp=none
hi SpellCap       cterm=undercurl ctermbg=none guisp=none
hi SpellLocal     cterm=undercurl ctermbg=none guisp=none
hi SpellRare      cterm=undercurl ctermbg=none guisp=none
hi Statement      ctermfg=4
hi StatusLine     ctermfg=20 ctermbg=19 cterm=none
hi StatusLineNC   ctermfg=8 ctermbg=18 cterm=none
hi StorageClass   ctermfg=4
hi String         ctermfg=6
hi Structure      ctermfg=5
hi Substitute     ctermfg=18 ctermbg=3 cterm=none
hi TabLine        ctermfg=8 ctermbg=18 cterm=none
hi TabLineFill    ctermfg=8 ctermbg=18 cterm=none
hi TabLineSel     ctermfg=7 ctermbg=18 cterm=none
hi Tag            ctermfg=4
hi TermCursor     cterm=reverse
hi Title          ctermfg=4 cterm=none
hi Todo           ctermfg=3 ctermbg=none
hi TooLong        ctermfg=1
hi Type           ctermfg=4
hi Typedef        ctermfg=4
hi Underlined     cterm=underline ctermfg=7
hi Visual         ctermfg=7 ctermbg=19
hi VisualNOS      ctermfg=1
hi WarningMsg     ctermfg=1
hi WildMenu       ctermfg=7 ctermbg=11
hi WinSeparator   ctermfg=18 ctermbg=0 cterm=none

hi! link @module Identifier
hi! link @variable Identifier
hi! link DiagnosticVirtualTextHint Comment

hi DiagnosticUnderlineError guisp=none
hi DiagnosticUnderlineWarn  guisp=none
hi DiagnosticUnderlineInfo  guisp=none
hi DiagnosticUnderlineHint  guisp=none
hi DiagnosticUnderlineOk    guisp=none

hi link diffAdded DiffAdd
hi link diffOldFile DiffRemoved
hi link fugitiveStagedModifier DiffAdd
hi link fugitiveUnstagedModifier DiffRemoved
hi link pythonSpaceError Normal
hi link FidgetTitle Debug
hi link FidgetTask NonText
hi link GitSignsStagedAdd NonText
hi link GitSignsStagedChange NonText
hi link GitSignsStagedDelete NonText
hi link GitSignsStagedChangedelete NonText

hi TelescopeBorder       ctermfg=8 ctermbg=0
hi TelescopePromptPrefix ctermfg=8 ctermbg=0

let g:fugitive_dynamic_colors = 0
