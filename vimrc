runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let g:airline#extensions#tabline#enabled = 1

syntax on
filetype plugin indent on

" vim-airline looks color-less without this term profile set.
set term=xterm-256color
