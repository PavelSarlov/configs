let g:python3_host_prog="~/anaconda3/envs/nvim/bin/python3"

call plug#begin("~/.local/share/nvim/site/plugged")
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'morhetz/gruvbox'
Plug 'Chiel92/vim-autoformat'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" highlight and indent
set nocompatible
filetype plugin indent on
syntax on

set background=dark
augroup colorscheme_setup
    au!
    au VimEnter * ++nested colorscheme gruvbox
    au VimEnter * highlight Normal ctermfg=lightgray ctermbg=None guibg=None
augroup END

augroup file_change
    au!
    au FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
    au FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None
augroup END

augroup layout
    au!
    au VimEnter,TabNew * NERDTree | wincmd l
    if has("nvim")
        au VimEnter,TabNew * split
    endif
    au VimEnter,TabNew * terminal
    au VimEnter,TabNew * resize 15 | wincmd k
augroup END

" autocomplete features
set omnifunc=syntaxcomplete#complete

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
set backspace=2
set virtualedit=all
set visualbell
set t_vb=

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
nnoremap <C-s> :w!<CR>
nnoremap <A-q> :qa!<CR>
nnoremap <A-w> :tabclose!<CR>
nnoremap <S-f> :Autoformat<CR>
nnoremap <C-f> /
nnoremap <C-t> :tabnew<CR>
nnoremap <Tab> :nohl \| redraw!<CR>
nnoremap <C-a> ggVG
nnoremap <C-k> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>

" self-closing brackets / quote
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {;<CR> {<CR>};<Esc>O

" splits management
tnoremap <Esc> <C-\><C-N>
tnoremap <A-h> <C-\><C-N><C-W>h
tnoremap <A-j> <C-\><C-N><C-W>j
tnoremap <A-k> <C-\><C-N><C-W>k
tnoremap <A-l> <C-\><C-N><C-W>l
inoremap <A-h> <C-\><C-N><C-W>h
inoremap <A-j> <C-\><C-N><C-W>j
inoremap <A-k> <C-\><C-N><C-W>k
inoremap <A-l> <C-\><C-N><C-W>l
nnoremap <A-h> <C-W>h
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-l> <C-W>l
nnoremap <A-=> <C-W>+
nnoremap <A--> <C-W>-

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
