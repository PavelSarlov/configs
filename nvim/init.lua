if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
	vim.opt.ff = "dos"

	vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
	vim.opt.shellcmdflag =
		"-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
	vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
	vim.opt.shellquote = nil
	vim.opt.shellxquote = nil
end

if vim.fn.has("unix") == 1 then
	vim.opt.ff = "unix"

	if vim.fn.executable("win32yank.exe") == 1 then
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
end

vim.env.VIMHOME = vim.fn.fnamemodify(vim.env.HOME, ":p") .. ".nvim"

local function setup_runtimepath()
	vim.cmd([[
    let s:after = fnamemodify($VIMHOME, ":p") . 'after'
    let s:autoload = fnamemodify($VIMHOME, ":p") . 'autoload'
    set runtimepath^=$VIMHOME
    let &runtimepath=&runtimepath . s:after
    let &packpath=&runtimepath
  ]])
end

setup_runtimepath()

vim.g.VIMUNDODIR = vim.fn.fnamemodify(vim.env.VIMHOME, ":p") .. "vimundo"
vim.fn["helpers#CreateDirRecursive"](vim.g.VIMUNDODIR)

require("plugins")

setup_runtimepath()

require("settings")
require("mappings")
require("augroups")
require("sessions")
require("configs")
