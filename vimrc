
" HERE WE HAVE SOME VUNDLE STUFF
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'     " let Vundle manage Vundle, required
Plugin 'rust-lang/rust.vim'
call vundle#end()            " required
" END OF VUNDLE STUFF





filetype plugin indent on
set modeline
color elflord


set tw=100           " I'm not really sure what I want my default to be


" Oh god, the tab/space/indent business.
"    I used to use ts=4, sw=4, autoindent, smartindent
"    But at wurldtech, the coding standard is to use spaces-not-tabs
"    I think that maybe this is all done for free in the filetype plugin?

set shiftwidth=2	"  num of spaces used when shifting (using > or <)
"set smarttab		"  use 'shiftwidth' for BeginLine tab insertion (vs sts/ts)
set expandtab		"  use spaces when <Tab> is inserted
set softtabstop=2	"  number of spaces that <Tab> uses while editing
set tabstop=2		"  number of spaces that <Tab> in file uses

"set autoindent		"  take indent for new line from previous line
"set smartindent	"  smart autoindenting for C programs
"set cindent		"  do C program indenting

set hlsearch
set history=1000
set undolevels=1000
set noswapfile

" On  opening file, move cursor to last known position
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" fix auto-detection of markdown filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"" enable yaml.vim filetype plugin
"au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

"" I don't even have a markdown plugin, why does this work?  But it does!
au BufNewFile,BufRead *.markdown,*.md,*.mdown set filetype=markdown

"" If I'm gonna use apennwar's djb-redo, I better do this:
"au BufNewFile,BufRead *.do set filetype=sh

