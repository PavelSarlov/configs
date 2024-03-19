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
set omnifunc=syntaxcomplete#complete
set completeopt=menu,menuone,noselect,noinsert

set history=1000
set encoding=utf-8 fileencoding=utf-8
set nobackup nowritebackup noswapfile noundofile
set ignorecase smartcase
set incsearch
set hlsearch
set nrformats-=octal
set title
set ruler
set showmode
set showcmd
set splitbelow
set splitright
set wrap
set number
set cursorline
set clipboard+=unnamed,unnamedplus

set laststatus=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start

set expandtab
set smarttab
set autoread
set virtualedit=all
set t_vb=
set t_u7=
set novisualbell
set belloff=all
set hidden
set updatetime=300
set shortmess=acF
set signcolumn=yes
set relativenumber

set undofile
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

set cmdheight=3
]]
