runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()


syntax on
filetype plugin indent on
scriptencoding utf-8

set noswapfile
set title
set laststatus=2
set spell spelllang=en_us

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


autocmd BufRead,BufNewFile *.css setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.html setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.jinja setlocal ft=htmljinja ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.js setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.less setlocal ft=less ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.md setlocal ft=markdown
autocmd BufRead,BufNewFile *.tst setlocal syntax=perl
autocmd BufRead,BufNewFile *.txt setlocal printoptions+=number:n
autocmd BufRead,BufNewFile *.scss setlocal ft=scss ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile Build* setlocal noexpandtab filetype=make syntax=make
autocmd BufRead,BufNewFile [Mm]ake* setlocal noexpandtab filetype=make syntax=make
autocmd FileType crontab set backupcopy=yes

" Remove all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" ctrlp (fuzzy file/buf matching)
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]migrations$',
    \ }
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
