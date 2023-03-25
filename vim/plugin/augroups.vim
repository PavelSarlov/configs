augroup file_types
  au!
  au BufRead,BufNewFile *.ejs  set filetype=html
  au BufRead,BufNewFile *.json set filetype=jsonc
augroup END

augroup file_change
  au!
  au FileChangedRO    * echohl WarningMsg | echo "File changed RO." | echohl None
  au FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None
augroup END
