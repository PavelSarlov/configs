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
  use 'nvim-lua/completion-nvim'

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
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'norcalli/nvim-colorizer.lua'
  use 'petertriho/nvim-scrollbar'
  use 'gpanders/editorconfig.nvim'
  use 'sindrets/diffview.nvim'

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

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
