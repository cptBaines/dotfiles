" ===========================================================================
" Global vim setting
" ===========================================================================

" Enable filtype stuff
filetype on
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Setup linenumbering
set number 
" set relativenumber

" configure tags
set tags+=tags,../tags,$sysroot/etc/tags

" Show me when i'm over 80 columns wide
call matchadd('colorcolumn', '\%81v', 100)

" Contol the character shown for the list command
exec "set listchars=tab:>\uBB,trail:~,nbsp:_,eol:$"

" Make it ok to have an unwritten buffer that is not visible
set hidden

" disable bloody beeping
set vb

" Keep some history
set history=10

" set commandline height to two rows
set ch=2

" Make the 'cw' and like commands put a $ at the end instead of just deliting
" the text and replacing it. B is included to handle conflicts with snipmate
set cpoptions=Bces$

" Don't update the display while executing macros
set lazyredraw

" Show the current command in the lower right cornder
set showcmd

" Show the current mode
set showmode

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Disable popup menues
set completeopt=longest 

" Disable wild menu get the suggestions directly in text
set nowildmenu

" Setup Runtime path to include g:myvimfiles {{{
let &runtimepath = g:myvimfiles . "," . &runtimepath . "," . g:myvimfiles . "/after"
" }}}

" Color must be set after we fixed the runtime if we want to find any custom
" colorschems
colorscheme mycolor

" ===========================================================================
" Add plugins, templates, source mappings and any local config 
" ===========================================================================

" Enable patogen (load plugins)
execute pathogen#infect(myvimfiles . '/bundle/{}')

let $VIM_TMPL_DIR = myvimfiles . "/templates"
exe "source " . $VIM_TMPL_DIR . "/autocmd.vim"

" Sorce default mappings 
exe "source " . myvimconfig . "/mappings.vim"

" ===========================================================================
" Sourceig local configurations 
" ===========================================================================
if $OS == "Windows_NT"
	source $USERPROFILE/nvim_local.vim
else
	source ~/.nvim_local.vim
endif

