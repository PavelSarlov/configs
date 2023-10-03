local status_ok, neodev = pcall(require, "neodev")
if status_ok then
  neodev.setup()
end

local status_ok, lsp = pcall(require, "lspconfig")
if status_ok then
  local lsp_defaults = lsp.util.default_config

  lsp_defaults.capabilities =
      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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
    vim.diagnostic.open_float(0, {
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

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = "",
    }
    vim.lsp.buf.execute_command(params)
  end

  local opts_func = function(buf)
    return { buffer = buf }
  end
  local on_attach = function(ev)
    local opts = opts_func(ev.buf)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gm", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>m", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<a-f>", function()
      vim.lsp.buf.format({ async = true })
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
    mason_lsp = require("mason-lspconfig")

    mason.setup({
      install_root_dir = vim.g.MASONDIR,
    })
    mason_lsp.setup()
    mason_lsp.setup_handlers({
      function(server)
        lsp[server].setup({})
      end,
      ["tsserver"] = function(ev)
        lsp.tsserver.setup(vim.tbl_deep_extend("force", opts_func(ev.buf), {
          commands = {
            OrganizeImports = {
              organize_imports,
              description = "Organize Imports",
            },
          },
        }))
      end,
    })
  end
end
