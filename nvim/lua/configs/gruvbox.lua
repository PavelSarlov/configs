local status_ok, _ = pcall(require, "gruvbox")
if status_ok then
	vim.cmd("colorscheme gruvbox")
end
