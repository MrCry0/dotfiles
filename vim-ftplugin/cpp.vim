" Informative hint for plugins (e.g. ALE or coc-clangd)
let b:cpp_standard = 'c23'

" Always expand tabs to spaces
setlocal expandtab

" Set indentation width to 4 spaces
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal smarttab

" Enable smart and automatic indentation
setlocal smartindent
setlocal autoindent

" Set line width for formatting
setlocal textwidth=99

" Optional: highlight column 100
setlocal colorcolumn=+1

" Improve formatting behavior
setlocal formatoptions+=croql

setlocal number
setlocal linebreak
setlocal showbreak=+++
setlocal showmatch
setlocal visualbell

setlocal hlsearch
setlocal smartcase
setlocal incsearch

setlocal ruler

setlocal undolevels=1000
setlocal backspace=indent,eol,start
