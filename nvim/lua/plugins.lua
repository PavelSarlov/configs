vim.g.LAZYPATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(vim.g.LAZYPATH) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, vim.g.LAZYPATH })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(vim.g.LAZYPATH)

local status, lazy = pcall(require, "lazy")
if status then
	lazy.setup({
		spec = {
			"wbthomason/packer.nvim",
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",

			{
				"saghen/blink.cmp",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
			},

			"neovim/nvim-lspconfig",

			"tpope/vim-surround",
			"tpope/vim-fugitive",
			"rust-lang/rust.vim",
			"AndrewRadev/splitjoin.vim",
			"AndrewRadev/linediff.vim",
			"AndrewRadev/bufferize.vim",
			"lambdalisue/nerdfont.vim",
			"godlygeek/tabular",

			"numToStr/Comment.nvim",
			"windwp/nvim-ts-autotag",
			"norcalli/nvim-colorizer.lua",
			"petertriho/nvim-scrollbar",
			"sindrets/diffview.nvim",
			"folke/neodev.nvim",
			"windwp/nvim-autopairs",
			"hat0uma/csvview.nvim",

			"nvim-lualine/lualine.nvim",
			{
				"nvim-neo-tree/neo-tree.nvim",
				branch = "v3.x",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"MunifTanjim/nui.nvim",
					"nvim-tree/nvim-web-devicons",
					"s1n7ax/nvim-window-picker",
				},
			},
			{
				"antosha417/nvim-lsp-file-operations",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
			},

			{
				"nvim-telescope/telescope.nvim",
				branch = "0.1.x",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"nvim-telescope/telescope-fzf-native.nvim",
					"nvim-telescope/telescope-ui-select.nvim",
				},
			},

			"Hoffs/omnisharp-extended-lsp.nvim",

			{
				"williamboman/mason.nvim",
				dependencies = { "williamboman/mason-lspconfig.nvim" },
			},
			{
				"jay-babu/mason-null-ls.nvim",
				dependencies = {
					"williamboman/mason.nvim",
					"nvimtools/none-ls.nvim",
					"nvimtools/none-ls-extras.nvim",
				},
			},

			"dstein64/vim-startuptime",

			{ "nvim-treesitter/nvim-treesitter", lazy = false, branch = "master" },
			{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
		},

		checker = { enabled = true, notify = false },
	})
end
