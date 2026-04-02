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
