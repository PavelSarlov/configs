local install_path = table.concat({ vim.fn.stdpath('data'), 'site', 'pack', 'packer', 'start', 'packer.nvim' },
  vim.g.SLASH)
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print "Installing packer close and reopen Neovim"
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

vim.g.PACKERDIR = table.concat({ vim.env.VIMHOME, 'packer' }, vim.g.SLASH)

vim.opt.runtimepath:append(table.concat({ vim.g.PACKERDIR, '*', 'start', '*' }, vim.g.SLASH))

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  package_root = vim.g.PACKERDIR
})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  use 'neovim/nvim-lspconfig'

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'rust-lang/rust.vim'
  use 'AndrewRadev/splitjoin.vim'
  use 'AndrewRadev/linediff.vim'
  use 'lambdalisue/nerdfont.vim'
  use 'jiangmiao/auto-pairs'
  use 'godlygeek/tabular'
  use 'OmniSharp/omnisharp-vim'

  use { 'SirVer/ultisnips',
    requires = { { 'honza/vim-snippets', rtp = '.' } },
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'norcalli/nvim-colorizer.lua'
  use 'petertriho/nvim-scrollbar'
  use 'gpanders/editorconfig.nvim'
  use 'sindrets/diffview.nvim'
  use 'folke/neodev.nvim'

  use 'nvim-lualine/lualine.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin.nvim' }
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
