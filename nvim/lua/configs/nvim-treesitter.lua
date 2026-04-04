vim.env.CC = "gcc"

local status_ok, treesitter = pcall(require, "nvim-treesitter")
if status_ok then
	vim.g.PARSERDIR = vim.fn.fnamemodify(vim.env.VIMHOME, ":p") .. "parsers"

	vim.fn["helpers#CreateDirRecursive"](vim.g.PARSERDIR)

	vim.opt.runtimepath:append(vim.g.PARSERDIR)

	treesitter.setup({
		install_dir = vim.g.PARSERDIR,
	})
end
