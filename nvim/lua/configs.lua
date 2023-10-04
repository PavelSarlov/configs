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
    auto_install = true,

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
  })
end

-- ==============================================================
-- ======================= fzf-lua ==============================
-- ==============================================================

local status_ok, fzf = pcall(require, "fzf-lua")
if status_ok then
  fzf.setup({
    winopts = {
      preview = {
        horizontal = 'right:40%'
      },
    },
    keymap = {
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      }
    }
  })

  vim.keymap.set("n", "<c-p>", function()
    local git_root = vim.fn["helpers#FindGitRoot"]()
    fzf.files({ path_shorten = true, no_ignore = true, cwd = git_root })
  end, { silent = true, nowait = true, noremap = true })
  vim.keymap.set("n", "<a-S>", function()
    local git_root = vim.fn["helpers#FindGitRoot"]()
    fzf.grep_project({ cwd = git_root, path_shorten = true })
  end, { silent = true, nowait = true, noremap = true })
  vim.keymap.set("n", "<c-l>", fzf.buffers, { silent = true, nowait = true, noremap = true })
  vim.keymap.set("n", "<c-g>", fzf.tags, { silent = true, nowait = true, noremap = true })
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
-- ======================= nvim-cmp =============================
-- ==============================================================

local status_ok, cmp = pcall(require, "cmp")
if status_ok then
  local luasnip = require("luasnip")

  require("cmp_nvim_lsp").setup({})

  cmp.register_source("buffer", require("cmp_buffer"))
  cmp.register_source("cmdline", require("cmp_cmdline").new())
  cmp.register_source("path", require("cmp_path"))
  cmp.register_source("nvim_lua", require("cmp_nvim_lua").new())
  cmp.register_source("luasnip", require("cmp_luasnip").new())

  local status_ok_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  if status_ok_autopairs then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          cmp.complete()
        end
      end, { "i", "s", "c" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s", "c" }),
      ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
      ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
      ["<C-n>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Down>"), "n", true)
        end
      end, { "i", "c" }),
      ["<C-p>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Up>"), "n", true)
        end
      end, { "i", "c" }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() ~= nil then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end, { "i", "c" }),
    },
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
        cmp.TriggerEvent.InsertEnter,
      },
      completeopt = "menu,menuone,noinsert,noselect",
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua", option = { include_deprecated = true } },
      { name = "path" },
    },
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "cmdline" },
      { name = "path" },
      { name = "buffer" },
    },
  })
end

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
    disable_netrw = true,
    hijack_netrw = true,
  })

  vim.keymap.set("n", "<space>e", "<cmd>NvimTreeOpen<cr>", { silent = true, nowait = true, noremap = true })
end

-- ==============================================================
-- ======================= null-ls ==============================
-- ==============================================================

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if status_ok then
  local null_ls = require('null-ls')

  mason_null_ls.setup({
    ensure_installed = { 'prettierd' },
    handlers = {
      prettierd = function(source_name, methods)
        null_ls.register(null_ls.builtins.formatting.prettierd.with({
          filetypes = {
            "css",
            "graphql",
            "html",
            "javascript",
            "javascriptreact",
            "json",
            "less",
            "markdown",
            "scss",
            "typescript",
            "typescriptreact",
            "yaml",
          },
          only_local = "node_modules/.bin",
        }))
      end,
    },
  })
end
