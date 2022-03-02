call plug#begin("~/.vim/plugged")
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Valloric/YouCompleteMe'
call plug#end()

filetype plugin indent on
syntax on

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None

" highlight Normal ctermfg=lightgrey ctermbg=black
colorscheme desert

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

if has("win64") || has("win32")
    set ff=dos

    let g:format_args = "% >formatted && mv formatted % -Force"
    let g:DEFAULTSHELL="powershell"
    
    if executable("pwsh")
        let g:DEFAULTSHELL="pwsh"
    endif
    
    execute "set shell=" . g:DEFAULTSHELL
endif

if has("unix")
    set ff=unix

    let g:format_args = "% >formatted && mv formatted %"

    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

function! Format()
    let g:formatter = ""
  
    if index(["c", "cpp"], &filetype) >= 0
        let g:formatter = "!clang-formatter"
    elseif index(["xml", "dtd"], &filetype) >= 0
        let g:formatter = "!xmllint"
        let g:format_args = "--format " . g:format_args 
    elseif index(["rs", "rust"], &filetype) >= 0
        let g:formatter = "!rustfmt"
        let g:format_args = "%"
    elseif index(["html","css","javascript","json","js"], &filetype) >= 0
        let l:format = &filetype
        if "javascript" == &filetype
            let l:format = "js"
        endif
        let g:formatter = "!beautify"
        let g:format_args = "-f " . l:format . " -o formatted % && mv formatted %"
    elseif index(["python", "py"], &filetype) >= 0
        let g:formatter = "!black"
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
nnoremap <S-F> :call Format()<CR>
nnoremap <C-F> /
nnoremap <C-T> :tabnew<CR>
nnoremap <Tab> :nohl \| redraw!<CR> 
nnoremap <C-A> ggVG

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
    autocmd VimEnter * NERDTree | wincmd l | terminal
    autocmd VimEnter * resize 15 | wincmd k
augroup END
