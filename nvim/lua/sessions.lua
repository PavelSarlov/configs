vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,help,localoptions"

vim.g.SESSIONLOC = vim.fn.fnamemodify(vim.env.VIMHOME, ":p") .. "sessions"

vim.fn["helpers#CreateDirRecursive"](vim.g.SESSIONLOC)

local function GetSessionPath()
  return vim.fn.fnamemodify(vim.g.SESSIONLOC, ":p") .. (vim.fn.sha256(vim.fn.getcwd()) .. ".vim")
end

function MakeSession()
	local session_path = GetSessionPath()
	if vim.fn.filewritable(session_path) ~= 2 then
		vim.cmd("mksession! " .. session_path)
		vim.cmd("redraw!")
	end
end

function LoadSession()
	local session_path = GetSessionPath()
	if vim.fn.filereadable(session_path) == 1 then
		vim.cmd("source " .. session_path)
	else
		print("No session loaded.")
	end
end

-- Adding automatons for when entering or leaving Vim
if vim.fn.argc() == 0 then
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		pattern = "*",
		callback = LoadSession,
	})
end
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	pattern = "*",
	callback = function()
		MakeSession()
		vim.cmd("sleep 10m")
	end,
})

return {
	make_session = MakeSession,
	load_session = LoadSession,
}
