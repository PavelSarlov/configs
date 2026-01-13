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
			disable = function(_, buf)
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

	for _, extension in ipairs({ "fzf", "ui-select" }) do
		local status_ext, err = pcall(telescope.load_extension, extension)
		if not status_ext then
			print("failed to load " .. extension .. " extension", err)
		end
	end
end

-- ==============================================================
-- ======================= fugitive =============================
-- ==============================================================

local status_ok, _ = pcall(require, "fugitive")
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
-- ======================= blink.cmp ============================
-- ==============================================================

local status_ok, blink = pcall(require, "blink.cmp")
if status_ok then
	blink.setup({
		completion = {
			documentation = { auto_show = true },
			list = {
				selection = {
					preselect = true,
					auto_insert = true,
				},
			},
			ghost_text = {
				enabled = true,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },

			providers = {
				buffer = {
					opts = {
						get_bufnrs = vim.api.nvim_list_bufs,
					},
				},
			},
		},

		fuzzy = { implementation = "lua" },

		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<Enter>"] = { "accept", "snippet_forward", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},
	})
end

-- ==============================================================
-- ======================= neo-tree =============================
-- ==============================================================

local status_ok, neo = pcall(require, "neo-tree")
if status_ok then
	neo.setup({
		use_libuv_file_watcher = true,
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = "open_default",
			window = {
				mappings = {
					["e"] = "open_with_window_picker",
					["s"] = "split_with_window_picker",
					["E"] = "vsplit_with_window_picker",
					["Y"] = function(state)
						-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
						-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local filename = node.name
						local modify = vim.fn.fnamemodify

						local results = {
							filepath,
							modify(filepath, ":."),
							modify(filepath, ":~"),
							filename,
							modify(filename, ":r"),
							modify(filename, ":e"),
						}

						vim.ui.select({
							"Absolute path: " .. results[1],
							"Path relative to CWD: " .. results[2],
							"Path relative to HOME: " .. results[3],
							"Filename: " .. results[4],
							"Filename without extension: " .. results[5],
							"Extension of the filename: " .. results[6],
						}, { prompt = "Choose to copy to clipboard:" }, function(_, i)
							local result = results[i]
							vim.fn.setreg("+", result)
						end)
					end,
				},
			},
		},
		container = {
			width = "100%",
			right_padding = 1,
			content = {
				{
					"name",
					use_git_status_colors = true,
					zindex = 10,
				},
				{ "diagnostics", zindex = 20, align = "right" },
				{ "git_status", zindex = 20, align = "right" },
			},
		},
	})

	vim.keymap.set("n", "<space>e", "<cmd>Neotree<cr>", { silent = true, nowait = true, noremap = true })
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
