let g:SESSIONPATH = $VIMHOME . g:SLASH . 'sessions' 

if !isdirectory(g:SESSIONPATH)
    call mkdir(g:SESSIONPATH, "p")
endif

function! sessions#MakeSession()
  let s:SESSIONPATH = g:SESSIONPATH . g:SLASH . sha256(getcwd()) . '.vim'
  if (filewritable(g:SESSIONPATH) != 2)
    call system('mkdir -p ' . g:SESSIONPATH)
    redraw!
  endif
  exe "mksession! " . s:SESSIONPATH
endfunction

function! sessions#LoadSession()
  let s:SESSIONPATH = g:SESSIONPATH . g:SLASH . sha256(getcwd()) . '.vim'
  if (filereadable(s:SESSIONPATH))
    exe 'source ' s:SESSIONPATH
  else
    echo "No session loaded."
  endif
endfunction
