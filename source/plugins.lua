local Plug = vim.fn['plug#']

Plug('norcalli/nvim-colorizer.lua')
Plug('nvim-treesitter/nvim-treesitter', {do = ':TSUpdate'})
Plug('petertriho/nvim-scrollbar')
Plug('gpanders/editorconfig.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('sindrets/diffview.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('catppuccin/nvim', {as = 'catppuccin'})
Plug('nvim-lualine/lualine.nvim')

-- ===========================================================
-- ======================= treesitter ========================
-- ===========================================================

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

-- ===========================================================
-- ======================= colorizer =========================
-- ===========================================================

require('colorizer').setup()

-- ===========================================================
-- ======================= scrollbar =========================
-- ===========================================================

require("scrollbar").setup()

-- ==============================================================
-- ======================= catppuccin ===========================
-- ==============================================================

vim.g.catppuccin_flavour = "macchiato" -- late, frappe, macchiato, mocha

require("catppuccin").setup()

vim.cmd("colorscheme catppuccin")

-- ==============================================================
-- ======================= lualine ==============================
-- ==============================================================

require('lualine').setup()

