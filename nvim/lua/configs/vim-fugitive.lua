local status_ok, _ = pcall(require, "fugitive")
if status_ok then
	vim.keymap.set("n", "cm", "<cmd>tabedit % | Gvdiffsplit!<CR>", { silent = true })
	vim.keymap.set("n", "co", "<cmd>diffget //2<CR>", { silent = true })
	vim.keymap.set("n", "ct", "<cmd>diffget //3<CR>", { silent = true })
	vim.keymap.set("n", "cb", "<cmd>call helpers#GacceptBoth()<CR>", { silent = true })
	vim.keymap.set("n", "cs", "<cmd>only<CR>", { silent = true })
	vim.keymap.set("n", "cu", "<cmd>diffupdate<CR>", { silent = true })
end
