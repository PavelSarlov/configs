if has("win64") || has("win32")
  set ff=dos

  let g:DEFAULTSLASH="\\"

  set shell=powershell

  if executable('pwsh')
    set shell=pwsh
  endif

  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=

  let g:VIMHOME = $HOME . g:DEFAULTSLASH . 'vimfiles'
endif


if has("unix")
  set ff=unix

  let g:DEFAULTSLASH="/"

  " WSL yank support
  let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
  if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
  endif

  let g:VIMHOME = $HOME . g:DEFAULTSLASH . '.vim'
endif

let g:PLUGGEDDIR = g:VIMHOME . g:DEFAULTSLASH . 'plugged'
let g:VIMUNDODIR = g:VIMHOME . g:DEFAULTSLASH . 'vimundo'

if !isdirectory(g:VIMHOME)
    call mkdir(g:VIMHOME, "p")
endif

if !isdirectory(g:VIMUNDODIR)
    call mkdir(g:VIMUNDODIR, "p")
endif

" vim-plug
call plug#begin(g:PLUGGEDDIR)
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'aperezdc/vim-template'
Plug 'godlygeek/tabular'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
call plug#end()

augroup filetypes
  au!
  au BufRead,BufNewFile *.ejs set filetype=html
  au BufRead,BufNewFile *.json set filetype=jsonc
augroup END

set sessionoptions=curdir,help,tabpages

let g:SESSIONDIR = g:VIMHOME . g:DEFAULTSLASH . 'sessions' 

function! MakeSession()
  let s:SESSIONPATH = g:SESSIONDIR . g:DEFAULTSLASH . sha256(getcwd()) . '.vim'
  if (filewritable(g:SESSIONDIR) != 2)
    call system('mkdir -p ' . g:SESSIONDIR)
    redraw!
  endif
  exe "mksession! " . s:SESSIONPATH
endfunction

function! LoadSession()
  let s:SESSIONPATH = g:SESSIONDIR . g:DEFAULTSLASH . sha256(getcwd()) . '.vim'
  if (filereadable(s:SESSIONPATH))
    exe 'source ' s:SESSIONPATH
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
    au VimEnter * nested :call LoadSession()
endif
au VimLeave * :call MakeSession()


" highlight and indent
set nocompatible
filetype plugin indent on
syntax on

set termguicolors
set background=dark

augroup file_change
  au!
  au FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
  au FileChangedShell * echohl WarningMsg | echo "File "%" changed" | echohl None
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
set tabstop=2 
set softtabstop=2 
set shiftwidth=2 
set backspace=2
set expandtab
set smarttab
set autoread
autocmd BufReadPost * set autoindent
autocmd BufReadPost * set smartindent
autocmd BufReadPost * set cindent    
set virtualedit=all
set t_vb=
set novisualbell
set belloff=all
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
set guifont=FontAwesome
set relativenumber
set undofile
let &undodir=g:VIMUNDODIR

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

" no yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP


"==============================================================
"======================= ctrlp ================================
"==============================================================

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|dist\|obj\|bin'
let g:ctrlp_show_hidden = 1

"==============================================================
"======================= fugitive =============================
"==============================================================

function! GacceptBoth()
  let lastTheirs = search('>\{7\}','bWn')
  let ours = search('<\{7\}', 'b', lastTheirs ? lastTheirs : 1)

  if (!ours)
    return
  endif

  let theirs = search('>\{7\}', 'W')

  execute ours . ',' theirs . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction

nnoremap <silent>cm :tabedit % \| Gvdiffsplit!<CR>
nnoremap <silent>co :diffget //2<CR>
nnoremap <silent>ct :diffget //3<CR>
nnoremap <silent>cb :call GacceptBoth()<CR>
nnoremap <silent>cs :only<CR>
nnoremap <silent>cu :diffupdate<CR>

"===========================================================
"======================= templates =========================
"===========================================================

let g:templates_directory=[g:VIMHOME . "templates"]

"===========================================================
"======================= coc configs =======================
"===========================================================

let g:coc_data_home = g:VIMHOME . g:DEFAULTSLASH . "coc"
let g:coc_config_home = g:VIMHOME

let g:coc_global_extensions = [
  \ 'coc-db',
  \ 'coc-omnisharp',
  \ 'coc-powershell',
  \ 'coc-cmake',
  \ 'coc-emmet',
  \ 'coc-highlight',
  \ 'coc-sh',
  \ 'coc-vimlsp',
  \ 'coc-syntax',
  \ 'coc-diagnostic',
  \ 'coc-explorer',
  \ 'coc-gitignore',
  \ 'coc-css', 
  \ 'coc-html', 
  \ 'coc-json', 
  \ 'coc-lists',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-snippets',
  \ 'coc-sourcekit',
  \ 'coc-stylelint',
  \ 'coc-xml', 
  \ 'coc-rls', 
  \ 'coc-java', 
  \ 'coc-java-lombok', 
  \ 'coc-phpls',
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ 'coc-lua',
  \ 'coc-webview',
  \ 'coc-markdown-preview-enhanced',
  \ 'coc-yank']

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for apply code actions at the cursor position.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for apply refactor code actions.
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
nnoremap <silent> <S-f> :Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
nnoremap <silent> <A-o> :OR<CR>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
