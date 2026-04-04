local augroup_name = "FileChanged"

vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("FileChangedRO", {
	group = augroup_name,
	callback = function()
		vim.api.nvim_echo({ { "File changed RO.", "WarningMsg" } }, true, {})
	end,
})

vim.api.nvim_create_autocmd("FileChangedShell", {
	group = augroup_name,
	callback = function()
		local filename = vim.api.nvim_buf_get_name(0)
		vim.api.nvim_echo({ { string.format('File "%s" changed', filename), "WarningMsg" } }, true, {})
	end,
})
