runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let g:airline#extensions#tabline#enabled = 1

syntax on
filetype plugin indent on
scriptencoding utf-8

set noswapfile
set title

" vim-airline looks color-less without this term profile set.
" inkpot also needs this.
set term=xterm-256color

colorscheme inkpot

" style/formatting
set autoindent
set colorcolumn=79
set expandtab
set ignorecase
set nowrap
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set tabstop=4

