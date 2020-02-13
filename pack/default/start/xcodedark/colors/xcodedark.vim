"
" xcodedark
"
" Damn-close approximation of Xcode's "Default (Dark)" color scheme.
"

hi clear
syntax reset

let g:colors_name="xcodedark"

hi Comment ctermfg=242
hi Constant ctermfg=134
hi Cursor ctermbg=231
hi CursorLine cterm=none ctermbg=236
hi Function ctermfg=114
hi Identifier ctermfg=73
hi NonText ctermfg=23
hi Normal ctermbg=235 ctermfg=254
hi Number ctermfg=179
hi PreCondit ctermfg=208
hi PreProc ctermfg=208
hi Statement ctermfg=205
hi String ctermfg=203
hi Type ctermfg=183
hi Visual ctermbg=240

hi ErrorMsg          cterm=standout ctermbg=none
hi SpellBad          cterm=standout ctermbg=none
hi NvimInternalError cterm=standout ctermbg=none

hi MatchParen ctermbg=226 ctermfg=235
