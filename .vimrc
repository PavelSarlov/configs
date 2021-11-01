call plug#begin("~/vimfiles/plugged")
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Valloric/YouCompleteMe'
call plug#end()

filetype plugin indent on
syntax on

" autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
" autocmd FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None

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
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent smarttab
set autoread
set nocompatible
set backspace=2
set shell=powershell

function! Format()
  let g:formatter = ""
  let g:format_args = "% >/tmp/formatted && mv /tmp/formatted %"
  
  if index(["c", "cpp"], &filetype) >= 0
    let g:formatter = "!clang-formatter"
  elseif index(["xml", "dtd"], &filetype) >= 0
    let g:formatter = "!xmllint"
    let g:format_args = "--format " . g:format_args 
  elseif index(["rs", "rust"], &filetype) >= 0
    let g:formatter = "!rustfmt"
    let g:format_args = "%"
  endif

  if g:formatter != ""
		execute "silent " . g:formatter . " " . g:format_args
		execute "e!"
		execute "redraw!"
  endif
endfunction

cnoremap w!! w !sudo tee % >/dev/null
nnoremap <C-S> :w!<CR>
nnoremap <C-Q> :qa!<CR>
nnoremap <S-I> :call Format()<CR>
nnoremap <C-F> /
nnoremap <C-T> :tabnew<CR>
nnoremap <Tab> :nohl \| redraw!<CR> 
nnoremap <C-X> <C-V>
nnoremap <C-A> ggVG
" nnoremap <C-W> :tabclose<CR>
" nnoremap <C-PageUp> :tabnext<CR>
" nnoremap <C-PageDown> :tabprevious<CR>

" WSL yank support
" let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
" if executable(s:clip)
"     augroup WSLYank
"         autocmd!
"         autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"     augroup END
" endif

let g:racer_cmd="${WINHOME}/.cargo/bin/racer.exe"
let $RUST_SRC_PATH="/usr/local/src/rustc/src"
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree | wincmd l | terminal
autocmd VimEnter * resize 15 | wincmd k
