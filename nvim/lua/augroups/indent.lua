local augroup_name = "AutoIndent"

vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.bo.autoindent = true
		vim.bo.smartindent = true
		vim.bo.cindent = true
	end,
})
