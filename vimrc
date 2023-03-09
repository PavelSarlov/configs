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
    let g:VIMHOME = $HOME . g:SLASH . 'vimfiles'
  else
    let g:VIMHOME = $HOME . g:SLASH . 'AppData' . g:SLASH . 'Local' . g:SLASH . 'nvim'
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
    let g:VIMHOME = $HOME . g:SLASH . '.config' . g:SLASH . 'nvim'
  else
    let g:VIMHOME = $HOME . g:SLASH . '.vim'
  endif
endif

let g:PLUGGEDDIR = g:VIMHOME . g:SLASH . 'plugged'
let g:VIMUNDODIR = g:VIMHOME . g:SLASH . 'vimundo'

if !isdirectory(g:VIMHOME)
    call mkdir(g:VIMHOME, "p")
endif

if !isdirectory(g:VIMUNDODIR)
    call mkdir(g:VIMUNDODIR, "p")
endif


" load local stuff
let g:PLUGINDIR = g:VIMHOME . g:SLASH . 'source'

silent execute 'source' g:PLUGINDIR . g:SLASH . 'settings.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'mappings.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'augroups.vim'
silent execute 'source' g:PLUGINDIR . g:SLASH . 'sessions.vim'

if has("nvim")
  silent execute 'source' g:PLUGINDIR . g:SLASH . 'plugins_nvim.vim'
else
  silent execute 'source' g:PLUGINDIR . g:SLASH . 'plugins.vim'
endif
