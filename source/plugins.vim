call plug#begin(g:PLUGGEDDIR)

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'rust-lang/rust.vim'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/linediff.vim'

Plug 'lambdalisue/nerdfont.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'aperezdc/vim-template'

Plug 'godlygeek/tabular'

Plug 'OmniSharp/omnisharp-vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'ctrlpvim/ctrlp.vim'

if has("nvim")
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'petertriho/nvim-scrollbar'
  Plug 'gpanders/editorconfig.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'

  Plug 'nvim-lualine/lualine.nvim'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'nvim-tree/nvim-web-devicons'
else
  Plug 'sheerun/vim-polyglot'

  Plug 'itchyny/lightline.vim'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'ryanoasis/vim-devicons'
endif

call plug#end()
