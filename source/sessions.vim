set sessionoptions=curdir,help,tabpages

let g:SESSIONDIR = $VIMHOME . g:SLASH . 'sessions' 

function! MakeSession()
  let s:SESSIONPATH = g:SESSIONDIR . g:SLASH . sha256(getcwd()) . '.vim'
  if (filewritable(g:SESSIONDIR) != 2)
    call system('mkdir -p ' . g:SESSIONDIR)
    redraw!
  endif
  exe "mksession! " . s:SESSIONPATH
endfunction

function! LoadSession()
  let s:SESSIONPATH = g:SESSIONDIR . g:SLASH . sha256(getcwd()) . '.vim'
  if (filereadable(s:SESSIONPATH))
    exe 'source ' s:SESSIONPATH
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
    au VimEnter * nested :call LoadSession()
endif
au VimLeave * :call MakeSession()
