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
-- ======================= telescope ============================
-- ==============================================================

local status_ok, telescope = pcall(require, "telescope")
if status_ok then
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local actions_layout = require("telescope.actions.layout")

  vim.keymap.set("n", "<c-p>", function()
    local git_root = vim.fn["helpers#FindGitRoot"]()
    builtin.find_files({ hidden = true, no_ignore = true, cwd = git_root })
  end, { silent = true, nowait = true, noremap = true })
  vim.keymap.set("n", "<a-S>", function()
    local git_root = vim.fn["helpers#FindGitRoot"]()
    builtin.grep_string({
      shorten_names = true,
      word_match = "-w",
      only_sort_text = false,
      search = "",
      cwd = git_root,
      additional_args = { '-u' }
    })
  end, { silent = true, nowait = true, noremap = true })
  vim.keymap.set("n", "<c-l>", builtin.buffers, { silent = true, nowait = true, noremap = true })
  vim.keymap.set("n", "<c-g>", builtin.help_tags, { silent = true, nowait = true, noremap = true })

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<a-p>"] = actions_layout.toggle_preview,
          ["<c-s>"] = actions.select_horizontal,
        },
      },
      file_ignore_patterns = {
        ".git/*",
        ".hg/*",
        ".svn/*",
        "node_modules/*",
        "DS_Store/*",
        "target/*",
        "dist/*",
        "obj/*",
        "build/*",
        "package-lock.json",
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

  vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
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
      update_cwd = true,
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
