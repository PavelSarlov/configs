local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if status_ok then
	vim.g.PARSERDIR = vim.fn.fnamemodify(vim.env.VIMHOME, ":p") .. "parsers"

	vim.fn["helpers#CreateDirRecursive"](vim.g.PARSERDIR)

	vim.opt.runtimepath:append(vim.g.PARSERDIR)

	treesitter.setup({
		sync_install = false,
		auto_install = false,

		parser_install_dir = vim.g.PARSERDIR,

		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 10 * 1024 * 1024 -- 10 MB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		autotag = {
			enable = true,
		},
	})
end
