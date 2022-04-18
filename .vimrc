call plug#begin("~/.vim/plugged")
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'Chiel92/vim-autoformat'
call plug#end()

filetype plugin indent on
syntax on

augroup file_change
    au!
    au FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
    au FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None
augroup END

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
set virtualedit=all
set visualbell
set t_vb=

set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
highlight Normal ctermfg=lightgrey ctermbg=black

if has("win64") || has("win32")
    set ff=dos

    let g:DEFAULTSHELL="powershell"

    if executable("pwsh")
        let g:DEFAULTSHELL="pwsh"
    endif

    execute "set shell=" . g:DEFAULTSHELL
endif

if has("unix")
    set ff=unix

    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

cnoremap w!! w !sudo tee % >/dev/null
nnoremap <C-S> :w!<CR>
nnoremap <S-Q> :qa!<CR>
nnoremap <C-Q> :tabclose!<CR>
nnoremap <S-F> :Autoformat<CR>
nnoremap <C-F> /
nnoremap <C-T> :tabnew<CR>
nnoremap <Tab> :nohl \| redraw!<CR>
nnoremap <C-A> ggVG
nnoremap <C-K> :tabnext<CR>
nnoremap <C-J> :tabprevious<CR>

if executable("racer.exe")
    let g:racer_cmd="${WINHOME}/.cargo/bin/racer.exe"
endif

if executable("rustc.exe")
    let g:rustc_path="${WINHOME}/.cargo/bin/rustc"
endif

if exists(":NERDTree")
    let g:NERDTreeShowHidden=1
    let g:NERDTreeChDirMode=2
endif

augroup layout
    au!
    au VimEnter,TabNew * NERDTree | wincmd l | terminal
    au VimEnter,TabNew * resize 15 | wincmd k
augroup END

