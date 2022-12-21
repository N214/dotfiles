" Vim will use the clipboard register '*' for all yank, delete, change and put  
set clipboard=unnamed
" Save undos in a default file
set undofile 
" No screen update when executing macros for more speed
set lazyredraw
set ttyfast

" Set numbers
set nu 
" Use 2 spaces instead of tab
set tabstop=2 shiftwidth=2 expandtab 
" Autoindent when go to new line keep same indentation
set ai 

filetype off
filetype plugin indent on
syntax on
