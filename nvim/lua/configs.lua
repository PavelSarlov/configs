-- ===========================================================
-- ======================= colorizer =========================
-- ===========================================================

vim.opt.termguicolors = true

local status_ok, colorizer = pcall(require, "colorizer")
if status_ok then
	colorizer.setup()
end

-- ===========================================================
-- ======================= scrollbar =========================
-- ===========================================================

local status_ok, scrollbar = pcall(require, "scrollbar")
if status_ok then
	scrollbar.setup()
end

-- ==============================================================
-- ======================= catppuccin ===========================
-- ==============================================================

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

local status_ok, catppuccin = pcall(require, "catppuccin")
if status_ok then
	catppuccin.setup()
	vim.cmd("colorscheme catppuccin")
end

-- ==============================================================
-- ======================= lualine ==============================
-- ==============================================================

local status_ok, lualine = pcall(require, "lualine")
if status_ok then
	lualine.setup()
end

-- ==============================================================
-- ======================= treesitter ===========================
-- ==============================================================

local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if status_ok then
	vim.g.PARSERDIR = table.concat({ vim.env.VIMHOME, "parsers" }, vim.g.SLASH)

	vim.fn["helpers#CreateDirRecursive"](vim.g.PARSERDIR)

	vim.opt.runtimepath:append(vim.g.PARSERDIR)

	treesitter.setup({
		sync_install = false,
		auto_install = false,

		parser_install_dir = vim.g.PARSERDIR,

		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max_filesize = 10 * 1024 * 1024 -- 10 MB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		autotag = {
			enable = true,
		},
	})
end

-- ==============================================================
-- ======================= telescope ============================
-- ==============================================================

local status_ok, telescope = pcall(require, "telescope")
if status_ok then
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")
	local actions_layout = require("telescope.actions.layout")

	local helpers = require("helpers")

	vim.keymap.set("n", "<c-p>", function()
		local git_root = helpers.find_git_root()
		builtin.find_files({ hidden = true, no_ignore = true, cwd = git_root, additional_args = { "--sort" } })
	end, { silent = true, nowait = true, noremap = true })
	vim.keymap.set("n", "<a-S>", function()
		local git_root = helpers.find_git_root()
		builtin.grep_string({
			word_match = "-w",
			only_sort_text = true,
			search = "",
			cwd = git_root,
			additional_args = { "--hidden", "--max-filesize", "10M" },
		})
	end, { silent = true, nowait = true, noremap = true })
	vim.keymap.set("n", "<c-l>", builtin.buffers, { silent = true, nowait = true, noremap = true })
	vim.keymap.set("n", "<c-g>", builtin.help_tags, { silent = true, nowait = true, noremap = true })

	telescope.setup({
		defaults = {
			dynamic_preview_title = true,
			preview = { hide_on_startup = true },
			path_display = { "smart" },
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<a-p>"] = actions_layout.toggle_preview,
					["<c-s>"] = actions.select_horizontal,
				},
			},
			file_ignore_patterns = {
				"%.git[\\/].*",
				"%.hg[\\/].*",
				"%.svn[\\/].*",
				"node_modules[\\/].*",
				"DS_Store[\\/].*",
				"target[\\/].*",
				"dist[\\/].*",
				"obj[\\/].*",
				"build[\\/].*",
				"package-lock",
				"poetry-lock",
			},
		},
	})

	telescope.load_extension("fzf")
end

-- ==============================================================
-- ======================= fugitive =============================
-- ==============================================================

local status_ok, fugitive = pcall(require, "fugitive")
if status_ok then
	vim.keymap.set("n", "cm", "<cmd>tabedit % | Gvdiffsplit!<CR>", { silent = true })
	vim.keymap.set("n", "co", "<cmd>diffget //2<CR>", { silent = true })
	vim.keymap.set("n", "ct", "<cmd>diffget //3<CR>", { silent = true })
	vim.keymap.set("n", "cb", "<cmd>call helpers#GacceptBoth()<CR>", { silent = true })
	vim.keymap.set("n", "cs", "<cmd>only<CR>", { silent = true })
	vim.keymap.set("n", "cu", "<cmd>diffupdate<CR>", { silent = true })
end

-- ==============================================================
-- ======================= nvim-autopairs =======================
-- ==============================================================

local status_ok, autopairs = pcall(require, "nvim-autopairs")
if status_ok then
	autopairs.setup({})
end

-- ==============================================================
-- ======================= coq.nvim =============================
-- ==============================================================

vim.g.coq_settings = {
	auto_start = true,
}

-- ==============================================================
-- ======================= nvim-tree ============================
-- ==============================================================

local function nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "e", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "E", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
	vim.keymap.set("n", "F", api.tree.search_node, opts("Search"))
	vim.keymap.set("n", "S", api.node.run.system, opts("Run System"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if status_ok then
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	nvim_tree.setup({
		on_attach = nvim_tree_on_attach,
		sort_by = "case_sensitive",
		view = {
			width = 30,
		},
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
		},
		disable_netrw = false,
		hijack_netrw = true,
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	})

	vim.keymap.set("n", "<space>e", "<cmd>NvimTreeOpen<cr>", { silent = true, nowait = true, noremap = true })
end

-- ==============================================================
-- ======================= comment.nvim =========================
-- ==============================================================

local status_ok, comment = pcall(require, "Comment")
if status_ok then
	comment.setup()
end

-- ==============================================================
-- ======================= csvview.nvim =========================
-- ==============================================================

local status_ok, csvview = pcall(require, "csvview")
if status_ok then
	csvview.setup()
end
