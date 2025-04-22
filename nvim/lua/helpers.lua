local helpers = {}

function helpers.find_git_root()
	local pwd = vim.fn.getcwd()
	local dir = (
		(vim.fn.empty(vim.bo.ft) == 1 or string.match(string.lower(vim.bo.ft), "terminal") and ".")
		or string.match(string.lower(vim.bo.ft), "netrw") and vim.fn.expand("%")
	) or vim.fn.expand("%:p:h")
	if vim.fn.isdirectory(dir) == 1 then
		pwd = dir
	end
	local get_root = function()
		return require("plenary.job")
			:new({ command = "git", args = { "rev-parse", "--show-toplevel" }, cwd = pwd })
			:sync()[1]
	end
	local status, result = pcall(get_root)
	return status and result or pwd
end

return helpers
