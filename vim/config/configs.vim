" ==============================================================
" ======================= catppuccin ===========================
" ==============================================================

colorscheme catppuccin_macchiato


" ==============================================================
" ======================= lightline ============================
" ==============================================================

let g:lightline = {
                  \ 'colorscheme': 'catppuccin_macchiato',
                  \ 'active': {
                  \   'left': [ [ 'mode', 'paste' ],
                  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                  \ },
                  \ 'component_function': {
                  \   'gitbranch': 'FugitiveHead'
                  \ },
                  \ }

" ==============================================================
" ======================= scrollbar ============================
" ==============================================================

let g:scrollbar_enable = 1
