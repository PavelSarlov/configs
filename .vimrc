call plug#begin("~/.local/share/nvim/site/plugged")
Plug 'tyru/open-browser.vim' " opens url in browser
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'morhetz/gruvbox'
Plug 'Chiel92/vim-autoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" highlight and indent
set nocompatible
filetype plugin indent on
syntax on

set background=dark
augroup colorscheme_setup
    au!
    au VimEnter * ++nested colorscheme gruvbox
    au VimEnter * highlight Normal ctermfg=lightgray ctermbg=None guibg=None
augroup END

augroup file_change
    au!
    au FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
    au FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None
augroup END

augroup layout
    au!
    au VimEnter,TabNew * NERDTree | wincmd l
    if has("nvim")
        au VimEnter,TabNew * split
    endif
    au VimEnter,TabNew * terminal
    au VimEnter,TabNew * resize 15 | wincmd k
augroup END

" autocomplete features
set omnifunc=syntaxcomplete#complete

set encoding=utf-8 fileencoding=utf-8
set nobackup nowritebackup noswapfile noundofile
set ignorecase smartcase incsearch hlsearch
set title ruler
set wildmenu
set showmode
set splitbelow
set wrap
set number
set clipboard+=unnamed,unnamedplus
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set backspace=2
set expandtab
set smarttab
set autoread
autocmd BufReadPost * set autoindent
autocmd BufReadPost * set smartindent
autocmd BufReadPost * set cindent    
set virtualedit=all
set visualbell
set t_vb=
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes

if has("win64") || has("win32")
    set ff=dos

    let g:DEFAULTSHELL="powershell"

    if executable("pwsh")
        let g:DEFAULTSHELL="pwsh"
    endif

    execute "set shell=" . g:DEFAULTSHELL
endif

if has("unix")
    set ff=unix

    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

cmap w!! w !sudo tee % >/dev/null
nnoremap <silent> <C-s> :w!<CR>
nnoremap <silent> <C-q> :q!<CR>
nnoremap <silent> <A-q> :qa!<CR>
tnoremap <silent> <C-q> <C-\><C-n>:q!<CR>
tnoremap <silent> <A-q> <C-\><C-n>:qa!<CR>
inoremap <silent> <C-q> <C-\><C-n>:q!<CR>
inoremap <silent> <A-q> <C-\><C-n>:qa!<CR>
nnoremap <silent> <A-w> :tabclose!<CR>
nnoremap <silent> <S-f> :Autoformat<CR>
nnoremap <silent> <C-f> /
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <Tab> :nohl \| redraw!<CR>
nnoremap <silent> <C-a> ggVG
nnoremap <silent> <C-k> :tabnext<CR>
nnoremap <silent> <C-j> :tabprevious<CR>

" self-closing brackets / quote
inoremap <silent> " ""<Left>
inoremap <silent> ' ''<Left>
inoremap <silent> ( ()<Left>
inoremap <silent> [ []<Left>
inoremap <silent> { {}<Left>
inoremap <silent> {<CR> {<CR>}<Esc>O
inoremap <silent> {;<CR> {<CR>};<Esc>O

" splits management
tnoremap <silent> <Esc> <C-\><C-n>
tnoremap <silent> <A-h> <C-\><C-n><C-w>h
tnoremap <silent> <A-j> <C-\><C-n><C-w>j
tnoremap <silent> <A-k> <C-\><C-n><C-w>k
tnoremap <silent> <A-l> <C-\><C-n><C-w>l
inoremap <silent> <A-h> <C-\><C-n><C-w>h
inoremap <silent> <A-j> <C-\><C-n><C-w>j
inoremap <silent> <A-k> <C-\><C-n><C-w>k
inoremap <silent> <A-l> <C-\><C-n><C-w>l
nnoremap <silent> <A-h> <C-w>h
nnoremap <silent> <A-j> <C-w>j
nnoremap <silent> <A-k> <C-w>k
nnoremap <silent> <A-l> <C-w>l
nnoremap <silent> <A-=> <C-w>+
nnoremap <silent> <A--> <C-w>-
nnoremap <silent> <A-r> <C-w>r
nnoremap <silent> <A-,> <C-w><
nnoremap <silent> <A-.> <C-w>>

if executable("racer.exe")
    let g:racer_cmd="${WINHOME}/.cargo/bin/racer.exe"
endif

if executable("rustc.exe")
    let g:rustc_path="${WINHOME}/.cargo/bin/rustc"
endif

if exists(":NERDTree")
    let g:NERDTreeShowHidden=1
    let g:NERDTreeChDirMode=2
endif

"===========================================================
"======================= coc configs =======================
"===========================================================

let g:coc_global_extension = ['coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-rls', 'coc-java', 'coc-phpls', 'coc-clangd']

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"===================================================================
"======================= tree-sitter configs =======================
"===================================================================

lua <<EOF
require'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "maintained",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        disable = { },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
        },
    }
EOF
