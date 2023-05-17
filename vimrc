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

" load configs
let g:CONFIGDIR = $VIMHOME . g:SLASH . 'config'

call plug#begin(g:PLUGGEDDIR)

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'wellle/context.vim'

Plug 'rust-lang/rust.vim'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/linediff.vim'

Plug 'lambdalisue/nerdfont.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'aperezdc/vim-template'

Plug 'godlygeek/tabular'

Plug 'OmniSharp/omnisharp-vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

if has("nvim")
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'petertriho/nvim-scrollbar'
  Plug 'gpanders/editorconfig.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'

  Plug 'nvim-lualine/lualine.nvim'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'nvim-tree/nvim-web-devicons'
else
  Plug 'PavelSarlov/scrollbar.vim'
  Plug 'sheerun/vim-polyglot'

  Plug 'itchyny/lightline.vim'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'ryanoasis/vim-devicons'
endif

call plug#end()

function! s:SourcePlugins(dir)
  for path in split(glob(a:dir), "\n")
    silent exe 'source ' . path
  endfor
endfunction

if has("nvim")
  call s:SourcePlugins(g:CONFIGDIR . g:SLASH . '*.lua')
else
  call s:SourcePlugins(g:CONFIGDIR . g:SLASH . '*.vim')
endif
