function! helpers#ReverseSelection()
  let reg_a = getreg('a')
  call setreg('a', join(reverse(split(helpers#GetVisualSelection(), '.\zs')), ''))
  normal! gv"_d"aP
  call setreg('a', reg_a)
endfunction

function! helpers#GetVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")endfunction
endfunction

function! helpers#FindGitRoot()
  let pwd = getcwd()
  let dir = empty(&ft) || &ft ==# 'terminal' ? '.' : &ft ==# "netrw" ? expand('%') : expand('%:p:h')
  exe 'cd' dir
  let output = system('git rev-parse --show-toplevel')[:-2]
  exe 'cd' pwd 
  return v:shell_error || empty(output) ? dir : output
endfunction

function! helpers#GacceptBoth()
  let lastTheirs = search('>\{7\}','bWn')
  let ours = search('<\{7\}', 'b', lastTheirs ? lastTheirs : 1)

  if (!ours)
    return
  endif

  let theirs = search('>\{7\}', 'W')

  execute ours . ',' theirs . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction

function! helpers#RemoveCarriageReturn()
  let pos = getpos(".")
  silent! %s/\r// 
  call setpos(".", pos)
endfunction

function! helpers#CreateDirRecursive(dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  end
endfunction
