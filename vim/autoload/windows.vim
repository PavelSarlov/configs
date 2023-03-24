function! s:SwapWindowBuffers(win1, buf1, win2, buf2)
  exec  a:win1 . " wincmd w" ."|".
      \ "buffer ". a:buf2 ."|".
      \ a:win2 ." wincmd w" ."|".
      \ "buffer ". a:buf1
endfunction

function! s:GetWindowAndAdjacent(direction)
  let win1 = winnr()
  let buf1 = bufnr()
  let win2 = winnr(a:direction)
  let buf2 = winbufnr(win2)
  return [win1, buf1, win2, buf2]
endfunction

function! windows#WindowDelete()
  call windows#WindowYank()
  quit
endfunction

function! windows#WindowYank()
  call setreg(v:register, expand('%'))
endfunction

function! windows#WindowPaste(location = 'rightbelow', is_vertical = 0)
  let split_cmd = a:is_vertical ? 'vsplit' : 'split'
  execute a:location . ' ' . split_cmd . ' ' . getreg(v:register)
endfunction

function! windows#WindowMoveDown()
  let [win1, buf1, win2, buf2] = s:GetWindowAndAdjacent('j')
  call s:SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction

function! windows#WindowMoveUp()
  let [win1, buf1, win2, buf2] = s:GetWindowAndAdjacent('k')
  call s:SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction

function! windows#WindowMoveLeft()
  let [win1, buf1, win2, buf2] = s:GetWindowAndAdjacent('h')
  call s:SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction

function! windows#WindowMoveRight()
  let [win1, buf1, win2, buf2] = s:GetWindowAndAdjacent('l')
  call s:SwapWindowBuffers(win1, buf1, win2, buf2)
endfunction
