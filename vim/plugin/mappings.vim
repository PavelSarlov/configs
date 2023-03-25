if !has('nvim')
  let s:keys_to_map = range(char2nr('a'),char2nr('z'))
  call extend(s:keys_to_map, range(char2nr('A'),char2nr('Z')))
  call extend(s:keys_to_map, [char2nr(','),char2nr('.'),char2nr('<'),char2nr('>'),char2nr(':'),char2nr(';'),char2nr('+'),char2nr('-'),char2nr('='),char2nr('_')])
  for i in s:keys_to_map
    let s:char = nr2char(i)
    silent exec "map <Esc>" . s:char . " <A-" . s:char . ">"
  endfor
endif

nnoremap / /\v

" source current
nnoremap <silent> ! :silent source $MYVIMRC<CR>

nnoremap <silent> Y y$

inoremap <silent> <C-p> <Esc>pa
cnoremap <silent> <C-p> <C-r>"

nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk

" no yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

nnoremap <silent> J 5j
nnoremap <silent> K 5k
nnoremap <silent> L 5l
nnoremap <silent> H 5h
xnoremap <silent> J 5j
xnoremap <silent> K 5k
xnoremap <silent> L 5l
xnoremap <silent> H 5h

" misc
cmap w!! w !sudo tee % >/dev/null
tnoremap <silent> <Esc> <C-\><C-n>
nnoremap <silent> <C-s> :w!<CR>
nnoremap <silent> <C-f> /
nnoremap <silent> <A-a> <C-a>
nnoremap <silent> <A-x> <C-x>
nnoremap <silent> <A-A> :nohl \| redraw!<CR>
nnoremap <silent> <C-a> ggVG

if has("nvim")
  nnoremap <silent> <C-t> :term<CR>i
else
  nnoremap <silent> <C-t> :term ++curwin ++norestore ++kill=term<CR>i
endif

" tabs
nnoremap <silent> <C-k> :tabnext<CR>
nnoremap <silent> <C-j> :tabprevious<CR>
nnoremap <silent> <A-t> :tabedit %<CR>
nnoremap <silent> <A-w> :conf tabclose<CR>
nnoremap <silent> <A->> :call tabs#TabMoveRight()<CR>
nnoremap <silent> <A-<> :call tabs#TabMoveLeft()<CR>

" splits management
tnoremap <silent> <C-q> <C-\><C-n>:conf q<CR> 
tnoremap <silent> <A-q> <C-\><C-n>:conf qa<CR>

inoremap <silent> <C-q> <Esc>:conf q<CR> 
inoremap <silent> <A-q> <Esc>:conf qa<CR>

nnoremap <silent> <A-s> <C-w>s
nnoremap <silent> <A-v> <C-w>v
nnoremap <silent> <A-h> <C-w>h
nnoremap <silent> <A-j> <C-w>j
nnoremap <silent> <A-k> <C-w>k
nnoremap <silent> <A-l> <C-w>l
nnoremap <silent> <A-d> :call windows#WindowDelete()<CR>
nnoremap <silent> <A-y> :call windows#WindowYank()<CR>
nnoremap <silent> <A-p> :call windows#WindowPaste('rightbelow')<CR>
nnoremap <silent> <A-P> :call windows#WindowPaste('leftabove')<CR>
nnoremap <silent> <A-H> :call windows#WindowMoveLeft()<CR> 
nnoremap <silent> <A-J> :call windows#WindowMoveDown()<CR>  
nnoremap <silent> <A-K> :call windows#WindowMoveUp()<CR>  
nnoremap <silent> <A-L> :call windows#WindowMoveRight()<CR>   
nnoremap <silent> <A-=> <C-w>+
nnoremap <silent> <A--> <C-w>-
nnoremap <silent> <A-r> <C-w>r
nnoremap <silent> <A-,> <C-w><
nnoremap <silent> <A-.> <C-w>>
nnoremap <silent> <C-q> :conf q<CR>
nnoremap <silent> <A-q> :conf qa<CR>

" line moving
xnoremap <silent> <A-N> :move'> +1<CR>gv
xnoremap <silent> <A-M> :move -2<CR>gv
nnoremap <silent> <A-N> :move +1<CR>
nnoremap <silent> <A-M> :move -2<CR>

xnoremap <silent> R :call helpers#ReverseSelection()<CR>

