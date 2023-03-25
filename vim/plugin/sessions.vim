set sessionoptions=curdir,help,tabpages

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
    au VimEnter * nested :call sessions#LoadSession()
endif
au VimLeave * :call sessions#MakeSessions()
