set makeprg=build.bat
set errorformat=%f(%l\\,%c):\ %m

let s:tc        = 'c:\wsr\tc'
let s:llvm_ver  = 'llvm14'
let s:llvm_arch = 'win64'
let s:wininc    = s:tc .'\home\bjorn\include\win\'

let g:ale_linters = { 'c': ['clang'] }

" TODO: only set this if we have loaded the ale module
" let g:ale_c_clang_options = "' -I". s:wininc  ."'"
let g:ale_c_clang_options = ' -Ic:\wsr\tc\home\bjorn\include\win'

function! Make()
	let $VIM_WD = getcwd()
	let $VIM_WD = expandcmd($VIM_WD)
	set makeprg=vim_build.bat\ $VIM_WD
	cclose
	make!
	if v:shell_error != 0 
		bo copen
	endif
endfunction

function! ReplaceInCFunction()
	exec "normal! ml[[ma][mb<CR>"
	:'a,'bs/"
endfunction

function! InputHeaderGuard()
	let @a = toupper(expand('%:r') . '_h_included')
	exec 'normal mlggO#ifndef a#define a'
	exec 'normal GDo#endif //aO"'
	exec "normal 'l"
endfunction

" This function clobbers the "f register
function! InsHeaderDecklarationsFromCFile()
	" Note maybe we should check that we actually are in a c file
	" grab all function signatures
	exec 'normal! ggqfq'
	g/^[A-Za-z][A-Za-z_0-9]\+(/normal k"Fy]]
	sp %:p:r.h
	exec 'normal! GO'
	/^\/\/ Begin fdecl/,/^\/\/ End fdecl/d
	exec 'normal! I// Begin fdecl// End fdeclk"fpgg'
	/^\/\/ Begin fdecl/,/^\/\/ End fdecl/s/)$/);/
	"wq
endfunction


imap <esc> <esc>
nmap <leader>m :call Make()<CR>
nmap <leader>sd :exe 'ptag ' . expand('<cword>')<CR>
nmap <leader>dd :pclose<CR>
nmap <silent><leader>in :exec 'normal! O// NOTE(bjorn): '<CR>
nmap <silent><leader>it :exec 'normal! O// TODO(bjorn): '<CR>
nmap <silent><leader>ff :exec "normal! ml[[=]['l"<CR>
nmap <leader>rif ml[[ma][mb:'a,'bs/
nmap <leader>rts ml:%s/\s\+$//<CR>'l
nmap <leader>rl :s/
nmap <leader>ihg :call InputHeaderGuard()<CR>
nmap <leader>ihd :call InsHeaderDecklarationsFromCFile()<CR>

