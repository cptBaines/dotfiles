" vim: ts=4:sw=4
set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name="mycolor"

" John Blow color theme
let s:jb_bg				= "#072623"
let s:jb_fg				= "#9D9E8A"
let s:jb_comment		= "#4EA64B"
let s:jb_string			= "#3CA688"
let s:jb_string1		= "#81D9BD"
let s:jb_stmt			= "#CBD9DE"
let s:jb_status			= "#D9B391"

let s:prussian_blue		= "#1d3354" " Prussian Blue
let s:select			= "#bcb9bb" " 

let s:nontext			= "#4D6374" " Adobe modified prussian blue 
let s:dark_fg			= "#223B61"
let s:light				= "#3862A1"
let s:none				= "NONE"
let s:orange			= "#996600"

exe "let s:bg_none		= ' guibg=" . s:none			."'"
exe "let s:bg_back		= ' guibg=" . s:jb_bg			."'"
exe "let s:bg_dark		= ' guibg=" . s:prussian_blue	."'"
exe "let s:bg_light		= ' guibg=" . s:light			."'"
exe "let s:bg_text		= ' guibg=" . s:jb_fg			."'"
exe "let s:bg_nontext	= ' guibg=" . s:nontext			."'"


exe "let s:fg_none		= ' guifg=" . s:none			."'"
exe "let s:fg_text		= ' guifg=" . s:jb_fg			."'"
exe "let s:fg_select	= ' guifg=" . s:select			."'"
exe "let s:fg_cyan		= ' guifg=" . s:jb_string		."'"
exe "let s:fg_green		= ' guifg=" . s:jb_comment		."'"
exe "let s:fg_status	= ' guifg=" . s:jb_status		."'"
exe "let s:fg_stmt		= ' guifg=" . s:jb_stmt			."'"
exe "let s:fg_nontext	= ' guifg=" . s:nontext			."'"
exe "let s:fg_orange	= ' guifg=" . s:orange			."'"


exe "hi! Normal" 		.s:fg_text		.s:bg_back
exe "hi! Comment" 		.s:fg_green		.s:bg_none
exe "hi! Visual" 		.s:fg_select	.s:bg_dark
exe "hi! String" 		.s:fg_cyan		.s:bg_none
exe "hi! StatusLine"	.s:fg_status	.s:bg_back		." gui=reverse"
exe "hi! Statement"		.s:fg_stmt		.s:bg_back		." gui=None"
exe "hi! LineNr"		.s:fg_text		.s:bg_back
exe "hi! NonText"		.s:fg_nontext	.s:bg_back		." gui=None"
exe "hi! Todo"			.s:fg_green		.s:bg_nontext	." gui=bold"
exe "hi! MatchParen"	.s:fg_text		.s:bg_light		." gui=bold"


hi! def link WildMenu 		MatchParen
hi! def link Pmenu 			Normal
hi! def link SignColumn		Normal
hi! def link PmenuSel 		Visual
hi! def link Constant 		Normal
hi! def link SpecialChar    String	
hi! def link Identifier 	Normal
hi! def link Type 			Normal
hi! def link Number 		String
hi! def link Float			String
hi! def link Character		String
hi! def link Boolean		String
hi! def link Conditional	Statement
hi! def link Repeat			Statement
hi! def link Label			Statement
hi! def link Operator		Normal
hi! def link Keyword		Normal
hi! def link Exception		Normal
hi! def link Include		Normal
hi! def link Define			Normal
hi! def link Macro			Normal
hi! def link PreCondit		Normal
hi! def link Tag			Normal
hi! def link Delimiter		Normal
hi! def link SpecialComment	Normal
hi! def link Debug			Normal
hi! def link Folded			Normal
hi! def link PreProc		Normal
hi! def link Search			StatusLine

