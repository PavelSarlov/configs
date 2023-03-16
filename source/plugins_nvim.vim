Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'petertriho/nvim-scrollbar'
Plug 'gpanders/editorconfig.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'nvim-lualine/lualine.nvim'

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
"======================= scrollbar =========================
"===========================================================

lua << EOF
require("scrollbar").setup()
EOF

"==============================================================
"======================= catppuccin ===========================
"==============================================================

let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha

lua << EOF
require("catppuccin").setup()
EOF

colorscheme catppuccin

"==============================================================
"======================= lualine ==============================
"==============================================================

lua << END
require('lualine').setup()
END

