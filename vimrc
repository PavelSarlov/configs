" General stuff
syntax on

set encoding=utf-8 fileencoding=utf-8
set nobackup nowritebackup noswapfile noundofile
set ignorecase smartcase incsearch hlsearch
set title ruler
set wildmenu
set showmode
set splitbelow
set wrap
set number
set clipboard^=unnamed,unnamedplus
set softtabstop=4 shiftwidth=4 expandtab autoindent

cnoremap w!! w !sudo tee % >/dev/null
nnoremap <C-S> :w!
nnoremap <C-Q> :qa!
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

let g:racer_cmd="/home/psarlov/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/local/src/rustc/src"
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd VimEnter * terminal
autocmd VimEnter * wincmd k

" Plugins
call plug#begin()

Plug 'Valloric/YouCompleteMe'
Plug 'racer-rust/vim-racer'
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
 
call plug#end()
