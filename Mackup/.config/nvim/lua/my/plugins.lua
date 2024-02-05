-- https://github.com/folke/lazy.nvim
-- :help lazy.nvim.txt
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-sleuth",
  "mbbill/undotree",
  "moll/vim-bbye",
  "RRethy/vim-illuminate",
  "akinsho/toggleterm.nvim",
  require("my.none-ls"),
  -- {
  --   "sourcegraph/sg.nvim",
  --   config = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  "akinsho/bufferline.nvim",
  {
    "David-Kunz/jester",
    opts = {
      cmd = "npx jest test -t '$result' -- $file",
    },
  },
  require("my.mkdnflow"),
  require("my.telescope"),
  require("my.project"),
  require("my.gitsigns"),
  require("my.autoformat"),
  require("my.debug"),
  require("my.nvim-tree"),
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", tag = "legacy", config = true },
      { "folke/neodev.nvim", config = true },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = { { "filename", path = 3, shorting_target = 80 } },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- :help ibl
    main = "ibl",
    config = true,
  },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}, {})
