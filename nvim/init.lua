if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
	vim.opt.ff = "dos"

	vim.g.SLASH = "\\"

	vim.opt.shell = vim.fn["executable"]("pwsh") and "pwsh" or "powershell"
	vim.opt.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
	vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
	vim.opt.shellquote = nil
	vim.opt.shellxquote = nil
end

if vim.fn.has("unix") == 1 then
	vim.opt.ff = "unix"

	vim.g.SLASH = "/"

	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

vim.env.VIMHOME = table.concat({ vim.env.HOME, ".nvim" }, vim.g.SLASH)

vim.cmd([[
  let s:after = $VIMHOME . g:SLASH . 'after'
  let s:autoload = $VIMHOME . g:SLASH . 'autoload'
  set runtimepath^=$VIMHOME
  let &runtimepath=&runtimepath . s:after
  let &packpath=&runtimepath
]])

vim.g.VIMUNDODIR = table.concat({ vim.env.VIMHOME, "vimundo" }, vim.g.SLASH)
vim.fn["helpers#CreateDirRecursive"](vim.g.VIMUNDODIR)

require("settings")
require("mappings")
require("augroups")
require("sessions")
require("plugins")
require("configs")
require("lspconfigs")
