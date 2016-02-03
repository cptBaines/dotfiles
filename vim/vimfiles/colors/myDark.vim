hi clear
set background=dark
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "myDark"

" My definitions {{{
highlight bniLink	guifg=#ffff00
highlight bniLinkBold	guifg=#ffff00 gui=Bold
highlight bniComment	guifg=#444444 guibg=#000000
highlight bniBold	guifg=#ffa529 guibg=#000000 cterm=bold
highlight Normal	guifg=#ffa529 guibg=#000000
highlight Visual	guibg=#ffa529 guifg=#000000
highlight ColorColumn	guifg=#000000 guibg=#ff0000

" Highligt matching parenteces
highlight clear MatchParen
highlight! def link MatchParen bniLinkBold
"}}}

" Programming {{{
highlight clear Type
highlight clear Statement
highlight clear PreProc
highlight clear Identifier
highlight! def link Delimiter Normal
highlight! def link Identifier bniBold
highlight! def link Comment bniComment
" }}}

