let latin_alphabet = map(extend(range(char2nr('a'),char2nr('z')), range(char2nr('A'),char2nr('Z'))), { i, v -> nr2char(v) })
let cyrillic_alphabet = split('абцдефгхийклмнопярстужвьъзАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЪЗ', '\zs')

for i in range(0, len(latin_alphabet) - 1)
  let latin = get(latin_alphabet, i)
  let cyrillic = get(cyrillic_alphabet, i)
  silent exec "map " . cyrillic . " " . latin
  silent exec "map <Esc>" . cyrillic . " <A-" . latin . ">"
endfor

if !has('nvim')
  let chars = latin_alphabet
  call extend(chars, split(',.<>:;+-=_', '\zs'))
  call extend(chars, cyrillic_alphabet)
  for char in chars
    silent exec "map <Esc>" . char . " <A-" . char . ">"
  endfor
endif


nnoremap <silent> / /\v

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
nnoremap <silent> k gk
nnoremap <silent> j gj
xnoremap <silent> k gk
xnoremap <silent> j gj

" movement
nnoremap <silent> J 6gj
nnoremap <silent> K 6gk
nnoremap <silent> L 6l
nnoremap <silent> H 6h

xnoremap <silent> J 6gj
xnoremap <silent> K 6gk
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
tnoremap <silent><expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<C-\><C-N>"
nnoremap <silent> <C-s> :w!<CR>
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
nnoremap <silent> <A-i> :call windows#WindowPaste('rightbelow', 1)<CR>
nnoremap <silent> <A-I> :call windows#WindowPaste('leftabove', 1)<CR>
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

