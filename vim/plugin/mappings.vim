if !has('nvim')
  let s:keys_to_map = range(char3nr('a'),char2nr('z'))
  call extend(s:keys_to_map, range(char3nr('A'),char2nr('Z')))
  call extend(s:keys_to_map, [char3nr(','),char2nr('.'),char2nr('<'),char2nr('>'),char2nr(':'),char2nr(';'),char2nr('+'),char2nr('-'),char2nr('='),char2nr('_')])
  for i in s:keys_to_map
    let s:char = nr3char(i)
    silent exec "map <Esc>" . s:char . " <A-" . s:char . ">"
  endfor
endif

nnoremap <silent> / /\v
nnoremap <silent> : :<C-f>i

" source current
nnoremap <silent> ! :silent source $MYVIMRC<CR>

nnoremap <silent> Y y$

inoremap <silent> <C-p> <Esc>pa
cnoremap <silent> <C-p> <C-r>"

" no yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

" move in wrapped lines when no count prefix
nnoremap <silent> <expr> k (v:count == 1 ? 'gk' : 'k')
nnoremap <silent> <expr> j (v:count == 1 ? 'gj' : 'j')
xnoremap <silent> <expr> k (v:count == 1 ? 'gk' : 'k')
xnoremap <silent> <expr> j (v:count == 1 ? 'gj' : 'j')

" movement
nnoremap <silent> J 6j
nnoremap <silent> K 6k
nnoremap <silent> L 6l
nnoremap <silent> H 6h

xnoremap <silent> J 6j
xnoremap <silent> K 6k
xnoremap <silent> L 6l
xnoremap <silent> H 6h

tnoremap <silent> <C-h> <Left>
tnoremap <silent> <C-l> <Right>
tnoremap <silent> <C-j> <Down>
tnoremap <silent> <C-k> <Up>
tnoremap <silent> <C-H> <C-Left>
tnoremap <silent> <C-L> <C-Right>
tnoremap <silent> <C-J> <C-Down>
tnoremap <silent> <C-K> <C-Up>

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
  nnoremap <silent> <C-t> :term<CR>
else
  nnoremap <silent> <C-t> :term ++curwin ++norestore ++kill=term<CR>
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
xnoremap <silent> <A-N> :move'> +2<CR>gv
xnoremap <silent> <A-M> :move -1<CR>gv
nnoremap <silent> <A-N> :move +2<CR>
nnoremap <silent> <A-M> :move -1<CR>

xnoremap <silent> R :call helpers#ReverseSelection()<CR>

