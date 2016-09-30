syntax on
filetype plugin indent on
scriptencoding utf-8

"set term=xterm-256color
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

set list
set listchars=
set listchars=extends:‥,precedes:‥,tab:>-,trail:·

set mouse=a

autocmd BufRead,BufNewFile *.css setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.html setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.jinja setlocal ft=htmljinja ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.js setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.less setlocal ft=less ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.md setlocal ft=markdown ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.tst setlocal syntax=perl
autocmd BufRead,BufNewFile *.txt setlocal printoptions+=number:n
autocmd BufRead,BufNewFile *.scss setlocal ft=scss ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.yaml setlocal ft=yaml ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.yml setlocal ft=ansible ts=2 sw=2 sts=2

autocmd BufRead,BufNewFile Vagrantfile setlocal ft=ruby ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile Build* setlocal noexpandtab filetype=make syntax=make
autocmd BufRead,BufNewFile [Mm]ake* setlocal noexpandtab filetype=make syntax=make
autocmd FileType crontab set backupcopy=yes

" Remove all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"
" plugins
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'mitsuhiko/vim-python-combined'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
"Plug 'ciaranm/inkpot'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'mitsuhiko/vim-jinja'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Ada-Bundle'
Plug 'pearofducks/ansible-vim'
Plug 'alfredodeza/pytest.vim'
Plug 'lambdatoast/elm.vim'
Plug 'fatih/vim-go'
Plug 'clausreinke/typescript-tools.vim', { 'do': 'npm install' }

" Add plugins to &runtimepath
call plug#end()

"runtime bundle/vim-pathogen/autoload/pathogen.vim
"execute pathogen#infect()

"colorscheme inkpot

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#whitespace#enabled = 1

" let g:airline_mode_map = {
"     \ '__' : '----',
"     \ 'n'  : 'norm',
"     \ 'i'  : 'insr',
"     \ 'R'  : 'rplc',
"     \ 'v'  : 'vis ',
"     \ 'V'  : 'vlin',
"     \ 'c'  : 'cmd',
"     \ 's'  : 'slct',
"     \ 'S'  : 'slin',
"     \ 't'  : 'term',
"     \ }

"let g:airline_theme = 'solarized'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.linecolumn_prefix = '¶ '

let g:airline_section_z = '0x%-4B %3p%% '.g:airline_symbols.linecolumn_prefix.'%3l:%3c'

" ctrlp (fuzzy file/buf matching)
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]migrations$',
    \ }
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

let mapleader=" "
" Pytest
nmap <silent><Leader>f <Esc>:Pytest file looponfail<CR>
nmap <silent><Leader>c <Esc>:Pytest class looponfail<CR>
nmap <silent><Leader>m <Esc>:Pytest method looponfail<CR>

