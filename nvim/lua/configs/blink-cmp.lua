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

		fuzzy = { implementation = "prefer_rust_with_warning" },

		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<Enter>"] = { "accept", "snippet_forward", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},
	})
end
