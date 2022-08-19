augroup templates
autocmd! templates	
autocmd BufNewFile *.h exe '0r ' . $VIM_TMPL_DIR . '/h_file.tmpl'
autocmd BufNewFile *.h exe '1s/<FILENAME>/' . expand('%:t')
autocmd BufNewFile *.h exe '1s/<DATE>/' . strftime('%b %Y')
autocmd BufNewFile *.h exe '6,8s/<GUARD>/INCLUDED_' . toupper(expand('%:t:r'))
autocmd BufNewFile *.h exe '9s/<YEAR>/' strftime('%Y') . '/ | normal 8GO'
autocmd BufNewFile *.h set filetype=utf8
autocmd BufEnter   *.h set filetype=utf8

autocmd BufNewFile *.c exe '0r ' . $VIM_TMPL_DIR . '/c_file.tmpl'
autocmd BufNewFile *.c exe '1s/<FILENAME>/' . expand('%:t')
autocmd BufNewFile *.c exe '1s/<DATE>/' . strftime('%b %Y') 
autocmd BufNewFile *.c exe '7s/<YEAR>/' strftime('%Y') . '/ | normal 6G'
autocmd BufNewFile *.c set filetype=utf8
autocmd BufEnter   *.c set filetype=utf8

autocmd BufNewFile *.adoc exe '0r ' . $VIM_TMPL_DIR . '/adoc_file.tmpl'
autocmd BufNewFile *.adoc exe '1s/<FILENAME>/' . expand('%:t')
autocmd BufNewFile *.adoc exe '4s/<DATE>/' . strftime('%Y-%m-%d') . '/ normal G'
autocmd BufNewFile *.adoc set filetype=utf8
autocmd BufEnter   *.adoc set filetype=utf8

augroup END
