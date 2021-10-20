" General stuff
syntax on
filetype plugin indent on

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None

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
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent smarttab
set showtabline=2
set autoread

function! Format()
  let g:formatter = "" 
  if index(["c", "cpp"], &filetype) >= 0
    let g:formatter = "!clang-format % >formatted && mv formatted %"
  elseif index(["xml", "dtd"], &filetype) >= 0
    let g:formatter = "!xmllint --format % >formatted && mv formatted %"
  elseif index(["rs", "rust"], &filetype) >= 0
    let g:formatter = "!rustfmt %"
  endif

  if g:formatter != ""
		execute "silent " . g:formatter
		execute "e!"
		execute "redraw!"
  endif
endfunction

cnoremap w!! w !sudo tee % >/dev/null
nnoremap <C-S> :w!<CR>
nnoremap <C-Q> :qa!<CR>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <S-I> :call Format()<CR>
nnoremap <C-F> /
nnoremap <C-T> :tabnew \| call Layout()<CR>
nnoremap <C-W> :tabclose<CR>
nnoremap <C-PageUp> :tabnext<CR>
nnoremap <C-PageDown> :tabprevious<CR>
nnoremap <Tab> :nohl \| redraw!<CR> 
nnoremap <C-A> ggVG 
xnoremap p pgvy
vnoremap <Tab> :><CR>
vnoremap <S-Tab> :<<CR>

let g:racer_cmd="/home/psarlov/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/local/src/rustc/src"
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree | wincmd l | terminal
autocmd VimEnter * resize 15 | wincmd k

" Plugins
call plug#begin()
	Plug 'Valloric/YouCompleteMe'
	Plug 'racer-rust/vim-racer'
	Plug 'tyru/open-browser.vim' " opens url in browser
	Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
	Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
	Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
  Plug 'rust-lang/rust.vim'
call plug#end()
