syntax on
filetype plugin indent on
scriptencoding utf-8

set term=xterm-256color
set noswapfile
set title
set laststatus=2
set spell spelllang=en_us
set background=dark


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

"
" plugins
"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"colorscheme inkpot

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
"let g:airline_theme='badwolf'

" ctrlp (fuzzy file/buf matching)
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]migrations$',
    \ }
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
