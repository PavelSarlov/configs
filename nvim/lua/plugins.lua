local install_path =
	table.concat({ vim.fn.stdpath("data"), "site", "pack", "packer", "start", "packer.nvim" }, vim.g.SLASH)
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

vim.g.PACKERDIR = table.concat({ vim.env.VIMHOME, "packer" }, vim.g.SLASH)

vim.fn["helpers#CreateDirRecursive"](vim.g.PACKERDIR)

vim.opt.runtimepath:append(table.concat({ vim.g.PACKERDIR, "*", "start", "*" }, vim.g.SLASH))

packer.init({ package_root = vim.g.PACKERDIR })

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	use({ "ms-jpq/coq_nvim", branch = "coq" })
	use({ "ms-jpq/coq.artifacts", branch = "artifacts" })

	use("neovim/nvim-lspconfig")

	use("tpope/vim-surround")
	use("tpope/vim-fugitive")
	use("rust-lang/rust.vim")
	use("AndrewRadev/splitjoin.vim")
	use("AndrewRadev/linediff.vim")
	use("AndrewRadev/bufferize.vim")
	use("lambdalisue/nerdfont.vim")
	use("godlygeek/tabular")

	use("numToStr/Comment.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("windwp/nvim-ts-autotag")
	use("norcalli/nvim-colorizer.lua")
	use("petertriho/nvim-scrollbar")
	use("sindrets/diffview.nvim")
	use("folke/neodev.nvim")
	use("windwp/nvim-autopairs")
	use("hat0uma/csvview.nvim")

	use("nvim-lualine/lualine.nvim")
	use({ "catppuccin/nvim", as = "catppuccin.nvim" })
	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua")

	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
	})

	use("Hoffs/omnisharp-extended-lsp.nvim")
	use({ "williamboman/mason.nvim", requires = { "williamboman/mason-lspconfig.nvim" } })
	use({
		"jay-babu/mason-null-ls.nvim",
		requires = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
	})

	use("dstein64/vim-startuptime")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
