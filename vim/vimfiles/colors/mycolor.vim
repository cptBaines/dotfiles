
"set background=dark
hi! clear
if exists("syntax_on")
  syntax reset
endif

"
" My comment
"

let g:colors_name = "mycolor"

" Dark {{{
hi Normal	ctermfg=172 ctermbg=0	
hi Statement	ctermfg=172 ctermbg=0	cterm=bold
hi comment	ctermfg=240 ctermbg=0
hi LineNr	ctermfg=240 ctermbg=0
hi Visual	ctermfg=0 ctermbg=172

hi! default link Constant Normal 
hi! default link Identifier Statement
hi! default link PreProc Normal
hi! default link Type Normal
hi! default link Special Normal 
hi! default link SpecialKey Normal 
hi! default link Directory Normal
" }}}

"" Light {{{
"hi! Normal	 ctermfg=0   ctermbg=15	
"hi! Statement	 ctermfg=0   ctermbg=15	cterm=bold
"hi! comment	 ctermfg=245 ctermbg=15
"hi! LineNr	 ctermfg=245 ctermbg=15
"hi! CursorLineNr ctermfg=0   ctermbg=15  cterm=bold
"hi! Visual	 ctermfg=15 ctermbg=0
"
"hi! default link Constant Normal 
"hi! default link Identifier Statement
"hi! default link PreProc Normal
"hi! default link Type Normal
"hi! default link Special Normal 
"hi! default link SpecialKey Normal 
"hi! default link Directory Normal
"" }}j
