" vim: ts=4:sw=4
set background=light
hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "mygray"

hi! Normal		guifg=darkblue	guibg=lightgray	ctermfg=darkblue	ctermbg=lightgray
hi Comment		guifg=darkgreen	guibg=lightgray	ctermbg=lightgreen 	ctermbg=lightgray	
hi MatchParen 	guifg=darkblue	guibg=cyan		ctermfg=darkblue  	ctermbg=cyan

hi! LineNr		guifg=darkred	guibg=lightgray	ctermfg=darkred		ctermbg=lightgray
hi Visual		guifg=yellow	guibg=darkblue
" hi! Folded		guibg=gray		guifg=darkblue		ctermbg=darkblue	ctermfg=cyan

"hi Pmenu		guibg=gray	guifg=darkblue	ctermbg=gray ctermfg=darkblue 
"hi PmenuSel		guibg=darkgray	guifg=black	ctermbg=darkgray ctermfg=black 

hi! def link Constant 		Normal 
hi! def link SpecialChar 	Normal 
hi! def link Identifier 	Normal 
hi! def link Type 			Normal 
hi! def link String 		Normal 
hi! def link Number 		Normal 
hi! def link Float			Normal 
hi! def link Character		Normal 
hi! def link Boolean		Normal 
hi! def link Conditional	Normal
hi! def link Repeat			Normal
hi! def link Label			Normal
hi! def link Operator		Normal
hi! def link Keyword		Normal
hi! def link Exception		Normal
hi! def link Include		Normal
hi! def link Define			Normal
hi! def link Macro			Normal
hi! def link PreCondit		Normal
hi! def link SpecialChar	Normal
hi! def link Tag			Normal
hi! def link Delimiter		Normal
hi! def link SpecialComment	Normal
hi! def link Debug			Normal
hi! def link Folded			Normal
