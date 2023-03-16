function! SwapWindowBuffers(win1, buf1, win2, buf2)
  exec  a:win1 . " wincmd w" ."|".
      \ "buffer ". a:buf2 ."|".
      \ a:win2 ." wincmd w" ."|".
      \ "buffer ". a:buf1
endfunction

function! GetWindowAndAdjacent(direction)
  let win1 = winnr()
  let buf1 = bufnr()
  let win2 = winnr(a:direction)
  let buf2 = winbufnr(win2)
  return [win1, buf1, win2, buf2]
endfunction

function! WindowDelete()
  call WindowYank()
  quit
endfunction

function! WindowYank()
  call setreg(v:register, expand('%'))
endfunction

function! WindowPaste(location = 'rightbelow', is_vertical = 0)
  let split_cmd = a:is_vertical ? 'vsplit' : 'split'
  execute a:location . ' ' . split_cmd . ' ' . getreg(v:register)
endfunction

function! WindowMoveDown()
  let [win1, buf1, win2, buf2] = GetWindowAndAdjacent('j')
  call SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction

function! WindowMoveUp()
  let [win1, buf1, win2, buf2] = GetWindowAndAdjacent('k')
  call SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction

function! WindowMoveLeft()
  let [win1, buf1, win2, buf2] = GetWindowAndAdjacent('h')
  call SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction

function! WindowMoveRight()
  let [win1, buf1, win2, buf2] = GetWindowAndAdjacent('l')
  call SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction
