function! tabs#TabMoveLeft()
  if tabpagenr() == 1
    execute 'tabm $'
  else
    execute 'tabm -1'
  endif
endfunction

function! tabs#TabMoveRight()
  if tabpagenr() == tabpagenr('$')
    execute 'tabm 0'
  else
    execute 'tabm +1'
  endif
endfunction
