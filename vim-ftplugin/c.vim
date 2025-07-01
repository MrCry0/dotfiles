" Linux kernel coding style for C files

" Skip this file if we're in a C++ filetype
if &filetype !=# 'c' | finish | endif

" Always use hard tabs (tab character = 8 spaces)
setlocal noexpandtab

" Tab is 8 spaces wide
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8

" Enable smart indentation and automatic indenting
setlocal smartindent
setlocal autoindent
setlocal cindent

" Disable text wrapping by default
setlocal textwidth=0

" Highlight column 80 (soft guide only, kernel style expects 80-char limit)
setlocal colorcolumn=80

" Remove common formatoptions that could interfere
" 'c' - auto-wrap comments using textwidth (optional)
" 'r' - insert comment leader on Enter
" 'o' - insert comment leader after 'o' or 'O'
" 'q' - allow formatting of comments with `gq`
" 'l' - long lines not broken in insert mode
setlocal formatoptions=croq

" Use Linux style for comments
setlocal comments=sl:/*,mb:*,elx:*/

" Optional: If using cscope or tag-based navigation
setlocal suffixesadd+=.c,.h

setlocal number
setlocal linebreak
setlocal showbreak=+++
setlocal textwidth=80
setlocal showmatch
setlocal visualbell

setlocal hlsearch
setlocal smartcase
setlocal ignorecase
setlocal incsearch

setlocal ruler

setlocal undolevels=1000
setlocal backspace=indent,eol,start
