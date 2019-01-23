
" HERE WE HAVE SOME VUNDLE STUFF
" To install Vundle, the obvious thing to do is:
"     git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"     vim +PluginInstall +qall
set nocompatible                                      " vundle-required.  be iMproved
if isdirectory(expand('~/.vim/bundle/Vundle.vim'))    " my idea
  filetype off                                        " vundle-required.
  set rtp+=~/.vim/bundle/Vundle.vim                   " vundle-required.  set the runtime path to include Vundle
  call vundle#begin()                                 " vundle-required.
  Plugin 'VundleVim/Vundle.vim'                       " vundle-required.  let Vundle manage Vundle

  Plugin 'rust-lang/rust.vim'

  call vundle#end()                                   " vundle required.
else
  echo "WARN: Vundle is not installed.  Hope that's cool.  Vundle plugins aren't enabled."
endif                                                 " my idea
" END OF VUNDLE STUFF





filetype plugin indent on
set modeline
color elflord


set tw=100           " I'm not really sure what I want my default to be

set encoding=utf-8


" Oh god, the tab/space/indent business.
"    I used to use ts=4, sw=4, autoindent, smartindent
"    But at wurldtech, the coding standard is to use spaces-not-tabs
"    I think that maybe this is all done for free in the filetype plugin?

set shiftwidth=2	"  num of spaces used when shifting (using > or <)
"set smarttab		  "  use 'shiftwidth' for BeginLine tab insertion (vs sts/ts)
set expandtab		  "  use spaces when <Tab> is inserted
set softtabstop=2	"  number of spaces that <Tab> uses while editing
set tabstop=2		  "  number of spaces that <Tab> in file uses

"set autoindent		"  take indent for new line from previous line
"set smartindent	"  smart autoindenting for C programs
"set cindent		  "  do C program indenting

set hlsearch
set history=1000
set undolevels=1000
set noswapfile

set number      " I give up on being a wizard; lo I am fallen

set wildmenu      " nicer viewing of partial results when tab-completing filenames (ty Don!)


" an attempt from https://stackoverflow.com/questions/5700389/using-vims-persistent-undo
if has('persistent_undo')
  call system('mkdir -p ~/.vim/.undo')
  set undofile
  set undodir=~/.vim/.undo//
endif




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

