local augroup_name = "FileSave"

vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup_name,
	callback = function()
		vim.fn["helpers#RemoveCarriageReturn"]()
	end,
})
