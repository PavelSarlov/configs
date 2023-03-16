" OS specifics
if has("win64") || has("win32")
  set ff=dos

  let g:SLASH="\\"

  set shell=powershell

  if executable('pwsh')
    set shell=pwsh
  endif

  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=

  if has("nvim")
    let $VIMHOME = $HOME . g:SLASH . 'AppData' . g:SLASH . 'Local' . g:SLASH . 'nvim'
  else
    let $VIMHOME = $HOME . g:SLASH . 'vimfiles'
  endif
endif

if has("unix")
  set ff=unix

  let g:SLASH="/"

  " WSL yank support
  let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
  if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
  endif

  if has("nvim")
    let $VIMHOME = $HOME . g:SLASH . '.config' . g:SLASH . 'nvim'
  else
    let $VIMHOME = $HOME . g:SLASH . '.vim'
  endif
endif

let g:PLUGGEDDIR = $VIMHOME . g:SLASH . 'plugged'
let g:VIMUNDODIR = $VIMHOME . g:SLASH . 'vimundo'

if !isdirectory($VIMHOME)
    call mkdir($VIMHOME, "p")
endif

if !isdirectory(g:VIMUNDODIR)
    call mkdir(g:VIMUNDODIR, "p")
endif

" load local stuff
let g:PLUGINDIR = $VIMHOME . g:SLASH . 'source'

silent execute 'source' g:PLUGINDIR . g:SLASH . 'augroups.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'sessions.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'functions.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'settings.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'mappings.vim'

call plug#begin(g:PLUGGEDDIR)
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'aperezdc/vim-template'
Plug 'godlygeek/tabular'
Plug 'OmniSharp/omnisharp-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
if has("nvim")
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'petertriho/nvim-scrollbar'
  Plug 'gpanders/editorconfig.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'catppuccin/nvim', {'as': 'catppuccin'}
  Plug 'nvim-lualine/lualine.nvim'
else
  Plug 'itchyny/lightline.vim'
  Plug 'sheerun/vim-polyglot'
endif
call plug#end()

silent execute 'source' g:PLUGINDIR . g:SLASH . 'plugins_shared.vim'
if has("nvim")
  silent execute 'source' g:PLUGINDIR . g:SLASH . 'plugins_nvim.vim'
else
  silent execute 'source' g:PLUGINDIR . g:SLASH . 'plugins.vim'
endif
