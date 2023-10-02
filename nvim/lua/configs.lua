-- ===========================================================
-- ======================= colorizer =========================
-- ===========================================================

vim.opt.termguicolors = true

local status_ok, colorizer = pcall(require, 'colorizer')
if status_ok then
  colorizer.setup()
end

-- ===========================================================
-- ======================= scrollbar =========================
-- ===========================================================

local status_ok, scrollbar = pcall(require, 'scrollbar')
if status_ok then
  scrollbar.setup()
end

-- ==============================================================
-- ======================= catppuccin ===========================
-- ==============================================================

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

local status_ok, catppuccin = pcall(require, 'catppuccin')
if status_ok then
  catppuccin.setup()
  vim.cmd("colorscheme catppuccin")
end

-- ==============================================================
-- ======================= lualine ==============================
-- ==============================================================

local status_ok, lualine = pcall(require, 'lualine')
if status_ok then
  lualine.setup()
end

-- ==============================================================
-- ======================= treesitter ===========================
-- ==============================================================

local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if status_ok then
  vim.g.PARSERDIR = table.concat({ vim.env.VIMHOME, 'parsers' }, vim.g.SLASH)

  if vim.fn.isdirectory(vim.g.PARSERDIR) ~= 1 then
    vim.fn.mkdir(vim.g.PARSERDIR, "p")
  end

  vim.opt.runtimepath:append(vim.g.PARSERDIR)

  treesitter.setup {
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
  }
end

-- ==============================================================
-- ======================= telescope ============================
-- ==============================================================

local status_ok, telescope = pcall(require, 'telescope')
if status_ok then
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local actions_layout = require("telescope.actions.layout")

  vim.keymap.set('n', '<c-p>', builtin.find_files, { silent = true, nowait = true, noremap = true })
  vim.keymap.set('n', '<a-S>', builtin.live_grep, { silent = true, nowait = true, noremap = true })
  vim.keymap.set('n', '<c-l>', builtin.buffers, { silent = true, nowait = true, noremap = true })
  vim.keymap.set('n', '<c-g>', builtin.help_tags, { silent = true, nowait = true, noremap = true })

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<a-p>"] = actions_layout.toggle_preview,
          ['<c-s>'] = actions.select_horizontal
        }
      },
    },
    file_ignore_patterns = { ".git/*" , ".hg/*'" , ".svn/*" , "node_modules/*" , "DS_Store/*" , "target/*" , "dist/*" , "obj/*" , "build/*" }
  })
end

-- ==============================================================
-- ======================= fugitive =============================
-- ==============================================================

vim.keymap.set('n', 'cm', '<cmd>tabedit % | Gvdiffsplit!<CR>', { silent = true })
vim.keymap.set('n', 'co', '<cmd>diffget //2<CR>', { silent = true })
vim.keymap.set('n', 'ct', '<cmd>diffget //3<CR>', { silent = true })
vim.keymap.set('n', 'cb', '<cmd>call helpers#GacceptBoth()<CR>', { silent = true })
vim.keymap.set('n', 'cs', '<cmd>only<CR>', { silent = true })
vim.keymap.set('n', 'cu', '<cmd>diffupdate<CR>', { silent = true })

-- ==============================================================
-- ======================= auto-pairs ===========================
-- ==============================================================

vim.g.AutoPairsShortcutToggle = ''

-- ==============================================================
-- ======================= completion ===========================
-- ==============================================================

vim.cmd [[ 

autocmd BufEnter * lua require'completion'.on_attach() 
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

]]

-- ==============================================================
-- ======================= nvim-tree ============================
-- ==============================================================

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function nvim_tree_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require("nvim-tree").setup({
  on_attach = nvim_tree_on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
})

vim.keymap.set('n', '<space>e', '<cmd>NvimTreeOpen<cr>', { silent = true, nowait = true, noremap = true })
