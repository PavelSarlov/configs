call plug#begin("~/.local/share/nvim/site/plugged")
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'rust-lang/rust.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/nerdfont.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'aperezdc/vim-template'
Plug 'petertriho/nvim-scrollbar'
Plug 'godlygeek/tabular'
Plug 'gpanders/editorconfig.nvim'
call plug#end()

" highlight and indent
set nocompatible
filetype plugin indent on
syntax on

set termguicolors
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
    au VimEnter,TabNew * CocCommand explorer --width 40
    au VimEnter,TabNew * wincmd l
    if has("nvim")
        au VimEnter,TabNew * split
    endif
    au VimEnter,TabNew * terminal
    au VimEnter,TabNew * resize 15
    au VimEnter,TabNew * wincmd k
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
set guifont=FontAwesome

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

nnoremap <silent> <A-a> <C-a>
nnoremap <silent> <A-x> <C-x>

cmap w!! w !sudo tee % >/dev/null
nnoremap <silent> <C-s> :w!<CR>
nnoremap <silent> <C-q> :q!<CR>
nnoremap <silent> <A-q> :qa!<CR>
tnoremap <silent> <C-q> <C-\><C-n>:q!<CR>
tnoremap <silent> <A-q> <C-\><C-n>:qa!<CR>
inoremap <silent> <C-q> <C-\><C-n>:q!<CR>
inoremap <silent> <A-q> <C-\><C-n>:qa!<CR>
nnoremap <silent> <A-w> :tabclose!<CR>
nnoremap <silent> <C-f> /
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <Tab> :nohl \| redraw!<CR>
nnoremap <silent> <C-a> ggVG
nnoremap <silent> <C-k> :tabnext<CR>
nnoremap <silent> <C-j> :tabprevious<CR>

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

" no yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

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

let g:coc_global_extension = [
    \'coc-tsserver', 
    \'coc-css', 
    \'coc-html', 
    \'coc-json', 
    \'coc-xml', 
    \'coc-rls', 
    \'coc-java', 
    \'coc-java-lombok', 
    \'coc-phpls',
    \'coc-clangd',
    \'coc-explorer']

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" inoremap <silent><expr> <TAB>
"     \ coc#pum#visible() ? coc#_select_confirm() :
"     \ coc#expandableOrJumpable() ?
"     \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ coc#refresh()

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
command! -nargs=0 Format    :call     CocActionAsync('format')
nnoremap <silent><nowait> <S-f> :Format<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold      :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR        :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
nnoremap <silent><nowait> <A-i> :OR<CR>

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

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

augroup jsonc
    au!
    au BufRead,BufNewFile *.json set filetype=jsonc
augroup END

"===========================================================
"======================= treesitter ========================
"===========================================================

lua << EOF
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
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

"===========================================================
"======================= colorizer =========================
"===========================================================

lua << EOF
require('colorizer').setup()
EOF

"===========================================================
"======================= templates =========================
"===========================================================

let g:templates_directory=[
            \"~/.config/nvim/templates"]

"===========================================================
"======================= scrollbar ========================= ===========================================================

lua << EOF
require("scrollbar").setup({
    show = true,
    show_in_active_only = false,
    set_highlights = true,
    folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = false, -- disables if no. of lines in buffer exceeds this
    handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
        Search = {
            text = { "-", "=" },
            priority = 0,
            color = nil,
            cterm = nil,
            highlight = "Search",
        },
        Error = {
            text = { "-", "=" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
            text = { "-", "=" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
            text = { "-", "=" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
            text = { "-", "=" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
            text = { "-", "=" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "Normal",
        },
    },
    excluded_buftypes = {
        "terminal",
    },
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
        clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
        },
    },
    handlers = {
        diagnostic = true,
        search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
    },
})
EOF
