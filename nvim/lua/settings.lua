vim.cmd [[

" highlight and indent
set nocompatible
filetype plugin indent on
syntax on

set termguicolors
set background=dark

autocmd BufReadPost * set autoindent
autocmd BufReadPost * set smartindent
autocmd BufReadPost * set cindent

" autocomplete features
setglobal omnifunc=syntaxcomplete#complete
set completeopt=menu,menuone,noselect,noinsert

set history=1000
set encoding=utf-8 fileencoding=utf-8
set nobackup nowritebackup noswapfile noundofile
set ignorecase smartcase
set incsearch hlsearch
setglobal nrformats-=octal
set title
set ruler
set showmode
set showcmd
set splitbelow splitright
setglobal wrap linebreak number cursorline
set clipboard+=unnamed,unnamedplus
let g:clipboard = {
        \	 'name': 'wsl-yank',
        \	 'copy': {
        \	 	'+': 'win32yank.exe -i --crlf',
        \	 	'*': 'win32yank.exe -i --crlf',
        \	 },
        \	 'paste': {
        \	 	'+': 'win32yank.exe -o --lf',
        \	 	'*': 'win32yank.exe -o --lf',
        \	 },
        \	 'cache_enabled': 0,
        \}

set laststatus=2
setglobal tabstop=2 softtabstop=2 shiftwidth=2
set backspace=indent,eol,start

setglobal expandtab
set smarttab
setglobal autoread
setglobal virtualedit=all
set t_vb=
set t_u7=
set novisualbell
set belloff=all
set hidden
set updatetime=300
set shortmess=acF
setglobal signcolumn=yes
setglobal relativenumber

setglobal undofile
let &undodir=g:VIMUNDODIR

set timeout
set timeoutlen=200
set ttimeout
set ttimeoutlen=50
set display=truncate

set guioptions=
set guifont=FontAwesome

set mouse=a

set wildmenu
set wildoptions=pum
set wildignore+=*\\tmp\\*,*/tmp/*,*.so,*.swp,*.zip,*.exe,*.dll

let g:editorconfig = v:true

]]
