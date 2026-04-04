local max_filesize = 10 * 1024 * 1024 -- 10 MB
local augroup_name = "LargeFilesTsDisable"

local function try_disable_buf(file, buf)
	local ok, stats = pcall(vim.loop.fs_stat, file)
	if ok and stats and stats.size > max_filesize then
		vim.b[buf].ts_disabled = true
		vim.treesitter.stop(buf)
	end
end

vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
	group = augroup_name,
	callback = function(args)
		try_disable_buf(args.file, args.buf)
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileType", "BufWinEnter" }, {
	group = augroup_name,
	callback = function(args)
		if vim.b[args.buf].ts_disabled then
			vim.treesitter.stop(args.buf)
		end
	end,
})

vim.schedule(function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local file = vim.api.nvim_buf_get_name(buf)
			if file ~= "" then
				try_disable_buf(file, buf)
				vim.treesitter.stop(buf)
			end
		end
	end
end)
