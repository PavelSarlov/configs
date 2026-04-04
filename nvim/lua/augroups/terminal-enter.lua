local augroup_name = "TerminalEnter"

vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup_name,
	callback = function()
		vim.bo.filetype = "terminal"
	end,
})
