" ===========================================================================
" Mappings
" ===========================================================================
let mapleader = ","

" Movements {{{
noremap <silent> <C-h> :wincmd h<cr>
noremap <silent> <C-l> :wincmd l<cr>
noremap <silent> <C-j> :wincmd j<cr>
noremap <silent> <C-k> :wincmd k<cr>
" }}}

" ctags {{{
" build tags for your own project with CTRL+F12
noremap <F12> :!ctags -R --c++-kinds=+p --c-kinds=+px --fields=+iaS --extra=+q --languages=C,C++ .<CR> 
" }}}


" edit vimrc {{{
" Make it easy to edit vimrc (mnemonic is 'e'dit 'v'imrc)
nnoremap <silent> <leader>ev :exec "edit " . expand(g:myvimconfig) . "/nvim.vim"<cr>
" Make it easy to edit this flie (mnemonic is 'e'dit 'm'apping)
nnoremap <silent> <leader>em :exec "edit " . expand(g:myvimconfig) . "/mappings.vim"<cr>

" Make it easy to edit local vim config (mnemonic is 'e'dit 'v'im 'l'ocal)
nnoremap <silent> <leader>evl :edit  ~/nvim_local.vim<CR>

" Make it easy to source the changed settings (mnemonic is 'source 'v'imrc)
nnoremap <silent> <leader>sv :so ~/Appdata/Local/nvim/init.vim<cr>
" }}}

" spelling {{{
nnoremap <silent> <leader>sse :set spelllang=se<cr>
nnoremap <silent> <leader>sen :set spelllang=en<cr>
nnoremap <silent> <leader>tsp :set spell!<cr>
" }}}

" Make it easy to save 
nnoremap <leader>s  :w<cr>

