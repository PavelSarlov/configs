syntax on

set splitbelow
set wrap
set number
set clipboard=unnamedplus

let g:racer_cmd="/home/psarlov/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/local/src/rustc/src"
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd VimEnter * terminal
autocmd VimEnter * wincmd k









call plug#begin()

Plug 'Valloric/YouCompleteMe'
Plug 'racer-rust/vim-racer'
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
 
call plug#end()
