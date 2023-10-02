vim.cmd [[
  augroup file_types
    au!
    au BufRead,BufNewFile *.ejs  set filetype=html
    au BufRead,BufNewFile *.json set filetype=jsonc
    au SessionLoadPost * :windo filetype detect
    au BufEnter * :filetype detect
  augroup END

  augroup file_change
    au!
    au FileChangedRO    * echohl WarningMsg | echo "File changed RO." | echohl None
    au FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None
  augroup END

  augroup file_save
    au!
    au BufWritePre * call helpers#RemoveCarriageReturn()
  augroup END

  augroup terminal_enter
    au!
    if has("nvim")
      au TermOpen * set ft=terminal
    else
      au TerminalOpen * set ft=terminal
    endif
  augroup END
]]
