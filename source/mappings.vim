" source current
nnoremap <silent> ! :source %<CR>

nnoremap <silent> Y y$

inoremap <silent> <C-p> <Esc>pa
cnoremap <silent> <C-p> <C-r>"

nnoremap <silent> j gj
nnoremap <silent> k gk

" no yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

nnoremap <silent> J 5j
nnoremap <silent> K 5k
nnoremap <silent> L 5l
nnoremap <silent> H 5h

" misc
cmap w!! w !sudo tee % >/dev/null
tnoremap <silent> <Esc> <C-\><C-n>
nnoremap <silent> <C-s> :w!<CR>
nnoremap <silent> <C-f> /
nnoremap <silent> <A-a> <C-a>
nnoremap <silent> <A-x> <C-x>
nnoremap <silent> <S-Tab> :nohl \| redraw!<CR>
nnoremap <silent> <C-a> ggVG
nnoremap <silent> <C-t> :term ++curwin ++norestore ++kill=term<CR>

" tabs
nnoremap <silent> <C-k> :tabnext<CR>
nnoremap <silent> <C-j> :tabprevious<CR>
tnoremap <silent> <A-t> <C-\><C-n>:tabedit %<CR>
inoremap <silent> <A-t> <Esc>:tabedit %<CR>
nnoremap <silent> <A-t> :tabedit %<CR>
tnoremap <silent> <A-w> <C-\><C-n>:conf tabclose<CR>
inoremap <silent> <A-w> <Esc>:conf tabclose<CR>
nnoremap <silent> <A-w> :conf tabclose<CR>

" splits management
tnoremap <silent> <A-s> <C-\><C-n><C-w>s
tnoremap <silent> <A-v> <C-\><C-n><C-w>v
tnoremap <silent> <A-h> <C-\><C-n><C-w>h
tnoremap <silent> <A-j> <C-\><C-n><C-w>j
tnoremap <silent> <A-k> <C-\><C-n><C-w>k
tnoremap <silent> <A-l> <C-\><C-n><C-w>l
tnoremap <silent> <A-=> <C-\><C-n><C-w>+
tnoremap <silent> <A--> <C-\><C-n><C-w>-
tnoremap <silent> <A-r> <C-\><C-n><C-w>r
tnoremap <silent> <A-,> <C-\><C-n><C-w><
tnoremap <silent> <A-.> <C-\><C-n><C-w>>
tnoremap <silent> <C-q> <C-\><C-n>:conf q<CR> 
tnoremap <silent> <A-q> <C-\><C-n>:conf qa<CR>

inoremap <silent> <A-s> <Esc><C-w>s
inoremap <silent> <A-v> <Esc><C-w>v
inoremap <silent> <A-h> <Esc><C-w>h
inoremap <silent> <A-j> <Esc><C-w>j
inoremap <silent> <A-k> <Esc><C-w>k
inoremap <silent> <A-l> <Esc><C-w>l
inoremap <silent> <A-=> <Esc><C-w>+
inoremap <silent> <A--> <Esc><C-w>-
inoremap <silent> <A-r> <Esc><C-w>r
inoremap <silent> <A-,> <Esc><C-w><
inoremap <silent> <A-.> <Esc><C-w>>
inoremap <silent> <C-q> <Esc>:conf q<CR> 
inoremap <silent> <A-q> <Esc>:conf qa<CR>

nnoremap <silent> <A-s> <C-w>s
nnoremap <silent> <A-v> <C-w>v
nnoremap <silent> <A-h> <C-w>h
nnoremap <silent> <A-j> <C-w>j
nnoremap <silent> <A-k> <C-w>k
nnoremap <silent> <A-l> <C-w>l
nnoremap <silent> <A-=> <C-w>+
nnoremap <silent> <A--> <C-w>-
nnoremap <silent> <A-r> <C-w>r
nnoremap <silent> <A-,> <C-w><
nnoremap <silent> <A-.> <C-w>>
nnoremap <silent> <C-q> :conf q<CR>
nnoremap <silent> <A-q> :conf qa<CR>
