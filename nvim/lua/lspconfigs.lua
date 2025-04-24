local status_ok, neodev = pcall(require, "neodev")
if status_ok then
	neodev.setup()
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev() })
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next() })
end)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
})

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(winid).zindex then
			return
		end
	end
	-- THIS IS FOR BUILTIN LSP
	vim.diagnostic.open_float({}, {
		scope = "cursor",
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	})
end

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	command = "lua OpenDiagnosticIfNoFloat()",
	group = "lsp_diagnostics_hold",
})

local function organize_imports(client)
	local bufnr = vim.api.nvim_get_current_buf()
	client:exec_cmd(
		{ command = "_typescript.organizeImports", title = "", arguments = { vim.api.nvim_buf_get_name(bufnr) } },
		{ bufnr }
	)
end

local ok_telescope, telescope = pcall(require, "telescope.builtin")

local on_attach = function(ev)
	local opts = { buffer = ev.buf }

	vim.keymap.set("n", "gD", ok_telescope and telescope.lsp_declarations or vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", ok_telescope and telescope.lsp_definitions or vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", ok_telescope and telescope.lsp_references or vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", ok_telescope and telescope.lsp_implementations or vim.lsp.buf.implementation, opts)
	vim.keymap.set(
		"n",
		"<leader>D",
		ok_telescope and telescope.lsp_type_definitions or vim.lsp.buf.type_definition,
		opts
	)
	vim.keymap.set("n", "gm", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>m", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<a-f>", function()
		vim.lsp.buf.format({
			async = true,
			filter = function(client)
				return client.name == "null-ls" or client.name == "omnisharp" or client.name == "lemminx"
			end,
		})
	end, opts)
	vim.keymap.set("n", "<a-o>", "<cmd>OrganizeImports<cr>", opts)
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("Userlsp", {}),
	callback = on_attach,
})

-- ==============================================================
-- ======================= mason ================================
-- ==============================================================

vim.g.MASONDIR = table.concat({ vim.env.VIMHOME, "mason" }, vim.g.SLASH)

vim.fn["helpers#CreateDirRecursive"](vim.g.MASONDIR)

local status_ok, mason = pcall(require, "mason")
if status_ok then
	local mason_lsp = require("mason-lspconfig")

	mason.setup({
		install_root_dir = vim.g.MASONDIR,
	})
	mason_lsp.setup()
	mason_lsp.setup_handlers({
		function(server)
			vim.lsp.enable(server)
		end,
		["angularls"] = function(ev)
			vim.lsp.config(ev, {
				cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					vim.g.MASONDIR .. "/packages/angular-language-server/node_modules/@angular/language-server",
					"--ngProbeLocations",
					vim.g.MASONDIR .. "/packages/angular-language-server/node_modules/@angular/language-server",
				},
			})
			vim.lsp.enable(ev)
		end,
		["ts_ls"] = function(ev)
			vim.lsp.config(ev, {
				on_attach = function(client, buf)
					on_attach({ buf = buf })
					vim.api.nvim_buf_create_user_command(buf, "OrganizeImports", function()
						organize_imports(client)
					end, {})
				end,
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "non-relative",
						importModuleSpecifierEnding = "minimal",
					},
				},
			})
			vim.lsp.enable(ev)
		end,
		["lua_ls"] = function(ev)
			vim.lsp.config(ev, {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			})
			vim.lsp.enable(ev)
		end,
		["omnisharp"] = function(ev)
			local ext = require("omnisharp_extended")
			vim.lsp.config(ev, {
				on_attach = function(_, buf)
					on_attach({ buf = buf })
					local opts = { buffer = buf }
					vim.keymap.set(
						"n",
						"gd",
						ok_telescope and ext.telescope_lsp_definition or vim.lsp.buf.definition,
						opts
					)
					vim.keymap.set(
						"n",
						"<leader>D",
						ok_telescope and ext.telescope_lsp_type_definition or vim.lsp.buf.type_definition,
						opts
					)
					vim.keymap.set(
						"n",
						"gr",
						ok_telescope and ext.telescope_lsp_references or vim.lsp.buf.references,
						opts
					)
					vim.keymap.set(
						"n",
						"gi",
						ok_telescope and ext.telescope_lsp_implementation or vim.lsp.buf.implementation,
						opts
					)
				end,
			})
			vim.lsp.enable(ev)
		end,
	})
end

-- ==============================================================
-- ======================= null-ls ==============================
-- ==============================================================

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if status_ok then
	local null_ls = require("null-ls")
	null_ls.setup({})

	mason_null_ls.setup({
		automatic_installation = false,
		handlers = {
			xmlformatter = function()
				null_ls.register(null_ls.builtins.formatting.xmllint)
			end,
			prettierd = function()
				null_ls.register(null_ls.builtins.formatting.prettierd.with({
					filetypes = {
						"css",
						"graphql",
						"html",
						"htmlangular",
						"javascript",
						"javascriptreact",
						"json",
						"jsonc",
						"less",
						"markdown",
						"scss",
						"typescript",
						"typescriptreact",
						"yaml",
					},
					prefer_local = "node_modules/.bin",
				}))
			end,
			eslint_d = function()
				null_ls.register(require("none-ls.diagnostics.eslint_d").with({
					diagnostics = {
						enable = true,
						report_unused_disable_directives = false,
						run_on = "type", -- or `save`
					},
				}))
			end,
		},
	})
end
