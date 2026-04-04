local augroup_name = "FileTypes"

vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ejs",
	callback = function()
		vim.bo.filetype = "html"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.json",
	callback = function()
		vim.bo.filetype = "jsonc"
	end,
})

vim.api.nvim_create_autocmd("SessionLoadPost", {
	callback = function()
		vim.schedule(function()
			vim.cmd("windo filetype detect")
		end)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.cmd("filetype detect")
	end,
})
